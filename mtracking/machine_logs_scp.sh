#!/bin/bash

DEST_BASE_DIR="$HOME/.local/share/ntracking"

rsync -avz --update $HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_Server.log

rsync -avz --update system_01:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S01.log 
rsync -avz --update system_02:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S02.log 
rsync -avz --update system_03:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S03.log 
rsync -avz --update system_04:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S04.log 
rsync -avz --update system_05:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S05.log 
rsync -avz --update system_06:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S06.log 
rsync -avz --update system_07:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S07.log 
rsync -avz --update system_08:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S08.log 
rsync -avz --update system_09:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S09.log 
rsync -avz --update system_10:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S10.log
rsync -avz --update system_11:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S11.log
rsync -avz --update system_12:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S12.log
rsync -avz --update system_13:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S13.log
rsync -avz --update system_14:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S14.log
rsync -avz --update system_15:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S15.log
rsync -avz --update system_16:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S16.log
rsync -avz --update system_17:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S17.log
rsync -avz --update system_18:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S18.log
rsync -avz --update system_19:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S19.log
rsync -avz --update system_20:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S20.log
rsync -avz --update system_21:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S21.log
rsync -avz --update system_22:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S22.log
rsync -avz --update system_23:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S23.log
rsync -avz --update system_24:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S24.log
rsync -avz --update system_25:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S25.log
rsync -avz --update system_26:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S26.log
rsync -avz --update system_27:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S27.log
rsync -avz --update system_28:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S28.log
rsync -avz --update system_29:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S29.log
rsync -avz --update system_30:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S30.log
