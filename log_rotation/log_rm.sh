#!/bin/bash

# Define the base directory and the logs subdirectory
BASE_DIR="$HOME/.local/share/local_machine"
LOGS_SUBDIR="$HOME/.local/share/ntracking/logs"

# Define the age limit in days
AGE_LIMIT=3

# Current date as Unix timestamp
CURRENT_TIMESTAMP=$(date +%s)

delete_logs_in_dir() {
    local dir=$1
    echo "Checking directory: $dir"

    # Delete log files based on date in filename
    for file in "$dir"/resources_*.log; do
        # Extract the date from the filename
        filename=$(basename "$file")
        file_date=${filename:10:8}

        # Validate the date string
        if [[ $file_date =~ ^[0-9]{8}$ ]]; then
            # Convert file date to Unix timestamp
            file_timestamp=$(date -d "${file_date:0:4}-${file_date:4:2}-${file_date:6:2}" +%s)

            # Calculate the age of the file in days
            file_age=$(( (CURRENT_TIMESTAMP - file_timestamp) / 86400 )) # 86400 seconds in a day

            # Check if the file is older than the age limit
            if [ $file_age -ge $AGE_LIMIT ]; then
                echo "Deleting $file"
                rm "$file"
            else
                echo "File is not old enough to delete: $file"
            fi
        else
            echo "Skipping invalid file: $file"
        fi
    done
}

# Run in the base directory
delete_logs_in_dir "$BASE_DIR"

# Check if logs directory exists and then process each subdirectory
if [ -d "$LOGS_SUBDIR" ]; then
    for subdir in "$LOGS_SUBDIR"/*; do
        if [ -d "$subdir" ]; then
            delete_logs_in_dir "$subdir"
        fi
    done
else
    echo "Logs directory does not exist: $LOGS_SUBDIR"
fi


