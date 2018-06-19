#!/bin/ksh

################################################################################
#                                                                              #
# Name: Start_UP_ABP_env.sh                                                    #
#                                                                              #
# Author: Mahesh Baviskar                                                      # 
#                                                                              #
# Date: Jan 2007                                                               #
#                                                                              #
# Description: The script starts UP ABP environmnets                           #
#                                                                              #
################################################################################


#  42 - paint the line in green
#
#
#
#


ATL1_Env_Information

#######################
# Checking up GemFire #
#######################

cd ${HOME}/GemFire/Server/scripts

${HOME}/GemFire/Server/scripts/pingGemfire  | grep -e stop -e shutdown
if [ $? -eq 1 ]
 then
    echo "=============="
    echo "GemFire is  UP"
    echo "=============="
else    
  echo "================================================"
  echo "GemFire FAILED to start, please check the reason"
  echo "================================================"

fi

cd ${HOME}/JEE/ABPProduct/scripts/ABP-FULLZ01

${HOME}/JEE/ABPProduct/scripts/ABP-FULLZ01/pingABPServer.sh  | grep -e DOWN
if [ $? -eq 1 ]
 then
    echo "=============="
    echo "Server is  UP"
    echo "=============="
else    
  echo "================================================"
  echo "Server is FAILED to start, please check the reason"
  echo "================================================"

fi

##########################
# Checking Daemons state #
##########################

echo "=============="
echo "DAEMONS STATE:"
echo "=============="

st=`ps -fu $USER | grep "amc1_DmnEnvelope DmnMng" | grep -v grep |wc -l`

if [ $st -ne 1 ]
 then
      echo "==========================================================="
      echo "\033[35m DaemonManager \033[0m \033[41m FAILED  \033[0m to start, please check the reason "  
      echo "==========================================================="
 else
      echo "==================="     
      echo "\033[35m DaemonManager  \033[32m UP\033[0m"                                     
      echo "==================="
fi




st=`ps -fu $USER | grep "Ac1FtcManager" |grep -v grep |wc -l`

if [ $st -ne 1 ]
 then
      echo "========================================================"
      echo "\033[35m AC1MANAGER \033[0m \033[41m FAILED \033[0m to start, please check the reason"
      echo "========================================================"
 else
      echo "================"
      echo "\033[35m AC1MANAGER \033[32m UP\033[0m "
      echo "================"
fi


st=`ps -fu $USER | grep "TRB1Manager 1" |grep -v grep |wc -l`   

if [ $st -ne 1 ]
 then
      echo "=========================================================="
      echo "\033[35m TRB1ENGINE_1 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
      echo "=========================================================="
 else
      echo "=================="
      echo "\033[35m TRB1ENGINE_1 \033[32m UP \033[0m"
      echo "=================="
fi

st=`ps -fu $USER | grep "amc_mro" |grep -v grep |wc -l`                                            

if [ $st -ne 1 ]
 then
      echo "======================================================"
      echo "\033[35m OP1MRO_1 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
      echo "======================================================"
 else
      echo "=============="
      echo "\033[35m OP1MRO_1 \033[32m UP\033[0m "
      echo "=============="
fi


st=`ps -fu $USER | grep "amc1_DmnEnvelope TLS1_APInvoker_1_1" |grep -v grep |wc -l`

if [ $st -ne 1 ]
 then
	 		echo "======================================================="
	 		echo "\033[35m TLS1APINV1 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
	 		echo "======================================================="
 else
	 		echo "==============="
	 		echo "\033[35m TLS1APINV1 \033[32m UP \033[0m"
	 		echo "==============="	
fi
	 
st=`ps -fu $USER | grep "amc1_DmnEnvelope TLS1_APInvoker_2_1" |grep -v grep |wc -l`

if [ $st -ne 1 ]
 then
                        echo "======================================================="
                        echo "\033[35m TLS1APINV2 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m TLS1APINV2 \033[32m UP \033[0m"
                        echo "==============="
fi

st=`ps -fu $USER | grep "amc1_DmnEnvelope TLS1_APInvoker_7_1" |grep -v grep |wc -l`

if [ $st -ne 1 ]
 then
                        echo "======================================================="
                        echo "\033[35m TLS1APINV7 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m TLS1APINV7 \033[32m UP \033[0m"
                        echo "==============="
fi

	
 
st=`ps -fu $USER | grep "bl1BTLServer -n BL1BTLSOR" |grep -v grep |wc -l`

if [ $st -ne 1 ]
 then
	 		echo "======================================================="
	 		echo "\033[35m BL1BTLSOR \033[0m \033[41m FAILED \033[0m to start, please check the reason"
	 		echo "======================================================="
 else
	 		echo "==============="
	 		echo "\033[35m BL1BTLSOR \033[32m UP \033[0m"
	 		echo "==============="	
fi

st=`ps -fu $USER | grep "bl1BTLServer -n BTLSOR_1" |grep -v grep |wc -l`

if [ $st -ne 1 ]
 then
                        echo "======================================================="
                        echo "\033[35m BL1BTLSOR1 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m BL1BTLSOR1 \033[32m UP \033[0m"
                        echo "==============="
fi

st=`ps -fu $USER | grep "bl1BTLServer -n BTLSOR_2" |grep -v grep |wc -l`

if [ $st -ne 1 ]
 then
                        echo "======================================================="
                        echo "\033[35m BL1BTLSOR2 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m BL1BTLSOR2 \033[32m UP \033[0m"
                        echo "==============="
fi


st=`ps -fu $USER | grep "bl1BTLServer -n BTLQUOTE" |grep -v grep |wc -l`

if [ $st -ne 1 ]
 then
	 		echo "======================================================="
	 		echo "\033[35m BTLQUOTE \033[0m \033[41m FAILED \033[0m to start, please check the reason"
	 		echo "======================================================="
 else
	 		echo "==============="
	 		echo "\033[35m BTLQUOTE \033[32m UP \033[0m"
	 		echo "==============="	
fi


st=`ps -fu $USER | grep "ES_FR424" |grep -v grep |grep -v log |wc -l`

if [ $st -eq 0 ]
 then
                        echo "======================================================="
                        echo "\033[35m ES_FR424 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m ES_FR424 \033[32m UP \033[0m"
                        echo "==============="
fi


st=`ps -fu $USER | grep "ES_RB589" |grep -v grep |grep -v log |wc -l`

if [ $st -eq 0 ]
 then
                        echo "======================================================="
                        echo "\033[35m ES_RB589 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m ES_RB589 \033[32m UP \033[0m"
                        echo "==============="
fi

st=`ps -fu $USER | grep "RRP_OG591" |grep -v grep |grep -v log |wc -l`

if [ $st -eq 0 ]
 then
                        echo "======================================================="
                        echo "\033[35m RRP_OG591 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m RRP_OG591 \033[32m UP \033[0m"
                        echo "==============="
fi
#st=`ps -fu $USER | grep "UHI_GD1023" |grep -v grep |grep -v log |wc -l`
st=`ps -fu $USER | grep "DuhProcInst=UHI_GD1023" |grep -v grep |wc -l`

if [ $st -eq 0 ]
 then
                        echo "======================================================="
                        echo "\033[35m UHI_GD1023 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m UHI_GD1023 \033[32m UP \033[0m"
                        echo "==============="
fi


#st=`ps -fu $USER | grep "UHI_RT1027" |grep -v grep |grep -v log |wc -l`
st=`ps -fu $USER | grep "DuhProcInst=UHI_RT1027" |grep -v grep |wc -l`

if [ $st -eq 0 ]
 then
                        echo "======================================================="
                        echo "\033[35m UHI_RT1027 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m UHI_RT1027 \033[32m UP \033[0m"
                        echo "==============="
fi


st=`ps -fu $USER | grep "F2E103" |grep -v grep |grep -v log |wc -l`

if [ $st -eq 0 ]
 then
                        echo "======================================================="
                        echo "\033[35m F2E103 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m F2E103 \033[32m UP \033[0m"
                        echo "==============="
fi



st=`ps -fu $USER | grep "DB2E411" |grep -v grep |grep -v log |wc -l`

if [ $st -eq 0 ]
 then
                        echo "======================================================="
                        echo "\033[35m DB2E411 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m DB2E411 \033[32m UP \033[0m"
                        echo "==============="
fi


if [ "${multiZoneSupportCurrentZone}" = "Z02" ]
 then
   st=`ps -fu $USER | grep "UQ_SERVER162" |grep -v grep |grep -v log |wc -l`
   
   if [ $st -eq 0 ]
    then
                           echo "======================================================="
                           echo "\033[35m UQ_SERVER162 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                           echo "======================================================="
    else
                           echo "==============="
                           echo "\033[35m UQ_SERVER162 \033[32m UP \033[0m"
                           echo "==============="
   fi
 else   
   st=`ps -fu $USER | grep "UQ_SERVER1307" |grep -v grep |grep -v log |wc -l`
   
   if [ $st -eq 0 ]
    then
                           echo "======================================================="
                           echo "\033[35m UQ_SERVER1307 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                           echo "======================================================="
    else
                           echo "==============="
                           echo "\033[35m UQ_SERVER1307 \033[32m UP \033[0m"
                           echo "==============="
   fi
fi  

st=`ps -fu $USER | grep "GAT2E489" |grep -v grep |grep -v log |wc -l`

if [ $st -eq 0 ]
 then
                        echo "======================================================="
                        echo "\033[35m GAT2E489 \033[0m \033[41m FAILED \033[0m to start, NOT iN SCOPE"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m GAT2E489 \033[32m UP \033[0m"
                        echo "==============="
fi


st=`ps -fu $USER | grep "DSP505" |grep -v grep |grep -v log |wc -l`

if [ $st -eq 0 ]
 then
                        echo "======================================================="
                        echo "\033[35m DSP505 \033[0m \033[41m FAILED \033[0m to start, please check the reason"
                        echo "======================================================="
 else
                        echo "==============="
                        echo "\033[35m DSP505 \033[32m UP \033[0m"
                        echo "==============="
fi

exit 0

