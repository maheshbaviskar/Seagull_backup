#!/usr/bin/ksh
clear

NONE='\033[00m';
RED='\033[01;31m';
GREEN='\033[01;32m';
YELLOW='\033[01;33m';
PURPLE='\033[01;35m';
CYAN='\033[01;36m';
WHITE='\033[01;37m';


flag=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/scenario-oca-pcef-vas_BKP.xml| cut -d'"' -f4`
flag1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-vas_BKP.xml| cut -d'"' -f4`
flag2=`grep 'avp name="Event-Timestamp" value="' scenario-oca-pcef-vas_BKP.xml| cut -d'"' -f4`
flagc3=`grep 'avp name="Service-Parameter-value" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-vas_BKP.xml| cut -d'"' -f4`
flagc4=`grep 'avp name="Service-Parameter-value" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-vas_BKP.xml| cut -d'"' -f4`
flagc5=`grep 'avp name="Requested-Action" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-vas_BKP.xml| cut -d'"' -f4`
flagc6=`grep 'avp name="Value-Digits" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-vas_BKP.xml| cut -d'"' -f4`


flag=`echo $flag| cut -d' ' -f1`
flag1=`echo $flag1| cut -d' ' -f1`
flag2=`echo $flag2| cut -d' ' -f1`
flag3=`echo $flagc3| cut -d' ' -f1`
flag4=`echo $flagc4| cut -d' ' -f2`
flag5=`echo $flagc5| cut -d' ' -f1`
flag6=`echo $flagc6| cut -d' ' -f1`

Session="VAS_event_$(date +%d%b%H%M%S)"
echo "Auto Session_id picked (your session id will be $GREEN $Session $NONE)"

echo "enter the MSISDN (current MSISDN $GREEN $flag1 $NONE)"
read MSISDN

echo "enter the Event timestamp (Current TimeStamp $GREEN $flag2 $NONE)"
read TIMESTAMP 

echo "enter the Requested-Action (Current Requested-Action $GREEN $flag5 $NONE)"
read RA

echo "enter the Value-Digits (Current Value-Digits $GREEN $flag6 $NONE)"
read VD

echo "enter the Service-Parameter-value (Current Service-Parameter-value Code $GREEN $flag3 $NONE)"
read SNC

echo "enter the  Service-Parameter-value 2nd(Current Service-Parameter-value  Code $GREEN $flag4 $NONE)"
read NC

echo ${Session}
echo ${MSISDN}
echo ${TIMESTAMP}
echo ${SNC}
echo ${NC}


sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flag/set-value\ name\=\"Session-Id\"\ format\=\"$Session/g" scenario-oca-pcef-vas_BKP.xml
sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flag1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-vas_BKP.xml
sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flag2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-vas_BKP.xml
sed -i "s/avp\ name\=\"Service-Parameter-value\"\ value\=\"$flag3/avp\ name\=\"Service-Parameter-value\"\ value\=\"$SNC/g" scenario-oca-pcef-vas_BKP.xml
sed -i "s/avp\ name\=\"Service-Parameter-value\"\ value\=\"$flag4/avp\ name\=\"Service-Parameter-value\"\ value\=\"$NC/g" scenario-oca-pcef-vas_BKP.xml
sed -i "s/avp\ name\=\"Requested-Action\"\ value\=\"$flag5/avp\ name\=\"Requested-Action\"\ value\=\"$RA/g" scenario-oca-pcef-vas_BKP.xml
sed -i "s/avp\ name\=\"Value-Digits\"\ value\=\"$flag6/avp\ name\=\"Value-Digits\"\ value\=\"$VD/g" scenario-oca-pcef-vas_BKP.xml

./pcef-vas-credit.sh

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
fi


echo "\n${YELLOW}protocol xml Response \n "
fname3=`tail -2 $fname1`
echo $fname3


fname2=`echo $fname3| tr '<' '\n' | grep "Result-Code"`


echo "\n${CYAN} Result codes from XML \n $fname2"


echo "${NONE}"

