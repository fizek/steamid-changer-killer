#!/bin/bash
scriptpath='/sourcecs/logi/dd2/blokady'
#golombip='[[:space:]]46\.134\.'
#krychaip='[[:space:]]83\.25\.'
#innyip='[[:space:]]37\.47\.'
#nerxuip='[[:space:]]188\.112\.'

function check_player() {
        banip=("$@")
        if [ -f ${2} ];then
                rm -f ${2}
        fi

        for entry in "${banip[@]}";do
                grep -a ${entry} ${1} >> ${2}
        done

        IFS=$'\n';for player in $(cat ${2});
        do
                if grep -q $(echo ${player} | awk '{print $3}') ${scriptpath}/trusted.txt;then
                        date >> ${scriptpath}/playerok.txt
                        echo ${player} >> ${scriptpath}/playerok.txt
                else
                        date >> ${scriptpath}/suspect.txt
                        echo ${player} >> ${scriptpath}/suspect${4}.txt
                        rcon -s ${4} "sm_ban #$(echo ${player} | awk '{print $2}') 10 banned_by_console"
                fi
        done
        cp ${scriptpath}/suspect${4}.txt /var/www/html/
}
for serw in ffa dd2 cod fun
do
        if [ ${serw} = 'ffa' ] 2>/dev/null;then
                logfile='/sourcecs/logi/ffa/ffa-rcon-logtemp'
                logfile2='/sourcecs/logi/dd2/blokady/ffa-rcon-logtemp2'
                banip=('[[:space:]]188\.112\.')
                check_player "${logfile}" "${logfile2}" "${banip[@]}" "${serw}"
        elif [ ${serw} = 'dd2' ] 2>/dev/null;then
                logfile='/sourcecs/logi/dd2/dd2-rcon-logtemp'
                logfile2='/sourcecs/logi/dd2/blokady/dd2-rcon-logtemp2'
                banip=('[[:space:]]46\.134\.' '[[:space:]]83\.25\.' '[[:space:]]37\.47\.' '[[:space:]]188\.112\.')
                check_player "${logfile}" "${logfile2}" "${banip[@]}" "${serw}"
        elif [ ${serw} = 'cod' ] 2>/dev/null;then
                logfile='/sourcecs/logi/cod/cod-rcon-logtemp'
                logfile2='/sourcecs/logi/dd2/blokady/cod-rcon-logtemp2'
                banip=('[[:space:]]188\.112\.')
                check_player "${logfile}" "${logfile2}" "${banip[@]}" "${serw}"
        else [ ${serw} = 'fun' ] 2>/dev/null;then
                logfile='/sourcecs/logi/fun/fun-rcon-logtemp'
                logfile2='/sourcecs/logi/dd2/blokady/fun-rcon-logtemp2'
                banip=('[[:space:]]37\.47\.' '[[:space:]]188\.112\.')
                check_player "${logfile}" "${logfile2}" "${banip[@]}" "${serw}"
        fi
done
