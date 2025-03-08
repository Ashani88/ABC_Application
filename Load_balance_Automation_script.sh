#!/bin/bash

# Export Configuration
source configuration.env
ROUND_ROBIN=true


check_server_status() {
    local server_ip="$1"
    local timeout=2 


     ping -c 1 -W $timeout $server_ip &> /dev/null
    if [ $? -eq 0 ]; then
     return 0 # Server is healthy
     else
       return 1 # Server is unhealthy
     fi
    return 0
}

# Main loop
counter=0
while true; do
    # Get the next server in the list
    local server_ip
    if $ROUND_ROBIN; then
        counter=$((counter % ${#SERVER_LIST[@]}))
        server_ip="${SERVER_LIST[$counter]}"
    else
    
        server_ip=""
        for ip in "${SERVER_LIST[@]}"; do
            if check_server_health "$ip" ; then
                server_ip="$ip"
                break
            fi
        done
        if [ -z "$server_ip" ]; then
            echo "No healthy servers available"
            sleep 5 
            continue
        fi
    fi
    
       echo "Forwarding traffic to $server_ip"

iptables -t nat -A PREROUTING -p tcp --dport $PORT -j DNAT --to-destination $server_ip:$PORT
   
    counter=$((counter+1))
done
