#!/bin/bash
if [ ! -d /root/report ];then
    mkdir /root/report
fi
cd /root/report
if [ -f /root/report/report ];then
    rm /root/report/report
fi
wget https://raw.githubusercontent.com/oceanworldclient/AwsToolScript/main/report
chmod +x /root/report/report
if [ ! -f /root/report/report.lock ];then
    touch /root/report/report.lock
fi

if [ -f /var/spool/cron/crontabs/root ];then
    v=$(cat /var/spool/cron/crontabs/root)
    if [[ "$v" == *"report.lock"* ]];then
        v=""
    else
        echo "0 */1 * * * flock -xn   /root/report/report.lock   -c '/root/report/report -api {API} -web {WEB} -ip {IP} >> /dev/null 2>&1'" >> /var/spool/cron/crontabs/root
    fi
elif [ -f /var/spool/cron/root ];then
    v=$(cat /var/spool/cron/crontabs/root)
    if [[ "$v" == *"report.lock"* ]];then
        v=""
    else
        echo "0 */1 * * * flock -xn   /root/report/report.lock   -c '/root/report/report -api {API} -web {WEB} -ip {IP} >> /dev/null 2>&1'" >> /var/spool/cron/root
    fi   
else
    echo "No"
fi

systemctl restart cron
