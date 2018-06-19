ENBCONN1="QABPAPP2/connect2@QAABP"

filename="data_file.txt"



for i in $(cat "data_file.txt")
do
     echo "Name read from file - $i"
     MSISDN="$(echo $i | cut -d',' -f1)"
     TIMESTAMP="$(echo $i | cut -d',' -f2)"
echo $MSISDN


temp_msisdn="$(echo $MSISDN | cut -c 3-)"
echo $temp_msisdn


PRIT_COUNT=`sqlplus -s ${ENBCONN1} << BLOCK
set term off
set head off
set feedback off

select 
AVE.NAME as "PACKAGE NAME" 
from APE1_VV_RELATION AVR,
APE1_PACKAGE_VERSION APR,
APE1_VV_ELEMENT AVE,
APE1_ITEM_VERSION AIV
where AVR.CHILD_ID = APR.ID
and APR.ID = AVE.ID
and AIV.PACKAGE_ID = AVR.CHILD_ID
and AVR.parent_id in ( select L9_OFFER_ID from ape1_accumulators  where OWNER_ID IN (select SUBSCRIBER_NO from subscriber where prim_resource_val like '$temp_msisdn'));
exit
BLOCK`

for i in $PRIT_COUNT
do
	echo $i
done

done
