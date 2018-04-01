#!/bin/bash

cronvar=/var/spool/cron/crontabs/root


if [ ! -e /etc/ntp.conf ]
then
apt-get -y install ntp
else
echo "The server has been already installed"
fi 
sed -i '/^pool/d' /etc/ntp.conf
sed -i -e '/^# more information/a pool ua.pool.ntp.org iburst' /etc/ntp.conf
cp /etc/ntp.conf /etc/ntp.conf.bak
service ntp restart



if ! grep -q "ntp_verify" ${cronvar} &>/dev/null
then
[[ -f ${cronvar} ]] && chmod 600 ${cronvar}; echo "* * * * * $(dirname $(readlink -f $0))/ntp_verify.sh" >> ${cronvar} || echo "* * * * * $(dirname $(readlink -f $0))/ntp_verify.sh" > ${cronvar}
fi

# sudo sed -i -e '/^pool/{i\ua.pool.ntp.org' -e ':a;$q;n;ba;}' /etc/ntp.conf
# sudo sed -i '/^pool [[:digit:]]/d' /etc/ntp.conf
