#!/bin/bash

DICT="../etc/Gx_3gpp_Rel9_with_metering.xml"
SCENARIO="../etc/scenario-iscp-update-language.xml"
CONFIG="../etc/conf-iscp-pnr.xml"
LOG="../log/iscp-update-language.log"

export PATH=.:$PATH
export LD_LIBRARY_PATH=../lib:$LD_LIBRARY_PATH

seagull -conf $CONFIG -dico $DICT -scen $SCENARIO -log $LOG -llevel A
