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
MAIL_LIST="ATANEJA@amdocs.com,Ajinkya.Shirke@amdocs.com,Animi.Vikram@amdocs.com,Ankita.Gangrade@amdocs.com,Anuja.Kannawar@amdocs.com,Ashad.Rahman@amdocs.com,SINGHAS@amdocs.com,Avni.Gupta@amdocs.com,GOWRISHT@amdocs.com,Iqra.Khan@amdocs.com,Kirti.Patidar@amdocs.com,Mahesh.Baviskar@amdocs.com,MdFaiz.Akhtar@amdocs.com,Mohit.Jaiswal@amdocs.com,nikhil.jain1@amdocs.com,Pramod.Ks@amdocs.com,Pranshu.Sehgal@amdocs.com,RAHULGUP@amdocs.com,Rashmi.Sarmah@amdocs.com,Rashmi.Vyawahare@amdocs.com,Samridhi.Kochar@amdocs.com,SaradKumar.Jaiswal@amdocs.com,Shabnam.Udgatty@amdocs.com,Shalaka.Bajaj@amdocs.com,Shashank.Kumar@amdocs.com,Shilpa.Nanda@amdocs.com,Shouvanik.Sarkar@amdocs.com,Subhajit.Roy@amdocs.com,Utkarsh.Maheshwari@amdocs.com"
#MAIL_LIST="mb280q@att.com"
ENBCONN="QABPAPP10/connect10@QAP2ABP"
#ATTID=`who -m | awk '{print $1}'`;
#USERNAME=`finger | grep ${ATTID} | awk '{print $2 $3}' | sort -u`
print -n "${GREEN}Input desired logical date (format: 01-DEC-15): ${NONE}"
read LOGICALDATE
print
print "${GREEN}Requested logical date is ${YELLOW}${LOGICALDATE}${GREEN}, ${RED}CTRL+C to QUIT${GREEN}, else continue in 5 seconds... ${NONE}"
sleep 5
print

LDCOUNT=`sqlplus -s ${ENBCONN} << BLOCK
set term off
set head off
set feedback off
select count(*) from logical_date where logical_date = '${LOGICALDATE}';
exit
BLOCK`

if [[ ${LDCOUNT} -eq 3 ]] ; then
sqlplus -s ${ENBCONN} << BLOCK
update logical_date set expiration_date = sysdate where expiration_date is null;
update logical_date set expiration_date = null, sys_update_date = sysdate where logical_date = '${LOGICALDATE}';
commit;
exit
BLOCK

else

sqlplus -s ${ENBCONN} << BLOCK
update logical_date set expiration_date = sysdate where expiration_date is null;
commit;
Insert into LOGICAL_DATE
   (LOGICAL_DATE, LOGICAL_DATE_TYPE, SYS_CREATION_DATE, DL_SERVICE_CODE)
 Values
   ('${LOGICALDATE}', 'R', sysdate, 'DGN00');
Insert into LOGICAL_DATE
   (LOGICAL_DATE, LOGICAL_DATE_TYPE, SYS_CREATION_DATE, DL_SERVICE_CODE)
 Values
   ('${LOGICALDATE}', 'O', sysdate, 'DGN00');
Insert into LOGICAL_DATE
   (LOGICAL_DATE, LOGICAL_DATE_TYPE, SYS_CREATION_DATE, DL_SERVICE_CODE)
 Values
   ('${LOGICALDATE}', 'B', sysdate, 'DGN00');
COMMIT;
exit
BLOCK
fi

print

print "${GREEN}Logical date is now set to ${YELLOW}$LOGICALDATE${GREEN} and old entries have been expired.${NONE}"
print
echo "Logical Date of $USER has been changed to $LOGICALDATE" | mail -s "Logical Date Change Alert for $USER env" $MAIL_LIST
print "${CYAN}You need to run UTL1REFNOT to ensure this change will take effect.${NONE}"
print -n "${CYAN}Do you wish to do this now? (Y/N): ${NONE}"
read WLBOUNCE

if [[ ${WLBOUNCE} = 'y' ]] ; then
WLBOUNCE='Y'
fi

if [[ ${WLBOUNCE} = 'n' ]] ; then
WLBOUNCE='N'
fi

if [[ ${WLBOUNCE} = 'Y' ]] ; then
cd ~/var/mex/log
for file in UTL1REFNOT_ENDDAY_MEX*.log; do mv $file `echo $file | sed 's/\(.*\.\)log/\1old/'`; done
RunJobs UTL1REFNOT ENDDAY
WLMON=`cat UTL1REFNOT_ENDDAY_MEX*.log | grep -E 'Application run ended successfully' | wc -l`
while [[ ${WLMON} -lt 1 ]] ; do
sleep 5
WLMON=`cat UTL1REFNOT_ENDDAY_MEX*.log | grep -E 'Application run ended successfully' | wc -l`
done
print "${GREEN}Job Run Ended Successfully.${NONE}"
fi

if [[ ${WLBOUNCE} = 'N' ]] ; then
print
print "${RED}WARNING!!!"
print "${YELLOW}You have not Ran the Job yet logical date change will NOT take effect until this is done."
print "${RED}WARNING!!!${NONE}"
print
fi
