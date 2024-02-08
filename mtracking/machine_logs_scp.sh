#!/bin/bash

DEST_BASE_DIR="$HOME/.local/share/ntracking"

rsync -avz --update $HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S00.log

rsync -avz --update s01:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S01.log 
rsync -avz --update s02:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S02.log 
rsync -avz --update s03:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S03.log 
rsync -avz --update s04:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S04.log 
rsync -avz --update s05:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S05.log 
rsync -avz --update s06:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S06.log 
rsync -avz --update s07:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S07.log 
rsync -avz --update s08:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S08.log 
rsync -avz --update s09:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S09.log 
rsync -avz --update s10:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S10.log
rsync -avz --update s11:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S11.log
rsync -avz --update s12:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S12.log
rsync -avz --update s13:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S13.log
rsync -avz --update s14:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S14.log
rsync -avz --update s15:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S15.log
rsync -avz --update s16:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S16.log
rsync -avz --update s17:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S17.log
rsync -avz --update s18:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S18.log
rsync -avz --update s19:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S19.log
rsync -avz --update s20:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S20.log
rsync -avz --update s21:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S21.log
rsync -avz --update s22:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S22.log
rsync -avz --update s23:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S23.log
rsync -avz --update s24:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S24.log
rsync -avz --update s25:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S25.log
rsync -avz --update s26:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S26.log
rsync -avz --update s27:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S27.log
rsync -avz --update s28:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S28.log
rsync -avz --update s29:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S29.log
rsync -avz --update s30:$HOME/.local/share/local_machine/machine_resources.log $DEST_BASE_DIR/Machine_S30.log
