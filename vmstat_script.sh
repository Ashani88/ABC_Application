#!/bin/bash
vmstat 10 > /emea/SRC/PERF_001/ABC_vmstatfile.dat
mv ABC_vmstatfile.dat ABC_vmstatfile.dat.'date +%Y-%m-%d'
sleep 10
echo "ABC System Perfomance Summary" | mailx -s "Weekly Summary Report" -a "/emea/SRC/PERF_001/ABC_vmstatfile.dat.'date +%Y-%m-%d'" ASPAGROUP@gvt.com
