# ABC_Application
// System Improvements


// Load balancing: 
Step 1: Login to the Linux server with user who has relevant access. 

Step 2: Place both configuration.env and Load_balance_Automation_script.sh files in below path of all 3 servers:
             /emea/SRC/SE001

Step 3: Grant execution permission.
chmod +x /emea/SRC/SE001/configuration.env
chmod +x /emea/SRC/SE001/Load_balance_Automation_script.sh

Step 3: Update IP list and port in configuration.env file.

Step 4: Run the script in daemon mode in each server.

On Server ‘172.147.1.24’, ‘172.16.11.3’ and ‘172.18.1.17’:

•	Edit the crontab using crontab –e
•	Add the following line to schedule the script to run 10 minutes past every hour:

@reboot nohup /path/to/your/script.sh >/emea/SRC/logs 2>&1 &



//Weekly Performance Summary Report:

Step 1: Login to the Linux server with user who has relevant access. 

Step 2: Place vmstat_script.sh file in below path of the server:
             /emea/SRC/bin

Step 3: Grant execution permission.
chmod +x /emea/SRC/bin/vmstat_script.sh

Step 4: Create the cron job to schedule the vmstat_script.sh script in each server.

•	Edit the crontab using crontab –e
•	Add the following line to schedule the script to run every Mondays at Midnight:

  0 0 * * 1 /emea/SRC/bin/vmstat_script.sh


// Email Alters for any performance related incidents:

Step 1: Login to the Linux server with user who has relevant access. 

Step 2: Place Threshold_Config.sh and SystemPerformanceAlert.sh files in below path of the server:
             /emea/SRC/bin

Step 3: Grant execution permission.
chmod +x /emea/SRC/bin/Threshold_Config.sh
chmod +x /emea/SRC/bin/SystemPerformanceAlert.sh

Step 4: Create the cron job to schedule alters in each server.

•	Edit the crontab using crontab –e
•	Add the following line to schedule the script to run every hour:
 0 * * * * /emea/SRC/bin/SystemPerformanceAlert.sh




