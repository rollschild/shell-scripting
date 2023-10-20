#!/usr/bin/env bash

# Check (ping) systems

### Determine Input Method

while getopts t: opt; do
	case "$opt" in
	t) # Found the `-t` option
		if [ $OPTARG = "IPv4" ]; then
			ping_command=$(which ping)
		elif [ $OPTARG = "IPv6" ]; then
			ping_command="$(which ping) -6"
		else
			echo "Usage: -t IPv4 or -t IPv6"
			echo " Exiting script..."
			exit
		fi
		;;
	*)
		echo "Usage: -t IPv4 or -t IPv6"
		echo " Exiting script..."
		exit
		;;
	esac

	shift $(($OPTIND - 1))

	if [ $# -eq 0 ]; then
		echo "IP address(es) parameters are missing!"
		echo
		echo "Exiting script..."
		exit
	fi

	for ip in "$@"; do
		echo
		echo "Pinging $ip..."
		echo
		$ping_command -q -c 3 $ip # stop after -c ECHO_REQUEST packets
		echo
	done
	exit
done

### File Input Method

echo
echo "Enter file name: "
echo
choice=0
while [ $choice -eq 0 ]; do
	read -t 60 -p "Enter name of file: " filename
	# if $filename variable is empty string
	if [ -z $filename ]; then
		quitanswer=""
		read -t 10 -n 1 -p "Quit script [Y/n]? " quitanswer
		case $quitanswer in
		Y | y)
			echo
			echo "Quitting script..."
			exit
			;;
		N | n)
			echo
			echo "Please answer question: "
			choice=0
			;;
		*)
			echo
			echo "No response. Quitting script..."
			;;
		esac
	else
		choice=1
	fi
done

# file exsits and none zero; file readable
if [ -s $filename ] && [ -r $filename ]; then
	echo "$filename is a file, is readable, and not empty."
	echo
	cat $filename | while read line; do
		ip=$line
		read line
		ip_type=$line
		if [ $ip_type = "IPv4" ]; then
			ping_command=$(which ping)
		else
			ping_command="$(which ping) -6"
		fi
		echo "Pinging $ip..."
		$ping_command -q -c 3 $ip # stop after -c ECHO_REQUEST packets
		echo
	done
	echo "Finished processing file $filename; all systems pinged."
else
	echo
	echo "$filename is either not a file, is empty, or is not readable by you. Exiting..."
fi

exit
