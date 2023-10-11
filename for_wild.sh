#!/usr/bin/env bash

for file in "$PWD"/* "$PWD/bin"; do
	if [ -d "$file" ]; then
		echo "$file is a directory"
	elif [ -f "$file" ]; then
		echo "$file is a file"
	else
		echo "$file is unknown"
	fi
done
