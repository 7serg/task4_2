#!/bin/bash
pgrep ntpd > /dev/null 2>&1

if [ $? -eq 1 ]
then
systemctl start ntpd
fi



diff -u  /etc/ntp.conf /etc/ntp.conf.bak > /dev/null 2>&1

if [ $? -ne 0 ]
then
echo "NOTICE: /etc/ntp.conf was changed. Calculated diff:"
diff -u /etc/ntp.conf /etc/ntp.conf.bak
cp /etc/ntp.conf.bak /etc/ntp.conf
service ntp restart 
echo "ntp service has been restored"
fi 


