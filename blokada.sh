#!/bin/bash
sciezka='/sourcecs/logi/dd2/blokady'
golombip='[[:space:]]46\.134\.'
krychaip='[[:space:]]83\.25\.'
innyip='[[:space:]]37\.47\.'
plik='/sourcecs/logi/dd2/dd2-rcon-logtemp'
plik2='/sourcecs/logi/dd2/blokady/dd2-rcon-logtemp2'

plikfun='/sourcecs/logi/fun/fun-rcon-logtemp'
plik2fun='/sourcecs/logi/dd2/blokady/fun-rcon-logtemp2'

#dd2
grep -a ${golombip} ${plik} > ${plik2}
grep -a ${krychaip} ${plik} >> ${plik2}
grep -a ${innyip} ${plik} >> ${plik2}
IFS=$'\n';for gracz in $(cat ${plik2})
do
	if grep -q $(echo ${gracz} | awk '{print $3}') ${sciezka}/trusted.txt
	then
		date >> ${sciezka}/graczok.txt
		echo ${gracz} >> ${sciezka}/graczok.txt
	else
		date >> ${sciezka}/podejrzany.txt
                echo ${gracz} >> ${sciezka}/podejrzany.txt
		#rcon -s dd2 "sm_silence #$(echo ${gracz} | awk '{print $2}') 1 podejrzany
		#rcon -s dd2 "sm_silence #$(echo ${gracz} | awk '{print $2}') 2 autosilence-by-fizek"
		rcon -s dd2 "sm_ban #$(echo ${gracz} | awk '{print $2}') 10 banned_by_console"
	fi
done
cat ${sciezka}/podejrzany.txt > /var/www/html/suspect.txt

#4fun
grep -a ${innyip} ${plikfun} >> ${plik2fun}
IFS=$'\n';for graczfun in $(cat ${plik2fun})
do
        if grep -q $(echo ${graczfun} | awk '{print $3}') ${sciezka}/trusted.txt
        then
                date >> ${sciezka}/graczokfun.txt
                echo ${gracz} >> ${sciezka}/graczokfun.txt
        else
                date >> ${sciezka}/podejrzanyfun.txt
                echo ${gracz} >> ${sciezka}/podejrzanyfun.txt
                #rcon -s dd2 "sm_silence #$(echo ${gracz} | awk '{print $2}') 1 podejrzany
                #rcon -s dd2 "sm_silence #$(echo ${gracz} | awk '{print $2}') 2 autosilence-by-fizek"
                rcon -s fun "sm_ban #$(echo ${gracz} | awk '{print $2}') 10 banned_by_console"
        fi
done
cat ${sciezka}/podejrzanyfun.txt > /var/www/html/suspectfun.txt
