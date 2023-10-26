#!/usr/bin/env bash

exec 3>&1

# by default STDERR has same output as STDOUT
# to redirect, run like this: `./redirect.sh 2> error.txt`
echo "This is an ERROR" >&2
echo "This is normal text..."

exec 1>testout
echo "Testing output..."

exec 0<testinput
count=1
# the following will appear in `testoutput`
echo "Reading input..."

while read line; do
	echo "Line #$count: $line"
	count=$(($count + 1))
done

exec 1>&3 # redirect STDOUT back to monitor (default)
echo "Now we should see this on the monitor..."
