#!/usr/bin/env bash

trap "echo 'Ctrl+C is trapped!'" SIGINT
trap "echo 'Bye...'" EXIT
echo "This is a test script..."

count=1
while [ $count -le 6 ]; do
	echo "Looping #$count..."
	sleep 1
	count=$(($count + 1))
done

trap "echo 'Now I'\''m different!'" SIGINT
count=1
while [ $count -le 6 ]; do
	echo "Second loop #$count..."
	sleep 1
	count=$(($count + 1))
done

trap -- SIGINT
count=1
while [ $count -le 6 ]; do
	echo "Third loop #$count..."
	sleep 1
	count=$(($count + 1))
done

echo "End of script!"
exit
