#!/bin/bash

SEAGULL_HOME=/mexuser2/mex/anm/atmrl1/RL/seagull
DICT="$SEAGULL_HOME/etc/Gx_3gpp_Rel9_with_metering.xml"
SCENARIO="$SEAGULL_HOME/etc/scenario-tce-oca.xml"
CONFIG="$SEAGULL_HOME/etc/conf-tce-oca.xml"
LOG="$SEAGULL_HOME/log/tce-oca.log"

export PATH=$SEAGULL_HOME/bin:$PATH
export LD_LIBRARY_PATH=$SEAGULL_HOME/lib:$SEAGULL_HOME/bin:$LD_LIBRARY_PATH

seagull -bg -conf $CONFIG -dico $DICT -scen $SCENARIO -log $LOG -llevel ET
