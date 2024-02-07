#!/usr/bin/env bash

CLIENT=0.89.49
NODE=0.103.45
FAUCET=178.128.166.148:8000

NODE_PORT_FIRST=4700
NUMBER_NODES=2
NUMBER_COINS=1
NODE_START_DELAY=0

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
"2" "Upgrade Client to Latest" ON \
"3" "Stop Nodes" OFF \
"4" "Get Test Coins" OFF \
"5" "Start Vdash" OFF \
"6" "Update all and Restart" OFF \
"7" "Josh comnet" OFF 3>&1 1>&2 2>&3)

if [[ $? -eq 255 ]]; then
exit 0
fi

################################################################################################################ Upgrade Client & Node to Latest
if [[ "$SELECTION" == "1" ]]; then

pkill -e safenode

NUMBER_NODES=$(whiptail --title "Number of Nodes to start" --inputbox "\nEnter number of nodes" 8 40 $NUMBER_NODES 3>&1 1>&2 2>&3)
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

mv $HOME/.local/share/ntracking/index.html.standby $HOME/.local/share/ntracking/index.html
cp $HOME/.local/share/ntracking/commingsoon.html /var/www/ntracking/index.html

## reset vnstat database
sudo systemctl stop vnstat.service
sudo rm -rf /var/lib/vnstat/
sudo systemctl start vnstat.service

sleep 2
############################## install client node and vdash
safeup client --version "$CLIENT"
safeup node --version "$NODE"
cargo install vdash
############################## open ports 
sudo ufw allow $NODE_PORT_FIRST:$(($NODE_PORT_FIRST+$NUMBER_NODES-1))/udp comment 'safe nodes'
sleep 2
############################## start nodes
for (( c=$NODE_PORT_FIRST; c<=$(($NODE_PORT_FIRST+$NUMBER_NODES-1)); c++ ))
do 
   sleep $NODE_START_DELAY && safenode --port $c --max_log_files 10 --max_archived_log_files 0 2>&1 > /dev/null & disown
   echo "starting node on port $c with $NODE_START_DELAY second delay"
   NODE_START_DELAY=$(($NODE_START_DELAY+11))
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

pkill -e safenode
############################## count nodes directories and close fire wall
PORTS_TO_CLOSE=$(ls $HOME/.local/share/safe/node | wc -l)
sudo ufw delete allow $NODE_PORT_FIRST:$(($NODE_PORT_FIRST+$PORTS_TO_CLOSE-1))/udp comment 'safe nodes'
############################## Stop Nodes and delete safe folder

rm -rf $HOME/.local/share/safe

mv $HOME/.local/share/ntracking/index.html $HOME/.local/share/ntracking/index.html.standby
cp $HOME/.local/share/ntracking/commingsoon.html /var/www/ntracking/index.html

rm -rf $HOME/.local/share/local_machine
rm $HOME/.local/share/ntracking/*.log
rm -rf $HOME/local.share/ntracking/logs


sleep 2

################# update and restart
rustup update
sudo apt update -y && sudo apt upgrade -y
sudo reboot

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

############################################################################################################################################# comnet
elif [[ "$SELECTION" == "7" ]]; then
NUMBER_NODES=$(whiptail --title "Number of Nodes to start" --inputbox "\nEnter number of nodes" 8 40 $NUMBER_NODES 3>&1 1>&2 2>&3)
if [[ $? -eq 255 ]]; then
exit 0
fi

############################## count nodes directories and close fire wall
PORTS_TO_CLOSE=$(ls $HOME/.local/share/safe/node | wc -l)
sudo ufw delete allow $NODE_PORT_FIRST:$(($NODE_PORT_FIRST+$PORTS_TO_CLOSE-1))/tcp comment 'safe nodes'
############################## Stop Nodes and delete safe folder
pkill -e safenode
rm -rf $HOME/.local/share/safe
rm -rf $HOME/ntracking/*.log

sleep 2
############################## install client node and vdash and set up comnet  make sure and change download and unzip instructions and peer
cd
mkdir comnet
cd comnet
wget https://comnet-sn.s3.eu-west-2.amazonaws.com/maidsafe/main/safe-beta-x86_64-unknown-linux-musl.tar.gz
wget https://comnet-sn.s3.eu-west-2.amazonaws.com/maidsafe/main/safenode-beta-x86_64-unknown-linux-musl.tar.gz
sleep 1
tar -xvzf safe-beta-x86_64-unknown-linux-musl.tar.gz
tar -xvzf safenode-beta-x86_64-unknown-linux-musl.tar.gz
sleep 1
rm *.gz

cargo install vdash
############################## open ports 
sudo ufw allow $NODE_PORT_FIRST:$(($NODE_PORT_FIRST+$NUMBER_NODES-1))/tcp comment 'safe nodes'
sleep 2
############################## start nodes
for (( c=$NODE_PORT_FIRST; c<=$(($NODE_PORT_FIRST+$NUMBER_NODES-1)); c++ ))
do 
   sleep $NODE_START_DELAY && /home/ubuntu/comnet/safenode --peer /ip4/46.101.5.184/tcp/36301/p2p/12D3KooWBVHdavXJqggn396jQQevJvXtjTN1pwb8YqS65wyitTrx --port $c --max_log_files 2 --max_archived_log_files 1 2>&1 > /dev/null & disown
   echo "starting node on port $c with $NODE_START_DELAY second delay"
   NODE_START_DELAY=$(($NODE_START_DELAY+30))
done
sleep 2

############################# exit to Vdash
vdash --glob-path "$HOME/.local/share/safe/node/*/logs/safenode.log"

fi
