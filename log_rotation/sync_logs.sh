#!/bin/bash

echo "Starting the synchronization script..."

# Define the base destination directory
DEST_BASE_DIR="$HOME/.local/share/ntracking/logs"
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
mkdir -p "$DEST_BASE_DIR/s31"
mkdir -p "$DEST_BASE_DIR/s32"
mkdir -p "$DEST_BASE_DIR/s33"
mkdir -p "$DEST_BASE_DIR/s34"
mkdir -p "$DEST_BASE_DIR/s35"
mkdir -p "$DEST_BASE_DIR/s36"
mkdir -p "$DEST_BASE_DIR/s37"
mkdir -p "$DEST_BASE_DIR/s38"
mkdir -p "$DEST_BASE_DIR/s39"
mkdir -p "$DEST_BASE_DIR/s40"
mkdir -p "$DEST_BASE_DIR/s41"
mkdir -p "$DEST_BASE_DIR/s42"
mkdir -p "$DEST_BASE_DIR/s43"
mkdir -p "$DEST_BASE_DIR/s44"
mkdir -p "$DEST_BASE_DIR/s45"
mkdir -p "$DEST_BASE_DIR/s46"
mkdir -p "$DEST_BASE_DIR/s47"
mkdir -p "$DEST_BASE_DIR/s48"
mkdir -p "$DEST_BASE_DIR/s49"
mkdir -p "$DEST_BASE_DIR/s50"

# for local machin server
mkdir -p "$DEST_BASE_DIR/s00"
echo "Subdirectories created."

# Change directory to where the log files are located
cd $HOME

# Synchronize the local machine's log to the appropriate subdirectory
rsync -avz --update $HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s00/

# Synchronize logs from each remote machine to separate subdirectories
rsync -avz --update s01:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s01/
rsync -avz --update s02:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s02/
rsync -avz --update s03:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s03/
rsync -avz --update s04:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s04/
rsync -avz --update s05:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s05/
rsync -avz --update s06:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s06/
rsync -avz --update s07:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s07/
rsync -avz --update s08:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s08/
rsync -avz --update s09:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s09/
rsync -avz --update s10:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s10/
rsync -avz --update s11:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s11/
rsync -avz --update s12:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s12/
rsync -avz --update s13:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s13/
rsync -avz --update s14:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s14/
rsync -avz --update s15:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s15/
rsync -avz --update s16:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s16/
rsync -avz --update s17:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s17/
rsync -avz --update s18:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s18/
rsync -avz --update s19:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s19/
rsync -avz --update s20:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s20/
rsync -avz --update s21:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s21/
rsync -avz --update s22:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s22/
rsync -avz --update s23:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s23/
rsync -avz --update s24:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s24/
rsync -avz --update s25:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s25/
rsync -avz --update s26:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s26/
rsync -avz --update s27:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s27/
rsync -avz --update s28:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s28/
rsync -avz --update s29:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s29/
rsync -avz --update s30:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s30/
rsync -avz --update s31:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s31/
rsync -avz --update s32:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s32/
rsync -avz --update s33:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s33/
rsync -avz --update s34:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s34/
rsync -avz --update s35:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s35/
rsync -avz --update s36:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s36/
rsync -avz --update s37:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s37/
rsync -avz --update s38:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s38/
rsync -avz --update s39:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s39/
rsync -avz --update s40:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s40/
rsync -avz --update s41:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s41/
rsync -avz --update s42:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s42/
rsync -avz --update s43:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s43/
rsync -avz --update s44:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s44/
rsync -avz --update s45:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s45/
rsync -avz --update s46:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s46/
rsync -avz --update s47:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s47/
rsync -avz --update s48:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s48/
rsync -avz --update s49:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s49/
rsync -avz --update s50:$HOME/.local/share/local_machine/resources_*.log $DEST_BASE_DIR/s50/

echo "Synchronization script completed."

#delete empty folders from non existing machines
find $HOME/.local/share/ntracking/logs/ -type d -empty -print -delete


exit 0
