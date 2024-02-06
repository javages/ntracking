#!/bin/bash

echo "Starting the synchronization script..."

# Define the base destination directory
DEST_BASE_DIR="$HOME/ntracking/logs"
echo "Base destination directory: $DEST_BASE_DIR"

# Create the base destination directory if it doesn't exist
echo "Creating base destination directory..."
mkdir -p "$DEST_BASE_DIR"
echo "Base destination directory created."

# Create destination directories if they don't exist
echo "Creating subdirectories under base destination..."
mkdir -p "$DEST_BASE_DIR/wyse"
mkdir -p "$DEST_BASE_DIR/wyse1"
mkdir -p "$DEST_BASE_DIR/wyse2"
mkdir -p "$DEST_BASE_DIR/wyse3"
mkdir -p "$DEST_BASE_DIR/wyse4"
echo "Subdirectories created."

# Change directory to where the log files are located
cd $HOME

# Synchronize the local machine's log to the appropriate subdirectory
rsync -avz --update resources_*.log "$DEST_BASE_DIR/wyse/"

# Synchronize logs from each remote machine to separate subdirectories
rsync -avz --update wyse1@192.168.254.152:"/home/wyse1/resources_*.log" "$DEST_BASE_DIR/wyse1/"
rsync -avz --update wyse2@192.168.254.153:"/home/wyse2/resources_*.log" "$DEST_BASE_DIR/wyse2/"
rsync -avz --update wyse3@192.168.254.154:"/home/wyse3/resources_*.log" "$DEST_BASE_DIR/wyse3/"
rsync -avz --update wyse4@192.168.254.158:"/home/wyse4/resources_*.log" "$DEST_BASE_DIR/wyse4/"

echo "Synchronization script completed."

#delete empty folders from non existing machines
find $HOME/.local/share/ntracking_working_folder/logs/ -type d -empty -print -delete


