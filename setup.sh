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
"1" "Install NTracking" OFF \
"2" "Update NTracking" ON \
"3" "Uninstall NTracking " OFF \
"4" "Setup Dynamic DNS service            " OFF 3>&1 1>&2 2>&3)


if [[ $? -eq 255 ]]; then
exit 0
fi

######################################################################################################################## Install NTracking
if [[ "$SELECTION" == "1" ]]; then

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

############ setup cron tasks


############ install pre requsites
#Install venv
clear
echo "install venve"
sleep 2
sudo apt install python3.10-venv

# Set up a virtual environment (venv)
clear
echo "setup virtual enviroment"
sleep 2
python3 -m venv $HOME/.local/share/ntracking/RPvenv
source $HOME/.local/share/ntracking/RPvenv/bin/activate


# install prerequzits

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

#clear
#echo "jinga"
#sleep 2
#pip3 install matplotlib

#!/usr/bin/env bash

######################################################################################################################## Update NTracking
elif [[ "$SELECTION" == "2" ]]; then

echo "2"
######################################################################################################################## Uninstall NTracking
elif [[ "$SELECTION" == "3" ]]; then

echo "3"
######################################################################################################################## Setup Dynamic DNS service
elif [[ "$SELECTION" == "4" ]]; then

echo "4"

fi
