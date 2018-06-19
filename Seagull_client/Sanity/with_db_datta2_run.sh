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


temp_msisdn="$( echo $MSISDN | cut -c 3- )"
echo $temp_msisdn


PRIT_COUNT=` sqlplus -s ${ENBCONN1} << BLOCK
set term off
set head off
set feedback off
select ITEM_ID from ape1_accumulators  where OWNER_ID in ( SELECT SUBSCRIBER_NO from subscriber where prim_resource_val like '$temp_msisdn');
exit
BLOCK `

echo $PRIT_COUNT


flag=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data.xml| cut -d'"' -f4`
flag1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data.xml| cut -d'"' -f4`
flag2=`grep 'avp name="Event-Timestamp" value="' ~/mahesh/Seagull_client/Sanity/scenario-oca-pcef-data.xml| cut -d'"' -f4`

flag=`echo $flag| cut -d' ' -f1`
flag1=`echo $flag1| cut -d' ' -f1`
flag2=`echo $flag2| cut -d' ' -f1`


Session="DATA_event_$(date +%d%b%H%M%S)"
echo "Auto Session_id picked (your session id will be $GREEN $Session $NONE)"
     sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flag/set-value\ name\=\"Session-Id\"\ format\=\"$Session/g" scenario-oca-pcef-data.xml
     sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flag1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-data.xml
     sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flag2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-data.xml
#---------------------------------Voice file modify------------------
	

	echo "\n\n${CYAN}Data Event Result${NONE}"
	echo "Session Id for data is: $Session and MSISDN : $MSISDN"
	/opt/app/attmex/mexabp2/mahesh/Seagull_client/Sanity/pcef-data.sh | egrep "Successful calls|Failed calls"| colorize #>temp #|grep "Successful calls"

	sleep 5


	
LDCOUNT=`sqlplus -s ${ENBCONN1} << BLOCK
set term off
set head off
set feedback off
select service_filter,L9_CHARGE_AMOUNT from ape1_rated_event  where L9_SESSION_ID ='$Session';
exit
BLOCK`

Service_filter=`echo $LDCOUNT | cut -d' ' -f1`
charge_amount=`echo $LDCOUNT | cut -d' ' -f2`
	if [ $Service_filter -eq 'GPRSNAT' ]
	then 
	echo ${YELLOW} "Service Filter is  $Service_filter " ${NONE}
	echo ${GREEN} "Charge amount is  $charge_amount" ${NONE}
	elif [ $Service_filter -eq NULL ]
	then
		echo "Vlidation Failed"
	else 
		echo "failed in service filter $Service_filter"
	fi
done

HARGE_AMOUNT
