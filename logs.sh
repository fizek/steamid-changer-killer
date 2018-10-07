#!/bin/bash
for serw in dd2 ffa fun cod
do
  rcon -s ${serw} smac_status | grep -a STEAM > /sourcecs/logi/${serw}/${serw}-rcon-logtemp
  cat /sourcecs/logi/${serw}/${serw}-rcon-logtemp >> /sourcecs/logi/${serw}/${serw}-rcon-log-$(date +%Y-%m-%d-%H)
  cat /sourcecs/logi/${serw}/${serw}-rcon-logtemp > /var/www/html/${serw}.txt 
  date >> /var/www/html/${serw}.txt
done
bash /sourcecs/logi/dd2/blokady/blokada.sh
