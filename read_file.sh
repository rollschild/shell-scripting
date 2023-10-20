#!/usr/bin/env bash

count=1
cat "./README.md" | while read line; do
	echo "Line $count: $line"
	count=$(($count + 1))
done

echo " Finished processing the file."

exit
