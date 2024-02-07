#!/bin/bash

install_dir="${HOME}/.local/share"

cd $install_dir

# Activate virtual environment
source $install_dir/RPvenv/bin/activate

python3 ntracking/all_graphs.py

sleep 1
python3 ntracking/node_info.py


