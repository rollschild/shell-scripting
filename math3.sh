#!/usr/bin/env bash

var1=$(echo " scale=4; 3.44 / 5" | bc)
echo "Answer: $var1"

var2=55
var3=-2
var4=$(echo " scale=4; $var2 * $var3 / $var1" | bc)
echo "Answer: $var4"

# notice the indentation!
# not allowed to arbitrarily indent
var5=$(
	bc <<EOF
scale=4
a1=($var2 * $var3)
b1=($var4 * $var1)
a1 + b1
EOF
)
echo "Answer: $var5"
