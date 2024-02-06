#!/bin/bash

# Base directory for logs
BASE_LOG_DIR="$HOME/.local/share/ntracking_working_folder/logs"

# Loop through each machine
for machine in server system_01 system_02 system_03 system_04 system_05 system_06 system_07 system_08 system_09 system_10 system_11 system_12 system_13 system_14 system_15 system_16 system_17 system_18 system_19 system_20 system_21 system_22 system_23 system_24 system_25 system_26 system_27 system_28 system_29 system_30; do
    # Define the source directory and the merged log file name
    LOG_DIR="$BASE_LOG_DIR/$machine"
    MERGED_LOG="$HOME/.local/share/ntracking_working_folder/resources_${machine#system_}.log" # e.g., resources1.log for system_01

    # Find, sort, and concatenate logs from the last 7 days into the merged log file
    find "$LOG_DIR" -name 'resources_*.log' -mtime -7 -print0 | sort -z | xargs -0 cat > "$MERGED_LOG"
done

#delete empty files from non existing machines
find $HOME/.local/share/ntracking_working_folder/ -type f -empty -print -delete
