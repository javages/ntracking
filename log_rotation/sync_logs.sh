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
mkdir -p "$DEST_BASE_DIR/s23"
mkdir -p "$DEST_BASE_DIR/s24"
mkdir -p "$DEST_BASE_DIR/s25"
mkdir -p "$DEST_BASE_DIR/s26"
mkdir -p "$DEST_BASE_DIR/s27"
mkdir -p "$DEST_BASE_DIR/s28"
mkdir -p "$DEST_BASE_DIR/s29"
mkdir -p "$DEST_BASE_DIR/s30"

# for local machin server
mkdir -p "$DEST_BASE_DIR/s00"
echo "Subdirectories created."

# Change directory to where the log files are located
cd $HOME

# Synchronize the local machine's log to the appropriate subdirectory
rsync -avz --update $HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s00/

# Synchronize logs from each remote machine to separate subdirectories
rsync -avz --update system_01:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s01/
rsync -avz --update system_02:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s02/
rsync -avz --update system_03:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s03/
rsync -avz --update system_04:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s04/
rsync -avz --update system_05:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s05/
rsync -avz --update system_06:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s06/
rsync -avz --update system_07:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s07/
rsync -avz --update system_08:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s08/
rsync -avz --update system_09:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s09/
rsync -avz --update system_10:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s10/
rsync -avz --update system_11:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s11/
rsync -avz --update system_12:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s12/
rsync -avz --update system_13:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s13/
rsync -avz --update system_14:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s14/
rsync -avz --update system_15:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s15/
rsync -avz --update system_16:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s16/
rsync -avz --update system_17:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s17/
rsync -avz --update system_18:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s18/
rsync -avz --update system_19:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s19/
rsync -avz --update system_20:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s20/
rsync -avz --update system_21:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s21/
rsync -avz --update system_22:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s22/
rsync -avz --update system_23:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s23/
rsync -avz --update system_24:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s24/
rsync -avz --update system_25:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s25/
rsync -avz --update system_26:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s26/
rsync -avz --update system_27:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s27/
rsync -avz --update system_28:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s28/
rsync -avz --update system_29:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s29/
rsync -avz --update system_30:$HOME/.local/share/ntracking_working_folder/local_machine/resources_*.log $DEST_BASE_DIR/s30/

echo "Synchronization script completed."

#delete empty folders from non existing machines
find $HOME/.local/share/ntracking_working_folder/logs/ -type d -empty -print -delete


exit 0
