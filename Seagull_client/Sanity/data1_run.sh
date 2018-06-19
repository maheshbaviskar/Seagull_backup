#!/usr/bin/ksh

NONE='\033[00m';
RED='\033[01;31m';
GREEN='\033[01;32m';
YELLOW='\033[01;33m';
PURPLE='\033[01;35m';
CYAN='\033[01;36m';
WHITE='\033[01;37m';

clear
flag=`grep 'set-value name="Session-Id" format="' ~/mahesh/Seagull_client/scenario-oca-pcef-data.xml| cut -d'"' -f4`
flag1=`grep 'avp name="Subscription-Id-Data" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-data.xml| cut -d'"' -f4`
flag2=`grep 'avp name="Event-Timestamp" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-data.xml| cut -d'"' -f4`
flagc5=`grep 'avp name="Rating-Group" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-data.xml| cut -d'"' -f4`
flagc3=`grep 'avp name="CC-Total-Octets" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-data.xml| cut -d'"' -f4`
flagc4=`grep 'avp name="3GPP-User-Location-Info" value="' ~/mahesh/Seagull_client/scenario-oca-pcef-data.xml| cut -d'"' -f4`

flag=`echo $flag| cut -d' ' -f1`
flag1=`echo $flag1| cut -d' ' -f1`
flag2=`echo $flag2| cut -d' ' -f1`
flag3=`echo $flagc3| cut -d' ' -f1`
flag4=`echo $flagc4| cut -d' ' -f1`
flag5=`echo $flagc5| cut -d' ' -f1`

MSISDN=`cut -d',' data_file.txt -f1`

Session="DATA_event_$(date +%d%b%H%M%S)"
echo "Auto Session_id picked (your session id will be $GREEN $Session $NONE)"


filename="data_file.txt"

for i in 1
do
#	./pcef-data.sh
	echo $i
done

while read -r line
do
     name="$line"
     echo "Name read from file - $name"
     MSISDN="$(echo $name | cut -d',' -f1)"
     TIMESTAMP="$(echo $name | cut -d',' -f2)"
     sed -i "s/set-value\ name\=\"Session-Id\"\ format\=\"$flag/set-value\ name\=\"Session-Id\"\ format\=\"$Session/g" scenario-oca-pcef-data.xml
     sed -i "s/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$flag1/avp\ name\=\"Subscription-Id-Data\"\ value\=\"$MSISDN/g" scenario-oca-pcef-data.xml
     sed -i "s/avp\ name\=\"Event-Timestamp\"\ value\=\"$flag2/avp\ name\=\"Event-Timestamp\"\ value\=\"$TIMESTAMP/g" scenario-oca-pcef-data.xml
        echo $MSISDN $TIMESTAMP
        echo "------------------------"
	echo "paush"
	sleep 2
	for i in 1
	do 
		./pcef-data.sh
	done
	echo "break"

done < "$filename"
