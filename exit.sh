#!/usr/bin/env bash

var1=10
var2=20
var3=25
var4=$((($var1 + $var2) / $var3))
echo "var4 is: $var4"
exit $var4 # 1, since bash command only supports integer operations
