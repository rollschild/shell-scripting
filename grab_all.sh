#!/usr/bin/env bash

# Exploring different methods for grabbing all parameters

echo "Using the \$* method: $*"
count=1
for param in "$*"; do
	echo "\$* Parameter #$count = $param"
	count=$(($count + 1))
done

echo "Using the \$@ method: $@"
count=1
for param in "$@"; do
	echo "\$@ Parameter #$count = $param"
	count=$(($count + 1))
done
