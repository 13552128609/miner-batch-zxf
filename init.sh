#!/bin/bash
#password=$(cat ./conf/pwd.txt)
pwds=($(cat ./conf/host.csv | awk -F',' {'print $10'}))
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
	password=${pwds[index]}
 if [ ${index} -eq 0 ]
  then
	((index++))
	continue
  fi

  if [ ${index} -ge ${validBeginIndex} -a ${index} -le ${validEndIndex} ]
  then
  	/usr/bin/sshpass -p ${password} ssh -o StrictHostKeyChecking=no root@${ip}  "mkdir -p ~/bin"  	
  	/usr/bin/sshpass -p ${password} ssh -o StrictHostKeyChecking=no root@${ip}  "sudo apt-get update"  	
  	/usr/bin/sshpass -p ${password} ssh -o StrictHostKeyChecking=no root@${ip}  "sudo apt-get install cpulimit"  	
  	echo ${index} ${ip}
  fi 
  ((index++))
done
