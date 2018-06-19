#!/bin/bash

DICT="../etc/Gx_3gpp_Rel9__from_client_with_metering.xml"
SCENARIO="../etc/scenario-pcrf_test.xml"
CONFIG="../etc/conf-pcrf.xml"
LOG="../log/pcrf.log"

export PATH=.:$PATH
export LD_LIBRARY_PATH=../lib:$LD_LIBRARY_PATH

seagull -conf $CONFIG -dico $DICT -scen $SCENARIO -log $LOG -llevel E 
