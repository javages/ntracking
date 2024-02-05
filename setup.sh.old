#!/bin/bash

# Set the installation directory
install_dir="${HOME}/ntracking"

# Check if the directory doesn't exist, create it
if [[ ! -d $install_dir ]]; then
    mkdir -p $install_dir
fi 

# Copy assets to the installation directory
for file in *; do
    cp -v $file $install_dir
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
 
# Get prerequisites by running install_prereqs.sh
bash ./install_prereqs.sh

read -p "Do you want to set up the cronjob now? it is need for this to work! (yes/no) " answer

if [ "$answer" == "yes" ]; then
    # Set up the first cronjob without any user options
    (crontab -l 2>/dev/null; echo "*/10 * * * * /bin/bash ${HOME}/ntracking/resources.sh >> ${HOME}/ntracking/resources.log 2>&1") | crontab -
    
    # Ask user about setting up automatic graph creation
    read -p "Would you like to automate the graph creation? (yes/no) " graph_answer

    if [ "$graph_answer" == "yes" ]; then
        read -p "How often would you like the graphs created? every (30 min, 1 hour, 5 hours, 12 hours) " frequency

        # Convert frequency to cron syntax
        case "$frequency" in
            "30 min")
                cron_time="*/30 * * * *"
                ;;
            "1 hour")
                cron_time="0 * * * *"
                ;;
            "5 hours")
                cron_time="0 */5 * * *"
                ;;
            "12 hours")
                cron_time="0 */12 * * *"
                ;;
            *)
                echo "Unsupported frequency. Exiting."
                exit 1
                ;;
        esac

        # Add the cronjob for graph creation
        (crontab -l 2>/dev/null; echo "$cron_time $install_dir/create_graphs.sh") | crontab -
    fi
    
    echo "Setup complete. Remember, if you no longer need these cronjobs, you can remove them by running 'crontab -e' in the terminal and deleting the corresponding lines."
else
    echo "Cronjob setup skipped."
fi

# Installation completion message
echo ""
echo "--------------------------NTracking installation is complete------------------------------"
echo ""
echo ""
echo " Once you have run for a few hours and have enough data, you can generate your graphs.  "
echo " Your graphs will be stored at ~/ntracking/"
echo " Use NTracking.html to view them, or open them directly."


