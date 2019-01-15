#!/bin/bash
#i put this script to cron – it starts every minute
logpath='/sourcecs/logi'
# my four servers mentioned below are defined in ~/.rconrc
for serw in dd2 ffa fun cod
do
  rcon -s ${serw} smac_status | grep -a STEAM > ${logpath}/${serw}/${serw}-rcon-logtemp
  cat ${logpath}/${serw}/${serw}-rcon-logtemp >> ${logpath}/${serw}/${serw}-rcon-log-$(date +%Y-%m-%d-%H)
  cat ${logpath}/${serw}/${serw}-rcon-logtemp > /var/www/html/${serw}.txt 
  date >> /var/www/html/${serw}.txt
done
# below is call for blocking script
bash ${logpath}/scripts/blokada.sh
