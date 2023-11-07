#!/usr/bin/env bash

func() {
	read -p "Enter a value: " value
	echo $(($value * 2 + 1))
}
result=$(func)
echo "Result of function $0 is $result"
