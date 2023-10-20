#!/usr/bin/env bash

if read -t 5 -p "Enter your name: " name; then
	echo "Hello, $name"
else
	echo
	echo "Sorry, no longer waiting for your name!"
fi
