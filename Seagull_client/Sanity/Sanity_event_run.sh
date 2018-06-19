#!/usr/bin/ksh

NONE='\033[00m';
RED='\033[01;31m';
GREEN='\033[01;32m';
YELLOW='\033[01;33m';
PURPLE='\033[01;35m';
CYAN='\033[01;36m';
WHITE='\033[01;37m';

clear
ENBCONN1="QABPAPP2/connect2@QAABP"
filename="data_file.txt"


for i in $(cat "data_file.txt")
do
     echo "Name read from file - $i"
     MSISDN="$(echo $i | cut -d',' -f1)"
     TIMESTAMP="$(echo $i | cut -d',' -f2)"
	flag=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data.xml| cut -d'"' -f4`
flag1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data.xml| cut -d'"' -f4`
flag2=`grep 'avp name="Event-Timestamp" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data.xml| cut -d'"' -f4`

flag=`echo $flag| cut -d' ' -f1`
flag1=`echo $flag1| cut -d' ' -f1`
flag2=`echo $flag2| cut -d' ' -f1`

#----------------Voice flags--------------------
flagv=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-voice.xml| cut -d'"' -f4`
flagcv1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-voice.xml| cut -d'"' -f4`
flagcv2=`grep 'avp name="Event-Timestamp" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-voice.xml| cut -d'"' -f4`

flagv=`echo $flagv| cut -d' ' -f1`
flagv1=`echo $flagcv1| cut -d' ' -f1`
flagv2=`echo $flagcv2| cut -d' ' -f1`

#-------------------------SMS filter--------------------------------------------
flags=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-sms.xml| cut -d'"' -f4`
flags1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-sms.xml| cut -d'"' -f4`
flags2=`grep 'avp name="Event-Timestamp" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-sms.xml| cut -d'"' -f4`

flags=`echo $flags| cut -d' ' -f1`
flags1=`echo $flags1| cut -d' ' -f1`
flags2=`echo $flags2| cut -d' ' -f1`
#----------------------------------- Facebook Data------------------------------------

flagb=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data_fb.xml| cut -d'"' -f4`
flagb1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data_fb.xml| cut -d'"' -f4`
flagb2=`grep 'avp name="Event-Timestamp" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data_fb.xml| cut -d'"' -f4`

flagb=`echo $flagb| cut -d' ' -f1`
flagb1=`echo $flagb1| cut -d' ' -f1`
flagb2=`echo $flagb2| cut -d' ' -f1`

Session="DATA_event_$(date +%d%b%H%M%S)"
echo "Auto Session_id picked (your session id will be $GREEN $Session $NONE)"
Sessionv="Voice_event_$(date +%d%b%H%M%S)"
Sessions="SMS_event_$(date +%d%b%H%M%S)"
Sessionb="Facebook_event_$(date +%d%b%H%M%S)"
     sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flag/set-value\ name\=\"Session-Id\"\ format\=\"$Session/g" scenario-oca-pcef-data.xml
     sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flag1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-data.xml
     sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flag2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-data.xml
#---------------------------------Voice file modify------------------
	sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flagv/set-value\ name\=\"Session-Id\"\ format\=\"$Sessionv/g" scenario-oca-pcef-voice.xml
	sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flagv1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-voice.xml
	sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flagv2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-voice.xml

        echo $MSISDN $TIMESTAMP
        echo "------------------------"
#-------------------------SMS filter--------------------------------------------

	sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flags/set-value\ name\=\"Session-Id\"\ format\=\"$Sessions/g" scenario-oca-pcef-sms.xml
	sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flags1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-sms.xml
	sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flags2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-sms.xml

#------------------------- Facebook Data----------------------------
	sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flagb/set-value\ name\=\"Session-Id\"\ format\=\"$Sessionb/g" scenario-oca-pcef-data_fb.xml
        sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flagb1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-data_fb.xml
        sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flagb2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-data_fb.xml
	

	echo "\n\n${CYAN}Data Event Result${NONE}"
	echo "Session Id for data is: $YELLOW $Session $NONE  and MSISDN :$YELLOW $MSISDN $NONE"
	/opt/app/attmex/mexabp2/mahesh/Seagull_client/Sanity/pcef-data.sh | egrep "Successful calls|Failed calls"| colorize #>temp #|grep "Successful calls"
        LDCOUNT=`sqlplus -s ${ENBCONN1} << BLOCK
	set term off
	set head off
	set feedback off
	select service_filter,L9_CHARGE_AMOUNT from ape1_rated_event  where L9_SESSION_ID ='$Session';
	exit
	BLOCK`

	Service_filter=`echo $LDCOUNT | cut -d' ' -f1`
	charge_amount=`echo $LDCOUNT | cut -d' ' -f2`
	print "Rated with Service filter: $GREEN $Service_filter $NONE and Charged $GREEN $charge_amount $NONE "

	sleep 5
	############################### Voice call##########################
	echo "\n\n${CYAN}Voice events Result${NONE}"
	echo "Session Id for voice is: $YELLOW $Sessionv $NONE and MSISDN : $YELLOW $MSISDN $NONE"
	/opt/app/attmex/mexabp2/mahesh/Seagull_client/Sanity/pcef-voice.sh | egrep "Successful calls|Failed calls"|colorize #>> #temp # |grep "Successful calls"
	LDCOUNT1=`sqlplus -s ${ENBCONN1} << BLOCK
	set term off
	set head off
	set feedback off
	select service_filter,L9_CHARGE_AMOUNT from ape1_rated_event  where L9_SESSION_ID ='$Sessionv';
	exit
	BLOCK`
	Service_filter1=`echo $LDCOUNT1 | cut -d' ' -f1`
        charge_amount1=`echo $LDCOUNT1 | cut -d' ' -f2`
        print "Rated with Service filter: $GREEN $Service_filter1 $NONE and Charged $GREEN $charge_amount1 $NONE"
	sleep 5
	############################### SMS call##########################
	echo "\n\n${CYAN}SMS event result${NONE}"
	echo "Session Id for SMS is: $YELLOW $Sessions $NONE and MSISDN : $YELLOW $MSISDN $NONE"
	/opt/app/attmex/mexabp2/mahesh/Seagull_client/Sanity/pcef-sms.sh | egrep "Successful calls|Failed calls"|colorize #>> temp  #|grep "Successful calls"
	LDCOUNT2=`sqlplus -s ${ENBCONN1} << BLOCK
	set term off
	set head off
	set feedback off
	select service_filter,L9_CHARGE_AMOUNT from ape1_rated_event  where L9_SESSION_ID ='$Sessions';
	exit
	BLOCK`
	Service_filter2=`echo $LDCOUNT2 | cut -d' ' -f1`
        charge_amount2=`echo $LDCOUNT2 | cut -d' ' -f2`
        print "Rated with Service filter: $GREEN $Service_filter2 $NONE and Charged $GREEN $charge_amount2 $NONE"
	#####################################Facebook######################
	#clear
	sleep 3
	echo "\n\n${CYAN}DATA Facebook Result${NONE}"
	echo "Session Id for Data facebook is: $YELLOW $Sessionb $NONE and MSISDN : $YELLOW $MSISDN $NONE"
	/opt/app/attmex/mexabp2/mahesh/Seagull_client/Sanity/pcef-data_fb.sh | egrep "Successful calls|Failed calls"|colorize #>> temp  #|grep "Successful calls"
	LDCOUNT3=`sqlplus -s ${ENBCONN1} << BLOCK
	set term off
	set head off
	set feedback off
	select service_filter,L9_CHARGE_AMOUNT from ape1_rated_event  where L9_SESSION_ID ='$Sessionb';
	exit
	BLOCK`
	Service_filter3=`echo $LDCOUNT3 | cut -d' ' -f1`
        charge_amount3=`echo $LDCOUNT3 | cut -d' ' -f2`
        print "Rated with Service filter: $GREEN $Service_filter3 $NONE and Charged $GREEN $charge_amount3 $NONE"
	
done

echo "${NONE}"
