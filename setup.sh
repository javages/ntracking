#!/usr/bin/env bash

export NEWT_COLORS='
window=,white
border=black,white
textbox=black,white
button=black,white
'

############################################## select install action

SELECTION=$(whiptail --title "NTracking and Vdash instalation" --radiolist \
"Instalation Options                              " 20 70 10 \
"1" "Setup NTracking Master" OFF \
"2" "Setup NTracking Slave" OFF \
"3" "Update Ntracking " OFF \
"4" "Uninstall NTracking " OFF \
"5" "Install Vdash " OFF \
"6" "Update Vdash            " ON \
"7" "copy node logs to nginx            " OFF 3>&1 1>&2 2>&3)


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
git clone https://github.com/safenetforum-community/ntracking.git $HOME/.local/share/ntracking

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

sudo apt install python3-pip -y

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
pip3 install plotly.express
sleep 3

clear
echo "installing matplotlib"
pip3 install matplotlib
sleep 3

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
whiptail --msgbox --title "installation of vnstat complete" "if you have more than one network adapter you must remove all network adapters except the primary internet connection that the nodes use to connect to the internet use the following command.\n\nvnstat <will show adapters being monitored by vnstat>\n\n\nsudo vnstat --remove --iface <network adapter to remove> --force" 25 80
vnstat
sleep 5

######################## install nginx
clear
echo "installing nginx"
sleep 2
sudo apt install nginx
sudo ufw allow 80/tcp comment 'NTracking'
sudo chmod -R 757 /var/www
mkdir /var/www/ntracking
cp $HOME/.local/share/ntracking/commingsoon.html /var/www/ntracking/index.html
sudo tee /etc/nginx/sites-enabled/default 2>&1 > /dev/null <<EOF
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

sudo tee /etc/nginx/nginx.conf 2>&1 > /dev/null <<EOF
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 768;
	# multi_accept on;
}

http {
	sendfile on;
	tcp_nopush on;
	types_hash_max_size 2048;
	include /etc/nginx/mime.types;
	default_type application/octet-stream;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;
	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;
	gzip on;
	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;
}
EOF

#enable nginx
sudo systemctl enable nginx.service
sleep 2
#start nginx incase not running by default
sudo systemctl start nginx.service
sleep 2
#restart nginx in case it was running already
sudo systemctl restart nginx.service
sleep 2
whiptail --msgbox --title "installation of nginx webserver complete" "nginx set up complete\n \nport 80 opened in fire wall\n\n\nif you enter this systems ip address into your web browser\nyou should see the NTracking comming soon page\n\nif you are on a local lan no port forwad is required\n\nif it is a cloud node or on a diferent network you will need to make sure there is a port forward setup" 25 80
######################## setup cron jobs

echo "*/20 * * * * $USER /usr/bin/mkdir -p $HOME/.local/share/local_machine && /bin/bash $HOME/.local/share/ntracking/resources.sh >> $HOME/.local/share/local_machine/resources_\$(date +\%Y\%m\%d).log 2>&1" | sudo tee /etc/cron.d/ntracking_resources
echo "10 0 * * * $USER /bin/bash $HOME/.local/share/ntracking/log_rotation/log_rm.sh" | sudo tee /etc/cron.d/ntracking_log_rm
echo "0 * * * * $USER /bin/bash $HOME/.local/share/ntracking/mtracking/machine_resources.sh" | sudo tee /etc/cron.d/ntracking_mtracking_machine_resources
echo "5 * * * * $USER /bin/bash $HOME/.local/share/ntracking/execute_steps.sh" | sudo tee /etc/cron.d/ntracking_execute_steps


######################################################################################################################## Setup NTracking Slave
elif [[ "$SELECTION" == "2" ]]; then

# download NTracking
git clone https://github.com/safenetforum-community/ntracking.git $HOME/.local/share/ntracking

############ add NTracking dir to path
clear
echo "adding $HOME/.local/share/ntracking to path"
sleep 2
echo export PATH=$PATH:$HOME/.local/share/ntracking/ >> $HOME/.bashrc
source $HOME/.bashrc

######################## install vnstat
clear
echo "installing vnstat"
sleep 2
sudo apt install vnstat -y
whiptail --msgbox --title "installation of vnstat complete" "if you have more than one network adapter you must remove all network adapters except the primary internet connection that the nodes use to connect to the internet use the following command.\n\nvnstat <will show adapters being monitored by vnstat>\n\n\nsudo vnstat --remove --iface <network adapter to remove> --force" 25 80
vnstat

######################### setup cron jobs
echo "*/20 * * * * $USER /usr/bin/mkdir -p $HOME/.local/share/local_machine && /bin/bash $HOME/.local/share/ntracking/resources.sh >> $HOME/.local/share/local_machine/resources_\$(date +\%Y\%m\%d).log 2>&1" | sudo tee /etc/cron.d/ntracking_resources
echo "10 0 * * * $USER /bin/bash $HOME/.local/share/ntracking/log_rotation/log_rm.sh" | sudo tee /etc/cron.d/ntracking_log_rm
echo "0 * * * * $USER /bin/bash $HOME/.local/share/ntracking/mtracking/machine_resources.sh" | sudo tee /etc/cron.d/ntracking_mtracking_machine_resources

######################################################################################################################## update NTracking
elif [[ "$SELECTION" == "3" ]]; then

cd $HOME/.local/share/ntracking
git pull

######################################################################################################################## Uninstall NTracking
elif [[ "$SELECTION" == "4" ]]; then

##### delete cron jobs
sudo rm /etc/cron.d/ntracking*

##### delete ntracking
rm -rf $HOME/.local/share/ntracking
rm -rf $HOME/.local/share/local_machine

######################################################################################################################## install Vdash
elif [[ "$SELECTION" == "5" ]]; then

curl https://sh.rustup.rs -sSf | sh
sudo apt install cargo
cargo install vdash

######################################################################################################################## update Vdash
elif [[ "$SELECTION" == "6" ]]; then

rustup update
cargo install vdash

######################################################################################################################## copy logs to nginx
elif [[ "$SELECTION" == "7" ]]; then

mkdir -p /var/www/files

fi
