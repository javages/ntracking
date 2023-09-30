#!/bin/bash

# Set the installation directory
install_dir="${HOME}/.local/share/safe/tools/ntracking"

# Check if the directory doesn't exist, create it
if [[ ! -d $install_dir ]]; then
    mkdir -p $install_dir
fi 

# Copy assets to the installation directory
for file in *; do
    cp -rv  $file $install_dir;    #use the -r recurxive flag to copy the venv dir as well
done

#Install venv
sudo apt install python3.10-venv

# Set up a virtual environment (venv)
python3 -m venv $install_dir/RPvenv
source $install_dir/RPvenv/bin/activate

# Sort permissions for certain scripts
chmod +x -v \
  install_prereqs.sh \
  ./resources.sh \
  ./create_graphs.sh
  #./interactive_rewards.py

# Get prerequisites by running install_prereqs.sh
bash ./install_prereqs.sh

# Set up a cron job to periodically run resources.sh
echo ""
echo "This script will take a snapshot of your node/nodes resources and rewards balance every 10 minutes."
echo "The data will be appended to resources.log."
echo ""
echo ""
crontab -l > tmpcron
echo "*/10 * * * * /bin/bash $install_dir/resources.sh >> $install_dir/resources.log" >> tmpcron
crontab tmpcron 
rm tmpcron

# Installation completion message
echo ""
echo "--------------------------SN-StatNTracking installation is complete------------------------------"
echo ""
echo ""
echo ""
echo " Once you have run for a few hours and have enough data, you can generate the graph.  "
echo " Your graph will be stored as ~/.local/share/safe/tools/ntracking/rewards_balance_plot.html"
