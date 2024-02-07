#!/bin/bash

# Ensure the script exits if any command fails
#set -e

# Source environment variables
echo "Sourcing environment variables..."
source ~/.bashrc
echo "Environment variables sourced."

# Navigate to the directory
echo "Navigating to ntracking directory..."
cd $HOME/.local/share/ntracking/
echo "In ntracking directory."

# Log Synchronization
echo "Starting log synchronization..."
$HOME/.local/share/ntracking/sync_logs.sh
echo "Log synchronization completed."

#mtracking log sync
$HOME/.local/share/ntracking/mtracking/machine_logs_scp.sh

# Log Merging
echo "Starting log merging..."
$HOME/.local/share/ntracking/merge_logs.sh
echo "Log merging completed."

# Get Node Info
echo "Retrieving node info..."
python3 /home/ubuntu/ntracking/node_info.py
echo "Node info retrieved."

# Generate the graphs
echo "Generating graphs..."
$HOME/ntracking/create_graphs.sh
echo "Graphs generated."

#mtracking generate graphs
python3 /home/ubuntu/ntracking/mtracking.py

# Navigate to the nginx folder
echo "Navigating to nginx directory..."
cd /var/www/ntracking
echo "In nginx folder."

# Copy the files
echo "Copying files..."

cp /home/ubuntu/ntracking/*.html .
cp /home/ubuntu/ntracking/*.txt .



echo "Files copied."
