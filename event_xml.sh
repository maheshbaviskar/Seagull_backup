#!/usr/bin/ksh

# Logical Date update script to maintain historical logical date data."
# Written By:Mahesh Baviskar

NONE='\033[00m';
RED='\033[01;31m';
GREEN='\033[01;32m';
YELLOW='\033[01;33m';
PURPLE='\033[01;35m';
CYAN='\033[01;36m';
WHITE='\033[01;37m';


ENBCONN1="QABPREF5/connect5@QAABP"
#cp $ABP_CUSTOM_BIN/bl9PETemplate.xml ~/mahesh
#chmod 777 ~/mahesh/bl9PETemplate.xml

flag=`grep active $ABP_PRIVATE_BIN/bl9PETemplate.xml | cut -d'"' -f2`
echo $flag
#sed -i "s/active\=\"false\"/active\=\"true\"/g" ~/mahesh/bl9PETemplate.xml

if [ $flag = "false" ]; then 
echo "${PURPLE}currently Event xml's are DISABLED on the env"
echo "select Option 'y' if you want to Activate the event xml- y or n for skipp"
read opt

if [[ $opt = 'y' ]]; then
cp $ABP_CUSTOM_BIN/bl9PETemplate.xml $ABP_PRIVATE_BIN/bl9PETemplate.xml 
sed -i "s/active\=\"false\"/active\=\"true\"/g" $ABP_PRIVATE_BIN/bl9PETemplate.xml

sqlplus -s ${ENBCONN1} << BLOCK

  UPDATE bl1_conf_section_params SET PARAM_VALUE='${ABP_PRIVATE_BIN}/bl9PETemplate.xml' WHERE PARAM_NAME = 'PETemplate' and custom_level = 9;
commit;
BLOCK
echo $i
#echo 'no of rows modified in DB $LDCOUNT1'
echo "${GREEN}Even xml's are enabled on the server\nPls bounce the BTLSOR and BTLQUOTE${NONE}" 
else 
echo "${RED}you have skipped the event xml enable mode${NONE}" 
fi
else
LDCOUNT=`sqlplus -s ${ENBCONN1} << BLOCK
set term off
set head off
set feedback off
select PARAM_VALUE from bl1_conf_section_params where PARAM_NAME = 'PETemplate' and custom_level = 9;
exit
BLOCK`

s1=`echo $LDCOUNT|cut -d'}' -f1`
s2=`echo $s1|cut -d'{' -f2`
if [[ $s2 == 'ABP_CUSTOM_BIN' ]]
then
sqlplus -s ${ENBCONN1} << BLOCK

  UPDATE bl1_conf_section_params SET PARAM_VALUE='${ABP_PRIVATE_BIN}/bl9PETemplate.xml' WHERE PARAM_NAME = 'PETemplate' and custom_level = 9;
commit;
BLOCK

echo "${YELLOW}PARAM_VALUE value updated with correct value pls bounce the env to reflect the changes${NONE}"
else
echo "${YELLOW}Event xml's are already Enabled${NONE}"
fi

fi 
