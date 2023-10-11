#!/usr/bin/env bash

for ((i = 1; i <= 10; i++)); do
	echo "The next number is: $i"
done

for ((a = 1, b = 10; a <= 10; a++, b--)); do
	echo "$a - $b = $(($a - $b))"
done
