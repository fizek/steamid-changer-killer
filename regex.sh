#!/bin/bash
for serw in ffa fun cod
do 
    for data in $(ls)
    do 
        echo -e "\n############\n${data}\n############\n" >> ${serw}-by-ip.txt
        grep STATUS\:ACCEPTED ${data} | grep -oE "STEAM\_.*\.[0-9]+" | sed "s/><IP//g" | awk '{print $2"\t"$1}' | sort -n | uniq >> ${serw}-by-ip.txt
    done
done

for serw in ffa fun cod
do 
    grep STEAM ${serw}/${serw}-by-ip.txt | sort | uniq > ${serw}sortuniq.txt
done

for serw in ffa fun cod
do 
    cat ${serw}sortuniq.txt | awk '{print $1}' | sort -n | uniq > ${serw}-onlyip.txt
done

for serw in ffa fun cod
do 
    cat ${serw}-onlyip.txt | while read player
    do 
        echo "$(grep -c ${player} ${serw}sortuniq.txt) ${player}" >> ${serw}-counter.txt
    done
done

for serw in ffa fun cod
do 
    cat ${serw}-counter.txt | sort -nr > ${serw}-counter-sort.txt
done

cat army-aftersimon-sort.txt | grep -vE "(12345|23456|34567|45678|56789|98765|87654|76543|65432|54321)" > army-aftersimon-sort-2.txt

cat army-aftersimon-sort-2.txt | uniq > army-aftersimon-sort-2-uniq.txt

cat army-aftersimon-sort-2-uniq.txt | while read id
do 
    idx=$(grep -A1 -E "^${id}$" army-aftersimon-sort-2-uniq.txt | tail -n 1)
    let odj=$idx-$id
    if [ $odj -le 5 ];then
        echo $id | tee incorrect-ids.txt
    fi
done

cat army-aftersimon-sort-2-uniq.txt | while read id
do 
    if grep -q -E "^${id}$" incorrect-ids.txt;then 
        echo found >> found1217
    else echo "STEAM_1:0:${id}" >> army-after-all.txt
    fi
done

cat colonone | while read colo
do 
    colox=$(echo ${colo} | awk -F\: '{print $3}')
    if grep -q -E "${colox}$" army-after-all.txt;then 
        sed -i "s/STEAM\_1\:0\:${colox}/STEAM\_1\:1\:${colox}/g" army-after-all.txt
    fi
done
