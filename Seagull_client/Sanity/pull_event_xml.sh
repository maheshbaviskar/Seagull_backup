# developed by mahesh

NONE='\033[00m';
RED='\033[01;31m';
GREEN='\033[01;32m';
YELLOW='\033[01;33m';
PURPLE='\033[01;35m';
CYAN='\033[01;36m';
WHITE='\033[01;37m';



echo "$GREEN enter the session for which you wanmt to puu the Protocol xml $NONE"
read Session

echo $Session

fname=`find $ABP_APR_ROOT/log/ES_RB589/ -type f| xargs grep -l $Session`
if [[ $fname == "" ]]
then
break
else
echo " $YELLOW pls check below protocol xml's$NONE \n $fname"
fi
fname1=`find $ABP_APR_ROOT/log/ES_RB589/ -type f| xargs grep -l $Session | xargs ls| grep Event`
if [[ $fname1 == null ]]
then 
break
else
echo "$PURPLE pls see Notification's generated  $NONE\n $fname1"
fi
echo "\n"

egrep --color -E '^|99|RTN' $fname1 |grep 99 $fname1 | grep RTN
#result=`egrep --color -E '^|99|RTN' $fname1 |grep 99 $fname1 | grep RTN`


#egrep --color -E '^|99|RTN' $result

#echo `$result|grep --color green '^|99|RTN'`

