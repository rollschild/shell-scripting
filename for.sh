#!/usr/bin/env bash

IFS_OLD=$IFS
for test in "Hello," my name is Guangchu. This is "Guangchu's" space; do
	echo "$test"
done

list=(Kansas Missouri Georgia)
list+=("New York")

for i in "${list[@]}"; do
	echo "I've lived in ${i}"
done

file="states.txt"

# only read words, _NOT_ lines
# to read lines, use `while read`
# look at special env variable $IFS
for state in $(cat $file); do
	echo "I've lived in: $state"
done

# setting IFS
IFS=$'\n'
for state in $(cat $file); do
	echo "I've lived in: $state"
done
IFS=$IFS_OLD
echo "$IFS"
# for state in $list; do
# 	echo "I've been lived in $state."
# done
