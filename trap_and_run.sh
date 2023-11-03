#!/usr/bin/env bash
# Set specified signal traps; then run script in background
#
### Check signals to trap

while getopts S: opt; do
	case "$opt" in
	S) # Found the -S option
		signalList=""
		for arg in $OPTARG; do
			case $arg in
			1) #SIGHUP handled
				signalList=$signalList"SIGHUP"
				;;
			2) #SIGINT
				signalList=$signalList"SIGINT"
				;;
			20) #SIGTSTP
				signalList=$signalList"SIGTSTP"
				;;
			*) #UNKNOWN!
				echo "Only signals 1 2 and/or 20 are allowed!"
				echo "Exiting..."
				exit
				;;
			esac
		done
		;;
	*)
		echo "Usage: -S '<signals>' <script_to_run>"
		echo "Exiting..."
		exit
		;;
	esac
done

### Check script to run

shift $(($OPTIND - 1)) # put <script_to_run> in the parameter
if [ -z $@ ]; then
	# empty string
	echo
	echo "Error: script not provided"
	echo "Exiting..."
	exit
elif [ -O $@ ] && [ -x $@ ]; then
	# file exists and owned by the effective user ID
	# executable
	script_to_run=$@
	script_output="$@.output"
else
	echo
	echo "ERROR: $@ is either not owned by you or not executable!"
	echo "Exiting..."
	exit
fi

### Trap and run
#
echo
echo "Running the $script_to_run in the background..."
echo "while trapping signal(s): $signalList"
echo "Output sent to: $script_output"
echo
trap "" $signalList                   # ignore these signals
source $script_to_run >$script_output # run script in background
trap -- $signalList                   # return to default behavior
