#!/usr/bin/env bash

count=1
while [ $count -le 6 ]; do
	echo "Loop #$count"
	sleep 1
	count=$(($count + 1))
done

exit
