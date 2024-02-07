#!/bin/bash

# Log
output_file="$HOME/.local/share/local_machine/machine_resources.log"  # Replace with your desired path
mkdir -p $HOME/.local/share/local_machine

# CPU usage
cpu_usage=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t", $(NF-2)}')
echo "CPU Used: $cpu_usage" > $output_file

# RAM usage
total_ram=$(free -m | awk '/Mem:/ {print $2}')
used_ram=$(free -m | awk '/Mem:/ {print $3}')
ram_usage=$(awk "BEGIN {printf \"%.2f%%\", ($used_ram/$total_ram)*100}")
echo "RAM Used: $ram_usage of $total_ram MB" >> $output_file

# Disk Usage
disk_usage=$(df -h | awk '$NF=="/"{printf "%s\t", $5}')
echo "Disk Used: $disk_usage" >> $output_file

echo "vnStat Data:" >> $output_file
vnstat --json >> $output_file

