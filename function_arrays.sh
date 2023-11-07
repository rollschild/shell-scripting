#!/usr/bin/env bash

function test_func {
	local new_array
	new_array=$(echo "$@")
	echo "The new array value is: ${new_array[*]}"
}
add_array() {
	local sum=0
	local new_array
	new_array=$(echo "$@")
	for value in ${new_array[*]}; do
		sum=$(($sum + $value))
	done
	echo "$sum"
}

array=(1 2 3 4 5)
echo "The original array is: ${array[*]}"
test_func ${array[*]}

arg1=$(echo ${array[*]})
result=$(add_array $arg1)
echo "The result is $result"
