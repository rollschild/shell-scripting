#!/usr/bin/env bash

# Extract command-line options and values with getopt
#

set -- $(getopt -q ab:cd "$@")

echo

while [ -n "$1" ]; do
	case "$1" in
	-a) echo "Found -a" ;;
	-b)
		param=$2
		echo "Found -b with value $param"
		shift
		;;
	-c) echo "Found -c" ;;
	--)
		shift
		break
		;;
	*) echo "$1 is NOT a valid option!" ;;
	esac
	shift
done

echo
count=1
for param in "$@"; do
	echo "Parameter #$count: $param"
	count=$(($count + 1))
done
exit
