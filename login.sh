#!/bin/bash
#password=$(cat ./conf/pwd.txt)
ips=($(cat ./conf/host.csv | awk -F',' {'print $5'}))
pwds=($(cat ./conf/host.csv | awk -F',' {'print $10'}))

echo $1
echo ${ips[$1]}
#sshpass -p ${password} ssh -o StrictHostKeyChecking=no root@${ips[$1]}
sshpass -p ${pwds[$1]} ssh -o StrictHostKeyChecking=no root@${ips[$1]}
