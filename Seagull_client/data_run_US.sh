#!/bin/bash

NONE='\033[00m';
RED='\033[01;31m';
GREEN='\033[01;32m';
YELLOW='\033[01;33m';
PURPLE='\033[01;35m';
CYAN='\033[01;36m';
WHITE='\033[01;37m';

clear
flag=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/scenario-oca-pcef-data_US.xml| cut -d'"' -f4`
flag1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-data_US.xml| cut -d'"' -f4`
flag2=`grep 'avp name="Event-Timestamp" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-data_US.xml| cut -d'"' -f4`
flagc5=`grep 'avp name="Rating-Group" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-data_US.xml| cut -d'"' -f4`
flagc3=`grep 'avp name="CC-Total-Octets" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-data_US.xml| cut -d'"' -f4`
flagc4=`grep 'avp name="3GPP-User-Location-Info" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-data_US.xml| cut -d'"' -f4`

flag=`printf $flag| cut -d' ' -f1`
flag1=`printf $flag1| cut -d' ' -f1`
flag2=`printf $flag2| cut -d' ' -f1`
flag3=`printf $flagc3| cut -d' ' -f1`
flag4=`printf $flagc4| cut -d' ' -f1`
flag5=`printf $flagc5| cut -d' ' -f1`


Session="DATA_event_$(date +%d%b%H%M%S)"
printf "Auto Session_id picked (your session id will be $GREEN $Session $NONE)\n"

printf "enter the MSISDN (current MSISDN $GREEN $flag1 $NONE)\n"
read MSISDN

printf "enter the Rating-Group (current Rating-Group $GREEN $flag5 $NONE) \n"
read GPP

printf "enter the TIME STAMP (Current TimeStamp $GREEN $flag2 $NONE)\n"
read TIMESTAMP 

printf "enter the CC-Total-Octets (Current CC-Total-Octets $GREEN $flag3 $NONE)\n"
read SNC

printf "enter the 3GPP-User-Location-Info (Current 3GPP-User-Location-Info $GREEN $flag4 $NONE)\n"
#read NC

printf ${Session}
printf ${MSISDN}
printf ${GPP}
printf ${TIMESTAMP}
printf ${SNC}
printf ${NC}


sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flag/set-value\ name\=\"Session-Id\"\ format\=\"$Session/g" scenario-oca-pcef-data_US.xml
sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flag1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-data_US.xml
sed -i "s/avp\ name\=\"Rating-Group\"\ value\=\"$flag5/avp\ name\=\"Rating-Group\"\ value\=\"$GPP/g" scenario-oca-pcef-data_US.xml
sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flag2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-data_US.xml
sed -i "s/avp\ name\=\"CC-Total-Octets\"\ value\=\"$flag3/avp\ name\=\"CC-Total-Octets\"\ value\=\"$SNC/g" scenario-oca-pcef-data_US.xml
#sed -i "s/avp\ name\=\"3GPP-User-Location-Info\"\ value\=\"$flag4/avp\ name\=\"3GPP-User-Location-Info\"\ value\=\"$NC/g" scenario-oca-pcef-data_US.xml

./pcef-data_US.sh
printf "${PURPLE} EVENT and Protocol  XML file names to validate\n"

find $ABP_APR_ROOT/log/ES_RB589/ -type f| xargs grep -l $Session

fname=`find $ABP_APR_ROOT/log/ES_RB589/ -type f| xargs grep -l $Session | xargs ls -lrt | grep Protocol`

fname1=`echo $fname |cut -d' ' -f9`

if [[ $fname1 == "" ]] 
then
printf "XML not generated for this session\n"
s=`ls -lrt log| tail -1`
s1=`printf $s| cut -d' ' -f9`
p=`cat log/$s1| tail -n5 |head -1`
printf $p

else
printf "\n\n${RED} Protocol xml file name \n $fname1\n"



printf "\n${YELLOW}protocol xml Response \n "
fname3=`tail -2 $fname1`
printf $fname3


fname2=`echo $fname3| tr '<' '\n' | grep "Result-Code"`


printf "\n${CYAN} Result codes from XML \n $fname2\n"

fi

printf "${NONE}\n"




