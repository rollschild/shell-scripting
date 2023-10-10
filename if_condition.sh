#!/usr/bin/env bash

val1=10
val2=11

if [ $val2 -gt $val1 ]; then
	echo "$val2 is greater than $val1"
fi

str1=guangchu
str2="guangchu "

echo "$str1"
echo "$str2"

# Use `""` around the variable name to avoid situations where the value of the variable contains spaces, etc
if [ "$str2" = "$str1" ]; then
	echo "User $str2 is equal to user $str1"
else
	echo "User $str2 is NOT equal to user $str1"
fi
