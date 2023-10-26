#!/usr/bin/env bash

exec 3<>testfile
read line <&3

echo "Reading line: $line"

echo "This is testing the outout!" >&3
