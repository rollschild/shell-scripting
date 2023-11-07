#!/usr/bin/env bash

function func {
	echo $(($1 * $2))
}

if [ $# -eq 2 ]; then
	# you need to specifically pass command line parameters to the function
	value=$(func $1 $2)
	echo "Result is $value"
else
	echo "Bad usage: func a b"
fi
