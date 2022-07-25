#!/bin/bash
password=$(cat ./conf/pwd.txt)
ips=($(cat ./conf/host.csv | awk -F',' {'print $5'}))
names=($(cat ./conf/host.csv | awk -F',' {'print $11'}))

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
  	/usr/bin/sshpass -p ${password} ssh -o StrictHostKeyChecking=no root@${ip}  "~/bin/uninstall-aliyundun.sh"
  	echo ${index} ${ip}
  fi 
  ((index++))
done
