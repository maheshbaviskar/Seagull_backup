#!/usr/bin/ksh
clear

NONE='\033[00m';
RED='\033[01;31m';
GREEN='\033[01;32m';
YELLOW='\033[01;33m';
PURPLE='\033[01;35m';
CYAN='\033[01;36m';
WHITE='\033[01;37m';

flag=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/scenario-oca-pcef-VoLTE.xml| cut -d'"' -f4`
flagc1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-VoLTE.xml| cut -d'"' -f4`
flagc2=`grep 'avp name="Event-Timestamp" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-VoLTE.xml| cut -d'"' -f4`
flagc3=`grep 'avp name="Access-Network-Information" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-VoLTE.xml| cut -d'"' -f4`
flagc4=`grep 'avp name="Subscription-Network-Code" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-VoLTE.xml| cut -d'"' -f4`
flagc5=`grep 'avp name="CC-Time" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-VoLTE.xml| cut -d'"' -f4`
flagc6=`grep 'avp name="Role-Of-Node" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-VoLTE.xml| cut -d'"' -f4`
flagc7=`grep 'avp name="Called-Party-Address" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-VoLTE.xml| cut -d'"' -f4`
flagc8=`grep 'avp name="Calling-Party-Address" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-VoLTE.xml| cut -d'"' -f4`


flag=`echo $flag| cut -d' ' -f1`
flag1=`echo $flagc1| cut -d' ' -f1`
flag2=`echo $flagc2| cut -d' ' -f1`
flag3=`echo $flagc3| cut -d' ' -f1`
flag4=`echo $flagc4| cut -d' ' -f1`
flag5=`echo $flagc5| cut -d' ' -f1`
flag6=`echo $flagc6| cut -d' ' -f1`
flag7=`echo $flagc7| cut -d' ' -f1`
flag8=`echo $flagc8| cut -d' ' -f1`


Session="VOICE_event_$(date +%d%b%H%M%S)"
echo "Auto Session_id picked (your session id will be $GREEN $Session $NONE)"

echo "enter the MSISDN (Current MSISDN in file ${GREEN} $flag1 ${NONE})"
read MSISDN

echo "enter the TIME STAMP (Current Event-Timestamp in file ${GREEN} $flag2 ${NONE})"
read TIMESTAMP 

echo "enter the SNC (Current Subscription-Network-Code in file ${GREEN} $flag4 ${NONE})"
read SNC

echo "enter the NC (Current Network Code in file ${GREEN} $flag3 ${NONE})"
read NC

echo "enter the CC time (Current CC Time in file ${GREEN} $flag5 ${NONE})"
read CCT

echo "enter the Role-Of-Node (Current  Role-Of-Node in file ${GREEN} $flag6 ${NONE})"
read ST

echo "enter the Called-Party-Address (Current Called-Party-Address in file ${GREEN} $flag7 ${NONE})"
read CPA

echo "enter the Calling-Party-Address (Current Calling-Party-Address in file ${GREEN} $flag8 ${NONE})"
read CP


echo ${Session}
echo ${MSISDN}
echo ${TIMESTAMP}
echo ${SNC}
echo ${NC}
echo ${CCT}
echo ${ST}
echo ${CPA}
echo ${CP}



sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flag/set-value\ name\=\"Session-Id\"\ format\=\"$Session/g" scenario-oca-pcef-VoLTE.xml
sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flag1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-VoLTE.xml
sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flag2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-VoLTE.xml
sed -i "s/avp\ name\=\"Access-Network-Information\"\ value\=\"$flag3/avp\ name\=\"Access-Network-Information\"\ value\=\"$NC/g" scenario-oca-pcef-VoLTE.xml
sed -i "s/avp\ name\=\"Subscription-Network-Code\"\ value\=\"$flag4/avp\ name\=\"Subscription-Network-Code\"\ value\=\"$SNC/g" scenario-oca-pcef-VoLTE.xml
sed -i "s/avp\ name\=\"CC-Time\"\ value\=\"$flag5/avp\ name\=\"CC-Time\"\ value\=\"$CCT/g" scenario-oca-pcef-VoLTE.xml
sed -i "s/avp\ name\=\"Role-Of-Node\"\ value\=\"$flag6/avp\ name\=\"Role-Of-Node\"\ value\=\"$ST/g" scenario-oca-pcef-VoLTE.xml
sed -i "s/avp\ name\=\"Called-Party-Address\"\ value\=\"$flag7/avp\ name\=\"Called-Party-Address\"\ value\=\"$CPA/g" scenario-oca-pcef-VoLTE.xml
sed -i "s/avp\ name\=\"Calling-Party-Address\"\ value\=\"$flag8/avp\ name\=\"Calling-Party-Address\"\ value\=\"$CP/g" scenario-oca-pcef-VoLTE.xml

./pcef-volte.sh

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

