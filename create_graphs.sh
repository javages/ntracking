#!/bin/bash

install_dir="$HOME/.local/share/ntracking_working_folder"

cd $install_dir

# Activate virtual environment
source $HOME/.local/share/RPvenv/bin/activate

python3 $HOME/.local/share/ntracking/all_graphs.py

sleep 1
python3 $HOME/.local/share/ntracking/all_graphs.py


