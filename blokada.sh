#!/bin/bash
sciezka='/sourcecs/logi/dd2/blokady'
golombip='[[:space:]]46\.134\.'
krychaip='[[:space:]]83\.25\.'
innyip='[[:space:]]37\.47\.'
nerxuip='[[:space:]]188\.112\.'
plik='/sourcecs/logi/dd2/dd2-rcon-logtemp'
plik2='/sourcecs/logi/dd2/blokady/dd2-rcon-logtemp2'
plikfun='/sourcecs/logi/fun/fun-rcon-logtemp'
plik2fun='/sourcecs/logi/dd2/blokady/fun-rcon-logtemp2'
plikffa='/sourcecs/logi/ffa/ffa-rcon-logtemp'
plik2ffa='/sourcecs/logi/dd2/blokady/ffa-rcon-logtemp2'
plikcod='/sourcecs/logi/cod/cod-rcon-logtemp'
plik2cod='/sourcecs/logi/dd2/blokady/cod-rcon-logtemp2'


#dd2
grep -a ${golombip} ${plik} > ${plik2}
grep -a ${krychaip} ${plik} >> ${plik2}
grep -a ${innyip} ${plik} >> ${plik2}
grep -a ${nerxuip} ${plik} >> ${plik2}
IFS=$'\n';for gracz in $(cat ${plik2})
do
	if grep -q $(echo ${gracz} | awk '{print $3}') ${sciezka}/trusted.txt
	then
		date >> ${sciezka}/graczok.txt
		echo ${gracz} >> ${sciezka}/graczok.txt
	else
		date >> ${sciezka}/podejrzany.txt
                echo ${gracz} >> ${sciezka}/podejrzany.txt
		rcon -s dd2 "sm_ban #$(echo ${gracz} | awk '{print $2}') 10 banned_by_console"
	fi
done
cat ${sciezka}/podejrzany.txt > /var/www/html/suspect.txt

#4fun
grep -a ${innyip} ${plikfun} > ${plik2fun}
grep -a ${nerxuip} ${plikfun} >> ${plik2fun}
IFS=$'\n';for graczfun in $(cat ${plik2fun})
do
        if grep -q $(echo ${graczfun} | awk '{print $3}') ${sciezka}/trusted.txt
        then
                date >> ${sciezka}/graczokfun.txt
                echo ${graczfun} >> ${sciezka}/graczokfun.txt
        else
                date >> ${sciezka}/podejrzanyfun.txt
                echo ${graczfun} >> ${sciezka}/podejrzanyfun.txt
                rcon -s fun "sm_ban #$(echo ${graczfun} | awk '{print $2}') 10 banned_by_console"
        fi
done
cat ${sciezka}/podejrzanyfun.txt > /var/www/html/suspectfun.txt

#ffa
grep -a ${nerxuip} ${plikffa} > ${plik2ffa}
IFS=$'\n';for graczffa in $(cat ${plik2ffa})
do
        if grep -q $(echo ${graczffa} | awk '{print $3}') ${sciezka}/trusted.txt
        then
                date >> ${sciezka}/graczokffa.txt
                echo ${graczffa} >> ${sciezka}/graczokffa.txt
        else
                date >> ${sciezka}/podejrzanyffa.txt
                echo ${graczffa} >> ${sciezka}/podejrzanyffa.txt
                rcon -s ffa "sm_ban #$(echo ${graczffa} | awk '{print $2}') 10 banned_by_console"
        fi
done
cat ${sciezka}/podejrzanyffa.txt > /var/www/html/suspectffa.txt

#cod
grep -a ${nerxuip} ${plikcod} > ${plik2cod}
IFS=$'\n';for graczcod in $(cat ${plik2cod})
do
        if grep -q $(echo ${graczcod} | awk '{print $3}') ${sciezka}/trusted.txt
        then
                date >> ${sciezka}/graczokcod.txt
                echo ${graczcod} >> ${sciezka}/graczokcod.txt
        else
                date >> ${sciezka}/podejrzanycod.txt
                echo ${graczcod} >> ${sciezka}/podejrzanycod.txt
                rcon -s cod "sm_ban #$(echo ${graczcod} | awk '{print $2}') 10 banned_by_console"
        fi
done
cat ${sciezka}/podejrzanycod.txt > /var/www/html/suspectcod.txt
