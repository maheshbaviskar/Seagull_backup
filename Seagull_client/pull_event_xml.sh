


echo "enter the session for which you wanmt to puu the Protocol xml"
read Session

echo $Session

fname=`find $ABP_APR_ROOT/log/ES_RB589/ -type f| xargs grep -l $Session | xargs ls -lrt | grep Protocol`

echo " pls check below protocol xml's\n $fname"

