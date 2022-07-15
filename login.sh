#!/bin/bash
password=$(cat ./conf/pwd.txt)
ips=($(cat ./conf/host.csv | awk -F',' {'print $5'}))

echo $1
echo ${ips[$1]}
sshpass -p ${password} ssh -o StrictHostKeyChecking=no root@${ips[$1]}
