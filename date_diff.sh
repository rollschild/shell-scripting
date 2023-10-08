#!/usr/bin/env bash

date1="Dec 18, 2018"
date2=$(date +"%b %d, %Y")
time1=$(date -d "$date1" +%s)
time2=$(date -d "$date2" +%s)

diff=$(($time2 - $time1))
diff_in_day=$(($diff / (60 * 60 * 24)))
echo "Different between $date2 and $date1 is $diff_in_day days!"
