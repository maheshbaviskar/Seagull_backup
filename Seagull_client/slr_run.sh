#!/usr/bin/ksh

NONE='\033[00m';
RED='\033[01;31m';
GREEN='\033[01;32m';
YELLOW='\033[01;33m';
PURPLE='\033[01;35m';
CYAN='\033[01;36m';
WHITE='\033[01;37m';

clear
flag=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/scenario-oca-pcef-slr.xml| cut -d'"' -f4`
flag1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-slr.xml| cut -d'"' -f4`
flag2=`grep 'avp name="A-Net-Start-Time" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-slr.xml| cut -d'"' -f4`
flagc5=`grep 'avp name="3GPP-SGSN-MCC-MNC" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-slr.xml| cut -d'"' -f4`
flagc3=`grep 'avp name="Policy-Counter-Identifier" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-slr.xml| cut -d'"' -f4`
flagc4=`grep 'avp name="Address-data" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-slr.xml| cut -d'"' -f4`

flag=`echo $flag| cut -d' ' -f1`
flag1=`echo $flag1| cut -d' ' -f1`
flag2=`echo $flag2| cut -d' ' -f1`
flag3=`echo $flagc3| cut -d' ' -f1`
flag4=`echo $flagc4| cut -d' ' -f1`
flag5=`echo $flagc5| cut -d' ' -f1`


Session="SLR_event_$(date +%d%b%H%M%S)"
echo "Auto Session_id picked (your session id will be $GREEN $Session $NONE)"

echo "enter the MSISDN (current MSISDN $GREEN $flag1 $NONE)"
read MSISDN

#echo "enter the 3GPP-SGSN-MCC-MNC (current 3GPP-SGSN-MCC-MNC $GREEN $flag5 $NONE)"
#read GPP

#echo "enter the TIME STAMP(A-Net-Start-Time) (Current TimeStamp $GREEN $flag2 $NONE)"
#read TIMESTAMP 

#echo "enter the Policy-Counter-Identifier (Current Policy-Counter-Identifier $GREEN $flag3 $NONE)"
#read SNC

#echo "enter the NC (Current Address-data $GREEN $flag4 $NONE)"
#read NC

echo ${Session}
echo ${MSISDN}
echo ${GPP}
echo ${TIMESTAMP}
echo ${SNC}
echo ${NC}


sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flag/set-value\ name\=\"Session-Id\"\ format\=\"$Session/g" scenario-oca-pcef-slr.xml
sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flag1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-slr.xml
#sed -i "s/avp\ name\=\"3GPP-SGSN-MCC-MNC\"\ value\=\"$flag5/avp\ name\=\"3GPP-SGSN-MCC-MNC\"\ value\=\"$GPP/g" scenario-oca-pcef-slr.xml
#sed -i "s/avp\ name\=\"A-Net-Start-Time\"\ value\=\"$flag2/avp\ name\=\"A-Net-Start-Time\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-slr.xml
#sed -i "s/avp\ name\=\"Policy-Counter-Identifier\"\ value\=\"$flag3/avp\ name\=\"Policy-Counter-Identifier\"\ value\=\"$SNC/g" scenario-oca-pcef-slr.xml
#sed -i "s/avp\ name\=\"Address-data\"\ value\=\"$flag4/avp\ name\=\"Address-data\"\ value\=\"$NC/g" scenario-oca-pcef-slr.xml

./pcef-slr.sh

echo "${PURPLE} EVENT and Protocol  XML file names to validate"

find $ABP_APR_ROOT/log/ES_RB589/ -type f| xargs grep -l $Session

fname=`find $ABP_APR_ROOT/log/ES_RB589/ -type f| xargs grep -l $Session | xargs ls -lrt | grep Protocol`

fname1=`echo $fname |cut -d' ' -f9`

if [[ $fname1 == "" ]] then;
echo "XML not generated for this session"
s=`ls -lrt log| tail -1`
s1=`echo $s| cut -d' ' -f9`
p=`cat log/$s1| tail -n5 |head -1`
echo $p

else
echo "\n\n${RED} Protocol xml file name \n $fname1"



echo "\n${YELLOW}protocol xml Response \n "
fname3=`tail -2 $fname1`
echo $fname3


fname2=`echo $fname3| tr '<' '\n' | grep "Result-Code"`


echo "\n${CYAN} Result codes from XML \n $fname2"

fi

echo "${NONE}"




