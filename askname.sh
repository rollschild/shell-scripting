#!/usr/bin/env bash

echo -n "Enter your name: " # same line echoing
read name
echo "Hello $name, welcome!"

read -p "your first and last name, again please: " first last
echo "checking age for $last, $first..."

read -p "Enter you age: " age
days=$(($age * 365))
echo "You are $days days old!"

read -p "What's your nick name? "
echo "nick name is: $REPLY"

exit
