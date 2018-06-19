#!/bin/bash

DICT="Gx_3gpp_Rel9_with_metering.xml"
SCENARIO="scenario-oca-pcef-vasrefund.xml"
CONFIG="conf-pcef.xml"
LOG="log/pcef.log"

export PATH=.:$PATH
export LD_LIBRARY_PATH=/mexuser2/mex/anm/atmrl1/RL/seagull/lib:$LD_LIBRARY_PATH

/mexuser2/mex/anm/atmrl1/RL/seagull/bin/seagull -conf $CONFIG -dico $DICT -scen $SCENARIO -log $LOG -llevel A
