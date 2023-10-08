#!/usr/bin/env bash

var1=10
var2=20
var3=$(expr $var2 / $var1)
echo "Result is $var3"
