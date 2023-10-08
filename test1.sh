#!/usr/bin/env bash

# to be able to run this script, do `chomd u+x <script-name>`
#   `-u`: grant _only_ the owner of this file the execution permission
echo "this is guangchu's script..."

# `-n`: echo text string on the _same_ line as the next command
echo -n "Current date is: "

date
who
