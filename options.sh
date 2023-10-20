#!/usr/bin/env bash

while [ -n "$1" ]; do
	case "$1" in
	-a) echo "Found option -a" ;;
	-b)
		param=$2
		echo "Found option -b with value $param"
		shift
		;;
	-c) echo "Found option -c" ;;
	--)
		shift
		break
		;;
	*) echo "$1 is NOT an option!" ;;
	esac
	shift
done

count=1
for param in "$@"; do
	echo "Parameter #$count: $param"
	count=$(($count + 1))
done

echo
