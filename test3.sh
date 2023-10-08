#!/usr/bin/env bash

testing=$(date)
echo "Date and time are: $testing"

# display the date as a 2-digit year,month,day
today=$(date +%y%m%d)
ls /usr/bin/ -al >log."$today"
