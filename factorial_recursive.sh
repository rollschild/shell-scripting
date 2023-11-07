#!/usr/bin/env bash

factorial() {
	if [ $1 -eq 1 ]; then
		echo 1
	else
		local temp=$(($1 - 1))
		local result=$(factorial $temp)
		echo $(($result * $1))
	fi
}

read -p "Enter a value: " value
result=$(factorial $value)
echo "Factorial of $value is $result"
