#!/usr/bin/env bash

# add users in bulk, taking input from a file
# NOT READY to run

input="users.csv"
while IFS=',' read -r loginname name; do
	echo "adding $loginname"
	useradd -c "$name" -m "$loginname"
done <"$input"
