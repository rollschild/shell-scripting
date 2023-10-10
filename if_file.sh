#!/usr/bin/env bash

location=$PWD
file_name="log.231008"

if [ -d $location ]; then
	echo"Location $location exists!"
	echo "Checking file..."
	if [ -e "$location/$file_name" ]; then
		echo "File $file_name exists..."
		echo "Updating file..."
		date >>"$location/$file_name"
	else
		echo "File $location/$file_name does NOT exist!"

	fi
else
	echo "Directory $location does NOT exist!"
fi

echo "Checking executability of a file..."
item_name="$PWD/date_diff.sh"
if [ -x "$item_name" ]; then
	echo "You can run $item_name"
	$item_name
else
	echo "Sorry, $item_name is NOT executable!"
fi
