#!/usr/bin/env bash

while getopts :ab:cd opt; do
	echo "OPTIND: $OPTIND"
	echo "$@"
	case "$opt" in
	# the leading dash `-` is stripped off by `getopts`
	a) echo "Found -a" ;;
	b) echo "Found -b with parameter value $OPTARG" ;;
	c) echo "Found -c" ;;
	d) echo "Found -d" ;;
	# any unknown option is represented as ?
	*) echo "Unknown option: $opt" ;;
	esac
done
echo "OPTIND: $OPTIND"
shift $(($OPTIND - 1))

echo
count=1
echo "$@"
for param in "$@"; do
	echo "Parameter #$count: $param"
	count=$(($count + 1))
done

exit
