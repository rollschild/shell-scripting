#!/usr/bin/env bash

if [ $# -ne 2 ]; then
	echo "Usage: $(basename $0) para_1 para_2"
else
	total=$(($1 + $2))
	echo "$1 + $2 = $total"
fi

echo "Btw the last parameter is ${!#}"
