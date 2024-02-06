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
mkdir -p "$DEST_BASE_DIR/s01"
mkdir -p "$DEST_BASE_DIR/s02"
mkdir -p "$DEST_BASE_DIR/s03"
mkdir -p "$DEST_BASE_DIR/s04"
mkdir -p "$DEST_BASE_DIR/s05"
mkdir -p "$DEST_BASE_DIR/s06"
mkdir -p "$DEST_BASE_DIR/s07"
mkdir -p "$DEST_BASE_DIR/s08"
mkdir -p "$DEST_BASE_DIR/s09"
mkdir -p "$DEST_BASE_DIR/s10"
mkdir -p "$DEST_BASE_DIR/s11"
mkdir -p "$DEST_BASE_DIR/s12"
mkdir -p "$DEST_BASE_DIR/s13"
mkdir -p "$DEST_BASE_DIR/s14"
mkdir -p "$DEST_BASE_DIR/s15"
mkdir -p "$DEST_BASE_DIR/s16"
mkdir -p "$DEST_BASE_DIR/s17"
mkdir -p "$DEST_BASE_DIR/s18"
mkdir -p "$DEST_BASE_DIR/s19"
mkdir -p "$DEST_BASE_DIR/s20"
mkdir -p "$DEST_BASE_DIR/s21"
mkdir -p "$DEST_BASE_DIR/s22"

# for local machin oracle
mkdir -p "$DEST_BASE_DIR/s"

echo "Subdirectories created."

# Change directory to where the log files are located
cd $HOME

# Synchronize the local machine's log to the appropriate subdirectory
rsync -avz --update $HOME/resources_*.log "$DEST_BASE_DIR/s/"

# Synchronize logs from each remote machine to separate subdirectories
rsync -avz --update safe-s01:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s01/"
rsync -avz --update safe-s02:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s02/"
rsync -avz --update safe-s03:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s03/"
rsync -avz --update safe-s04:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s04/"
rsync -avz --update safe-s05:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s05/"
rsync -avz --update safe-s06:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s06/"
rsync -avz --update safe-s07:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s07/"
rsync -avz --update safe-s08:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s08/"
rsync -avz --update safe-s09:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s09/"
rsync -avz --update safe-s10:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s10/"
rsync -avz --update safe-s11:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s11/"
rsync -avz --update safe-s12:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s12/"
rsync -avz --update safe-s13:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s13/"
rsync -avz --update safe-s14:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s14/"
rsync -avz --update safe-s15:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s15/"
rsync -avz --update safe-s16:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s16/"
rsync -avz --update safe-s17:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s17/"
rsync -avz --update safe-s18:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s18/"
rsync -avz --update safe-s19:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s19/"
rsync -avz --update safe-s20:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s20/"
rsync -avz --update hamilton:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s21/"
rsync -avz --update byres:"/home/ubuntu/resources_*.log" "$DEST_BASE_DIR/s22/"

echo "Synchronization script completed."

exit 0
