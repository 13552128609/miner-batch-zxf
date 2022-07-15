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
  	echo ${index} ${ip}
  	/usr/bin/sshpass -p ${password} ssh -o StrictHostKeyChecking=no root@${ip}  "sudo rm -rf ~/bin/*"
  	/usr/bin/sshpass -p ${password} scp -o StrictHostKeyChecking=no ./bin/test.tgz root@${ip}:~/bin/test.tgz
  	/usr/bin/sshpass -p ${password} ssh -o StrictHostKeyChecking=no root@${ip} "tar xvf ~/bin/test.tgz -C ~/bin/"
  fi 
  ((index++))
done
