#!/bin/bash

DICT="Gx_3gpp_Rel9_with_metering.xml"
SCENARIO="scenario-oca-pcef-voice.xml"
CONFIG="conf-pcefvoice.xml"
LOG="log/pcef.log"

export PATH=.:$PATH
export LD_LIBRARY_PATH=~/mahesh/seagull/lib:$LD_LIBRARY_PATH

~/mahesh/seagull/bin/seagull -conf $CONFIG -dico $DICT -scen $SCENARIO -log $LOG -llevel A
