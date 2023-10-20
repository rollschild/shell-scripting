#!/usr/bin/env bash

read -n 1 -p "Continue [Y/N]? " answer

case "$answer" in
Y | y)
	echo
	echo "Carry on..."
	;;
N | n)
	echo
	echo "Bye!"
	exit
	;;
esac

echo "End of script."
exit
