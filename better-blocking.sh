#!/bin/bash
scriptpath="/smac"
webpath="/var/www/ooxx.eu/html/smac"
currenttime=$(date +%Y-%m-%dg%H-%M)
currentepoch=$(date +%s)
serw="dd2"

check()
{
	rcon -s ${serw} smac_status | grep STEAM | sort -r > ${scriptpath}/blokada-${serw}-${currentepoch}.txt
	IFS=$'\n';cat ${scriptpath}/blokada-${serw}-${currentepoch}.txt | while read player
	do
		steamid="$(echo ${player} | awk '{print $3}')"
		ip="$(echo ${player} | awk '{print $4}')"
		if grep -q ${steamid} ${scriptpath}/army-after-all.txt;then
			echo "$(date -d@${currentepoch}) ${player}" >> ${scriptpath}/blokada-${serw}-accepted.txt
		elif grep -q ${steamid} ${scriptpath}/blokada-${serw}-second.txt;then
			echo "$(date -d@${currentepoch}) ${player}" >> ${scriptpath}/blokada-${serw}-accepted.txt
		else
			echo "${steamid} ${ip}" >> ${scriptpath}/blokada-${serw}-second.txt
			rcon -s ${serw} "sm_ban #$(echo ${player} | awk '{print $2}') 25 banned_by_console"
		fi
	done
	echo "$(date -d@${currentepoch})" >> ${scriptpath}/blokada-${serw}-archive.txt
	cat ${scriptpath}/blokada-${serw}-${currentepoch}.txt >> ${scriptpath}/blokada-${serw}-archive.txt
	rm -f ${scriptpath}/blokada-${serw}-${currentepoch}.txt
}
for i in {1..5}
do
	sleep 11
	check
done
exit 0;
