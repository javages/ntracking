#!/usr/bin/env bash

export NEWT_COLORS='
window=,white
border=black,white
textbox=black,white
button=black,white
'

############################################## select test net action

SELECTION=$(whiptail --title "NTracking and Vdash instalation" --radiolist \
"Instalation Options                              " 20 70 10 \
"1" "Setup NTracking Master" OFF \
"2" "Setup NTracking Slave" OFF \
"3" "Update Ntracking " ON \
"4" "Setup Dynamic DNS service            " OFF 3>&1 1>&2 2>&3)


if [[ $? -eq 255 ]]; then
exit 0
fi

######################################################################################################################## Setup NTracking Master
if [[ "$SELECTION" == "1" ]]; then
sudo apt update
############ Download NTracking
clear
echo "downloading NTracking from github"
sleep 2
git clone git@github.com:safenetforum-community/ntracking.git $HOME/.local/share/ntracking

############ add NTracking dir to path
clear
echo "adding $HOME/.local/share/ntracking to path"
sleep 2
echo export PATH=$PATH:$HOME/.local/share/ntracking/ >> $HOME/.bashrc
source $HOME/.bashrc

############ install pre requsites
#Install venv
clear
echo "install venve"
sleep 2
sudo apt install python3.10-venv -y

# Set up a virtual environment (venv)
clear
echo "setup virtual enviroment"
sleep 2
python3 -m venv $HOME/.local/share/ntracking/RPvenv
source $HOME/.local/share/ntracking/RPvenv/bin/activate

#!${HOME}/.local/share/ntracking/RPvenv/bin/python

# Display the version of pip
clear
echo "version of pip"
sleep 2
pip --version

# Install the 'pandas' and 'plotly.express' Python packages using pip3
clear
echo "installing pandas"
sleep 2
pip3 install pandas

clear
echo "installing plotly"
sleep 2
pip3 install plotly.express

clear
echo "installing matplotlib"
sleep 2
pip3 install matplotlib

clear
echo "jinja2"
sleep 2
pip3 install jinja2

#!/usr/bin/env bash

######################## install vnstat
clear
echo "installing vnstat"
sleep 2
sudo apt install vnstat -y
whiptail --msgbox --title "installation of vnstat complete" "if you have more than one network adapter you must remove all network adapters except the primary internet connection that the nodes use to connect to the internet use the following command.\n\n\nsudo vnstat --remove --iface <network adapter to remove> --force" 25 80

######################## install nginx
clear
echo "installing nginx"
sleep 2
sudo apt install nginx
sudo ufw allow 80/tcp comment 'NTracking'
sudo chmod -R 757 /var/www
mkdir /var/www/ntracking
cp $HOME/.local/share/ntracking/commingsoon.html /var/www/ntracking/index.html
sudo tee /etc/nginx/sites-enabled/default 2>&1 > /dev/null <<-EOF
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/ntracking;

        index index.html;

        server_name _;

        location / {
                try_files \$uri \$uri/ =404;
        }
}
EOF
sudo systemctl restart nginx.service
whiptail --msgbox --title "installation of nginx webserver complete" "nginx set up complete\n \nport 80 opened in fire wall\n\n\nif you enter this systems ip address into your web browser\nyou should see the NTracking comming soon page\n\nif you are on a local lan no port forwad is required\n\nif it is a cloud node or on a diferent network you will need to make sure there is a port forward setup" 25 80
######################## setup cron jobs

echo "*/20 * * * * $USER /usr/bin/mkdir -p $HOME/.local/share/local_machine && /bin/bash $HOME/.local/share/ntracking/resources.sh >> $HOME/.local/share/local_machine/resources_\$(date +\%Y\%m\%d).log 2>&1" | sudo tee /etc/cron.d/ntracking_resources
echo "10 0 * * * $USER /bin/bash $HOME/.local/share/ntracking/log_rotation/log_rm.sh" | sudo tee /etc/cron.d/ntracking_log_rm
echo "0 * * * * $USER /bin/bash $HOME/.local/share/ntracking/mtracking/machine_resources.sh" | sudo tee /etc/cron.d/ntracking_mtracking_machine_resources
echo "5 * * * * $USER /bin/bash $HOME/.local/share/ntracking/execute_steps.sh" | sudo tee /etc/cron.d/ntracking_execute_steps


######################################################################################################################## Setup NTracking Slave
elif [[ "$SELECTION" == "2" ]]; then

echo "2"
######################################################################################################################## update NTracking
elif [[ "$SELECTION" == "3" ]]; then

echo "3"
######################################################################################################################## Uninstall NTracking
elif [[ "$SELECTION" == "4" ]]; then

echo "4"

fi
