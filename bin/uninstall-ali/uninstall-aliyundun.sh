#!/bin/bash
cd ~/bin/uninstall-ali
. ./uninstall.sh
. ./quartz_uninstall.sh

pkill aliyun-service
rm -fr /etc/init.d/agentwatch /usr/sbin/aliyun-service
rm -rf /usr/local/aegis*

pkill -9 AliYunDun
pkill -9 AliYunDunUpdate

cd -
