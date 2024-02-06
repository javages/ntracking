#!/bin/bash

echo "Starting the synchronization script..."

# Define the base destination directory
DEST_BASE_DIR="$HOME/.local/share/ntracking_working_folder/logs"
echo "Base destination directory: $DEST_BASE_DIR"

# Create the base destination directory if it doesn't exist
echo "Creating base destination directory..."
mkdir -p "$DEST_BASE_DIR"
echo "Base destination directory created."

# Create destination directories if they don't exist
echo "Creating subdirectories under base destination..."
mkdir -p "$DEST_BASE_DIR/system_01"
mkdir -p "$DEST_BASE_DIR/system_02"
mkdir -p "$DEST_BASE_DIR/system_03"
mkdir -p "$DEST_BASE_DIR/system_04"
mkdir -p "$DEST_BASE_DIR/system_05"
mkdir -p "$DEST_BASE_DIR/system_06"
mkdir -p "$DEST_BASE_DIR/system_07"
mkdir -p "$DEST_BASE_DIR/system_08"
mkdir -p "$DEST_BASE_DIR/system_09"
mkdir -p "$DEST_BASE_DIR/system_10"
mkdir -p "$DEST_BASE_DIR/system_11"
mkdir -p "$DEST_BASE_DIR/system_12"
mkdir -p "$DEST_BASE_DIR/system_13"
mkdir -p "$DEST_BASE_DIR/system_14"
mkdir -p "$DEST_BASE_DIR/system_15"
mkdir -p "$DEST_BASE_DIR/system_16"
mkdir -p "$DEST_BASE_DIR/system_17"
mkdir -p "$DEST_BASE_DIR/system_18"
mkdir -p "$DEST_BASE_DIR/system_19"
mkdir -p "$DEST_BASE_DIR/system_20"
mkdir -p "$DEST_BASE_DIR/system_21"
mkdir -p "$DEST_BASE_DIR/system_22"

# for local machin server
mkdir -p "$DEST_BASE_DIR/server"
echo "Subdirectories created."

# Change directory to where the log files are located
cd $HOME

# Synchronize the local machine's log to the appropriate subdirectory
rsync -avz --update $HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/server/

# Synchronize logs from each remote machine to separate subdirectories
rsync -avz --update system_01:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_01/"
rsync -avz --update system_02:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_02/"
rsync -avz --update system_03:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_03/"
rsync -avz --update system_04:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_04/"
rsync -avz --update system_05:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_05/"
rsync -avz --update system_06:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_06/"
rsync -avz --update system_07:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_07/"
rsync -avz --update system_08:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_08/"
rsync -avz --update system_09:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_09/"
rsync -avz --update system_10:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_10/"
rsync -avz --update system_11:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_11/"
rsync -avz --update system_12:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_12/"
rsync -avz --update system_13:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_13/"
rsync -avz --update system_14:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_14/"
rsync -avz --update system_15:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_15/"
rsync -avz --update system_16:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_16/"
rsync -avz --update system_17:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_17/"
rsync -avz --update system_18:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_18/"
rsync -avz --update system_19:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_19/"
rsync -avz --update system_20:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_20/"
rsync -avz --update system_21:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_21/"
rsync -avz --update system_22:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_22/"
rsync -avz --update system_23:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_23/"
rsync -avz --update system_24:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_24/"
rsync -avz --update system_25:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_25/"
rsync -avz --update system_26:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_26/"
rsync -avz --update system_27:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_27/"
rsync -avz --update system_28:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_28/"
rsync -avz --update system_29:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_29/"
rsync -avz --update system_30:"$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log" "$DEST_BASE_DIR/system_30/"

echo "Synchronization script completed."

exit 0
