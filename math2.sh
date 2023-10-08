#!/usr/bin/env bash

var1=$((10))
var2=$((2 + 9))
var3=$(($var1 * $var2))
echo "Result is $var3"

var4=$(($var3 * ($var1 - $var2)))
echo "Next esult is $var4"
