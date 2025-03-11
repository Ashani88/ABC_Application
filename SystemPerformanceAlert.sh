#!/bin/bash

# Thresholds 
source ./Threshold_Config.sh

# Function to check CPU usage
check_cpu() {
  CPU_USAGE=$(top -n 1 | grep "Cpu(s)" | awk '{print $2}' | cut -d "." -f 1)
  if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "ALERT: CPU usage is above $CPU_THRESHOLD% ($CPU_USAGE%)"
    return 1  
  fi
  return 0
}

# Function to check memory usage
check_memory() {
  MEMORY_USAGE=$(free -m | grep "Mem" | awk '{print $3}' | cut -d "." -f 1)
  MEMORY_TOTAL=$(free -m | grep "Mem" | awk '{print $2}' | cut -d "." -f 1)
  MEMORY_PERCENTAGE=$((MEMORY_USAGE / MEMORY_TOTAL * 100))
  if [ "$MEMORY_PERCENTAGE" -gt "$MEMORY_THRESHOLD" ]; then
    echo "ALERT: Memory usage is above $MEMORY_THRESHOLD% ($MEMORY_PERCENTAGE%)"
    return 1
  fi
  return 0
}

# Function to check disk usage
check_disk() {
  DISK_USAGE=$(df -h / | grep -v "Filesystem" | awk '{print $5}' | cut -d "%" -f 1)
  if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "ALERT: Disk usage is above $DISK_THRESHOLD% ($DISK_USAGE%)"
    return 1
  fi
  return 0
}

# Main script
cpu_alert_flag=0
memory_alert_flag=0
disk_alert_flag=0

# Check CPU
if check_cpu; then
  cpu_alert_flag=1
fi

# Check Memory
if check_memory; then
  memory_alert_flag=1
fi

# Check Disk
if check_disk; then
  disk_alert_flag=1
fi

# Send email alters
if [ "$cpu_alert_flag" -eq 1 ]; then
  echo "System Performance Alert:'date +%Y-%m-%d'" | mail -s "CPU Threshold $CPU_THRESHOLD% Exeeded" ASPAGROUP@gvt.com
fi
if [ "$memory_alert_flag" -eq 1 ]; then
  echo "System Performance Alert:'date +%Y-%m-%d'" | mail -s "Memory Threshold $MEMORY_THRESHOLD% Exeeded" ASPAGROUP@gvt.com
fi
if [ "$disk_alert_flag" -eq 1 ]; then
  echo "System Performance Alert:'date +%Y-%m-%d'" | mail -s Disk Space Threshold $DISK_THRESHOLD% Exeeded" ASPAGROUP@gvt.com
fi

exit 0
