#!/usr/bin/env bash

CLIENT=0.89.68
NODE=0.104.32
FAUCET=64.227.32.230:8000

# comunity or josh master coment out to select corect repository

#REPOSITORY="https://raw.githubusercontent.com/javages/ntracking/main/"
REPOSITORY="https://raw.githubusercontent.com/safenetforum-community/ntracking/main/"



# first node port can edited in menu later
NODE_PORT_FIRST=4700
NUMBER_NODES=30
NUMBER_COINS=1
DELAY_BETWEEN_NODES=11
NODE_START_TIME=0

export NEWT_COLORS='
window=,white
border=black,white
textbox=black,white
button=black,white
'

############################################## select test net action

SELECTION=$(whiptail --title "Safe Network Testnet" --radiolist \
"Testnet Actions                              " 20 70 10 \
"1" "Upgrade Client & Node to Latest" OFF \
"2" "Upgrade Client to Latest" OFF \
"3" "Stop Nodes" OFF \
"4" "Get Test Coins" ON \
"5" "Start Vdash" OFF \
"6" "Update & Upgrade SYSTEM and RESTART!!   " OFF \
"7" "setup NTracking & Vdash" OFF 3>&1 1>&2 2>&3)

if [[ $? -eq 255 ]]; then
exit 0
fi

################################################################################################################ start or Upgrade Client & Node to Latest
if [[ "$SELECTION" == "1" ]]; then

pkill -e safenode

NUMBER_NODES=$(whiptail --title "Number of Nodes to start" --inputbox "\nEnter number of nodes" 8 40 $NUMBER_NODES 3>&1 1>&2 2>&3)
if [[ $? -eq 255 ]]; then
exit 0
fi
NODE_PORT_FIRST=$(whiptail --title "Port Number of first Node" --inputbox "\nEnter Port Number of first Node" 8 40 $NODE_PORT_FIRST 3>&1 1>&2 2>&3)
if [[ $? -eq 255 ]]; then
exit 0
fi

OPEN_METRICS=$(whiptail --title "node instalation method" --radiolist \
"select node type                              " 20 70 10 \
"0" "Install node via safeup" ON \
"1" "compile node from source with open metrics enabled  " OFF 3>&1 1>&2 2>&3)
if [[ $? -eq 255 ]]; then
exit 0
fi

DELAY_BETWEEN_NODES=$(whiptail --title "Delay between starting nodes in seconds" --inputbox "\nEnter delay between nodes?" 8 40 $DELAY_BETWEEN_NODES 3>&1 1>&2 2>&3)
if [[ $? -eq 255 ]]; then
exit 0
fi

############################## count nodes directories and close fire wall
PORTS_TO_CLOSE=$(ls $HOME/.local/share/safe/node | wc -l)
sudo ufw delete allow $NODE_PORT_FIRST:$(($NODE_PORT_FIRST+$PORTS_TO_CLOSE-1))/udp comment 'safe nodes'
############################## Stop Nodes and delete safe folder
curl -sSL https://raw.githubusercontent.com/maidsafe/safeup/main/install.sh | bash

rm -rf $HOME/.local/share/safe

# remove ntracking logs
rm -rf $HOME/.local/share/local_machine
rm -rf $HOME/.local/share/ntracking/logs
rm $HOME/.local/share/ntracking/*.log

cp $HOME/.local/share/ntracking/index.html.standby /var/www/ntracking/index.html

## reset vnstat database
sudo systemctl stop vnstat.service
sudo rm -rf /var/lib/vnstat/
sudo systemctl start vnstat.service

sleep 2
############################## install client node and vdash

safeup client --version "$CLIENT"

# Source the environment variables
source /root/.config/safe/env

#### Install node directley with safeup or compile node version with open metrics enabled. 

if [[ $OPEN_METRICS == 0 ]]; then
# local machine
safeup node --version "$NODE"
else
#remote machine
cd
wget https://github.com/maidsafe/safe_network/archive/refs/tags/sn_node-v$NODE.zip && unzip sn_node-v$NODE.zip && rm sn_node-v$NODE.zip
cd safe_network-sn_node-v$NODE
cargo build --release --features=network-contacts,open-metrics
cp ./target/release/safenode ~/.local/bin
rm -rf $HOME/safe_network-sn_node-v$NODE
fi

cargo install vdash
############################## open ports 
sudo ufw allow $NODE_PORT_FIRST:$(($NODE_PORT_FIRST+$NUMBER_NODES-1))/udp comment 'safe nodes'
sleep 2
############################## start nodes

for (( c=$NODE_PORT_FIRST; c<=$(($NODE_PORT_FIRST+$NUMBER_NODES-1)); c++ ))
do 
   sleep "$NODE_START_TIME" && safenode --port $c --max_log_files 10 --max_archived_log_files 0 2>&1 > /dev/null & disown
   echo "starting node on port $c with $NODE_START_TIME second delay"
   NODE_START_TIME=$(($NODE_START_TIME+$DELAY_BETWEEN_NODES))
done
sleep 2

############################# get 200 test coins
for (( c=1; c<=2; c++ ))
do 
   safe wallet get-faucet "$FAUCET"
   sleep 1
done

############################# exit to Vdash
#vdash --glob-path "$HOME/.local/share/safe/node/*/logs/safenode.log"

######################################################################################################################## Upgrade Client to Latest
elif [[ "$SELECTION" == "2" ]]; then
############################## Stop client and delete safe folder
rm -rf $HOME/.local/share/safe/client
# upgrade client and get some Coins
safeup client
sleep 2
safe wallet get-faucet "$FAUCET"

######################################################################################################################## Stop Nodes
elif [[ "$SELECTION" == "3" ]]; then

#stop nodes
pkill -e safenode
############################## count nodes directories and close fire wall
PORTS_TO_CLOSE=$(ls $HOME/.local/share/safe/node | wc -l)
sudo ufw delete allow $NODE_PORT_FIRST:$(($NODE_PORT_FIRST+$PORTS_TO_CLOSE-1))/udp comment 'safe nodes'
############################## Stop Nodes and delete safe folder

remove safe folder
rm -rf $HOME/.local/share/safe

cp $HOME/.local/share/ntracking/commingsoon.html /var/www/ntracking/index.html

rm -rf $HOME/.local/share/local_machine
rm $HOME/.local/share/ntracking/*.log
rm -rf $HOME/local.share/ntracking/logs


sleep 2

######################################################################################################################## Get Test Coins
elif [[ "$SELECTION" == "4" ]]; then
NUMBER_COINS=$(whiptail --title "Number of Coins" --inputbox "\nEnter number of deposits 100 each" 8 40 $NUMBER_COINS 3>&1 1>&2 2>&3)
if [[ $? -eq 255 ]]; then
exit 0
fi

for (( c=1; c<=$NUMBER_COINS; c++ ))
do 
   safe wallet get-faucet "$FAUCET"
   sleep 1
done
######################################################################################################################### Start Vdash
elif [[ "$SELECTION" == "5" ]]; then
vdash --glob-path "$HOME/.local/share/safe/node/*/logs/safenode.log"

######################################################################################################################### update and restart
elif [[ "$SELECTION" == "6" ]]; then
rustup update
sudo apt update -y && sudo apt upgrade -y
sudo reboot

############################################################################################################################################# setup NTracking & vdash
elif [[ "$SELECTION" == "7" ]]; then
bash <(curl -s "$REPOSITORY"setup.sh)

fi
