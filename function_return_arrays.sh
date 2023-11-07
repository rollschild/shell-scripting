#!/usr/bin/env bash

function return_array {
	local old_array
	local new_array
	local num_ele
	local i
	# reassembles elements into an array
	# use () to group individual elements back to array
	old_array=($(echo "$@"))
	new_array=($(echo "$@"))
	num_ele=$(($# - 1))
	for ((i = 0; i <= $num_ele; i++)); do
		new_array[$i]=$((${old_array[$i]} * 2))
	done

	# output _individual_ elements
	echo "${new_array[*]}"
}

array=(1 3 5 7 9 11 13)
echo "Original array: ${array[*]}"
arg=$(echo ${array[*]})
result=($(return_array $arg)) # reassemble
echo "New array: ${result[*]}"
