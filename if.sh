#!/usr/bin/env bash

# will echo `0` - no subshells in use
echo $BASH_SUBSHELL

# will echo `1`
if (echo $BASH_SUBSHELL); then
	echo "Subshell command exit normally"
else
	echo "Subshell command NOT successful"
fi

# `==` rhs is a pattern - pattern matching mode
if [[ $BASH_VERSION == 5.* ]]; then
	echo "You are using bash version 5.*"
else
	echo "You are using bash version older than v5"
fi
