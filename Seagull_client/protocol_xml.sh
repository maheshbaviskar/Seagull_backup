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

ENBCONN2="QABPCFG1/connect1@QAABP"

LDCOUNT=`sqlplus -s ${ENBCONN2} << BLOCK
set term off
set head off
set feedback off
select param_value from cfg1_conf_section_param where param_name like '%PROTOCOL_TRACING%';
exit
BLOCK`

echo $LDCOUNT

if [ $LDCOUNT = "true" ]; then
echo "event xml already set to true"
else
echo "it is set to false"
echo "Do you want to Enable the protocl XML? \nPress y for update else n"
read PE

if [[ ${PE} = 'y' ]] ; then
sqlplus -s ${ENBCONN2} << BLOCK
update cfg1_conf_section_param set param_value = 'true' where param_name like '%PROTOCOL_TRACING%';
commit;
BLOCK

else

echo "You have skipped the Event xml update, so xml won't be generated on the environment"
fi
print "${GREEN}Protocol XML are now enabled in Env"
print "Pls BOUNCE the Event server ES and RBi${NONE}";
fi

