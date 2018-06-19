#!/bin/bash

DICT="../etc/Gx_3gpp_Rel9_with_metering.xml"
SCENARIO="../etc/scenario-oca-pcef.xml"
CONFIG="../etc/conf-pcef.xml"
LOG="../log/pcef.log"

export PATH=.:$PATH
export LD_LIBRARY_PATH=../lib:$LD_LIBRARY_PATH

seagull -conf $CONFIG -dico $DICT -scen $SCENARIO -log $LOG -llevel E
