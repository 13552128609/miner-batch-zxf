#!/bin/bash
password=$(cat ./conf/pwd.txt)
ips=($(cat ./conf/host.csv | awk -F',' {'print $5'}))
validBeginIndex=0
validEndIndex=${#ips[*]}
userName=root

if [ -n "$1" ]
then
        validBeginIndex=$1
fi

if [ -n "$2" ]
then
        validEndIndex=$2
fi


index=0
for ip in ${ips[*]}
do 
 if [ ${index} -eq 0 ]
  then
	((index++))
	continue
  fi

  if [ ${index} -ge ${validBeginIndex} -a ${index} -le ${validEndIndex} ]
  then
  	/usr/bin/sshpass -p ${password} ssh -o StrictHostKeyChecking=no root@${ip}  "sudo pkill -9 test.sh"  	
  	/usr/bin/sshpass -p ${password} ssh -o StrictHostKeyChecking=no root@${ip}  "sudo pkill -9 test1"  	
  	/usr/bin/sshpass -p ${password} ssh -o StrictHostKeyChecking=no root@${ip}  "sudo ps -ef | grep 8007 |grep -v grep | awk '{print $2}' | xargs sudo kill "
  	echo ${index} ${ip}
  fi 
  ((index++))
done
