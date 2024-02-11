# SN Node Tracking 
See https://javages.github.io

Track Safe Network nodes.

## Requirements

- recent Linux. preferably Ubuntu
- safe client
- safe node
- sudo access - (ONLY if venv is not already installed)

## Setup

run the script direct from git hub

```bash <(curl -s https://raw.githubusercontent.com/safenetforum-community/ntracking/main/maid.sh)```
go to the bottom option on first menu select setup NTracking and Vdash

then select install NTracking master

the script will

clone the NTracking folder from git hub to ```~/.local/share/ntracking```
add this new folder to the path so you can execute scripts in it from anywhere
open port 80 on the fire wall
setup nginx web server to host your files NTracking site on port 80
create a folder in /var/www/ntracking to hold the published site
create cron jobs in the folder /etc/cron.d each ntracking job starts with ntracking in its name
to access the NTracking site from inside your local lan just enter the IP address of that pc into a web browser and it should display the NTracking website. if you are outside your own lan set up a port forward on port 80 to the NTracking master pc and use your router’s ip address.

a folder will be created at ~/.local/share/local_machine to this folder will be added

bandwidth usage on the hour
node statistics every 20 min
a node register y for there numbering
at 10 past the hour the cron job execute_steps script will be run which will copy the log files to the NTracking folder and generate the graphs and publish them to the nginx folder.

Do no run the script if you are

using port 80 for some thing
have nginx installed hosting a site
start and stop nodes using the script again or the maid.sh script that is installed localy as it clears out old logs between test nets.
if nodes are already running it wont matter for the first run of NTracking

after install is complete close the terminal and reopen to update the path

then you can run the scrip called maid.sh locally which is for starting stopping nodes etc

## Multi system setups

to get the multi system set up's working
run install NTracking slave on the slave system

generate a key pair on the master system ```ssh-keygen -t rsa```

then copy the public key from the master key pair into the slave authorised keys

```nano ~/.ssh/authorized_keys```
then create a config file on the master
```nano ~/.ssh/config```
paste in

```"Host s01
    HostName <ip address>
    User <username>
    Port <port>"```

then test it by doing ```ssh s01``` on the master

if it works accept the public key by typing yes

that’s it wait for some data and wait for 10 past the hour or run execute steps manually for a forced update.

to add extra systems up to 30 at present add the details for each machine in ```nano ~/.ssh/config``` using the same name format ie ```s02``` for machine 2
