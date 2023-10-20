#!/usr/bin/env bash

echo "Running script $(basename $0)..."
echo "Number of CLI parameters: $#"

if [ -n "$1" ]; then
	factorial=1
	for ((number = 1; number <= $1; number++)); do
		factorial=$(($factorial * $number))
	done

	echo "Factorial of $1 is $factorial"
else
	echo "Error: no parameter provided!"
fi
