#!/usr/bin/ksh

NONE='\033[00m';
RED='\033[01;31m';
GREEN='\033[01;32m';
YELLOW='\033[01;33m';
PURPLE='\033[01;35m';
CYAN='\033[01;36m';
WHITE='\033[01;37m';

clear

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


	Session="DATA_event_$(date +%d%b%H%M%S)"
echo "Auto Session_id picked (your session id will be $GREEN $Session $NONE)"
Sessionv="Voice_event_$(date +%d%b%H%M%S)"
Sessions="SMS_event_$(date +%d%b%H%M%S)"
Sessionb="Facebook_event_$(date +%d%b%H%M%S)"
     sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flag/set-value\ name\=\"Session-Id\"\ format\=\"$Session/g" scenario-oca-pcef-data.xml
     sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flag1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-data.xml
     sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flag2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-data.xml
     
     	echo "\n\n${CYAN}Data Event Result${NONE}"
		  echo "Session Id for data is: $Session"
		  /opt/app/attmex/mexabp2/mahesh/Seagull_client/Sanity/pcef-data.sh | egrep "Successful calls|Failed calls"| colorize #>temp #|grep "Successful calls"

	sleep 3
#---------------------------------Voice file modify------------------
	Session="VOICE_event_$(date +%d%b%H%M%S)"
	echo "Auto Session_id picked (your session id will be $GREEN $Session $NONE)"
	 flag=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-voice.xml| cut -d'"' -f4`
		 flag1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-voice.xml| cut -d'"' -f4`
		 flag2=`grep 'avp name="Event-Timestamp" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-voice.xml| cut -d'"' -f4`

		flag=`echo $flag| cut -d' ' -f1`
		flag1=`echo $flag1| cut -d' ' -f1`
		flag2=`echo $flag2| cut -d' ' -f1`
		
	sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flag/set-value\ name\=\"Session-Id\"\ format\=\"$Session/g" scenario-oca-pcef-voice.xml
	sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flag1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-voice.xml
	sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flag2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-voice.xml

        echo $MSISDN $TIMESTAMP
        echo "------------------------"
  echo "\n\n${CYAN}Voice events Result${NONE}"
	echo "Session Id for voice is: $Sessionv"
	/opt/app/attmex/mexabp2/mahesh/Seagull_client/Sanity/pcef-voice.sh | egrep "Successful calls|Failed calls"|colorize #>> #temp # |grep "Successful calls"

	sleep 2
#-------------------------SMS filter--------------------------------------------
Session="SMS_event_$(date +%d%b%H%M%S)"
	echo "Auto Session_id picked (your session id will be $GREEN $Session $NONE)"
 flag=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-sms.xml| cut -d'"' -f4`
		 flag1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-sms.xml| cut -d'"' -f4`
		 flag2=`grep 'avp name="Event-Timestamp" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-sms.xml| cut -d'"' -f4`

		flag=`echo $flag| cut -d' ' -f1`
		flag1=`echo $flag1| cut -d' ' -f1`
		flag2=`echo $flag2| cut -d' ' -f1`

	sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flag/set-value\ name\=\"Session-Id\"\ format\=\"$Session/g" scenario-oca-pcef-sms.xml
	sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flag1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-sms.xml
	sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flag2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-sms.xml
	
echo "\n\n${CYAN}SMS event result${NONE}"
	echo "Session Id for SMS is: $Sessions"
	/opt/app/attmex/mexabp2/mahesh/Seagull_client/Sanity/pcef-sms.sh | egrep "Successful calls|Failed calls"|colorize #>> temp  #|grep "Successful calls"


#------------------------- Facebook Data----------------------------
Session="Facebook_event_$(date +%d%b%H%M%S)"
	echo "Auto Session_id picked (your session id will be $GREEN $Session $NONE)"
 flag=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data_fb.xml| cut -d'"' -f4`
		 flag1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data_fb.xml| cut -d'"' -f4`
		 flag2=`grep 'avp name="Event-Timestamp" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data_fb.xml| cut -d'"' -f4`

		flag=`echo $flag| cut -d' ' -f1`
		flag1=`echo $flag1| cut -d' ' -f1`
		flag2=`echo $flag2| cut -d' ' -f1`
		
	sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flag/set-value\ name\=\"Session-Id\"\ format\=\"$Session/g" scenario-oca-pcef-data_fb.xml
        sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flag1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-data_fb.xml
        sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flag2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-data_fb.xml
	
sleep 3
	echo "\n\n${CYAN}DATA Facebook Result${NONE}"
	echo "Session Id for Data facebook is: $Sessionb"
	/opt/app/attmex/mexabp2/mahesh/Seagull_client/Sanity/pcef-data_fb.sh | egrep "Successful calls|Failed calls"|colorize #>> temp  #|grep "Successful calls"


	############################### Voice call##########################

echo "${NONE}"

done
