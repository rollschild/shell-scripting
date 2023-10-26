#!/usr/bin/env bash

tempdir=$(mktemp -d dir.XXXXXX)
cd "$tempdir"

tempfile=$(mktemp test.XXXXXX)
exec 3>"$tempfile"

echo "Sending data to temp directory $tempdir"
echo "This script writes to temp file $tempfile"
echo "This is the first line..." >&3
echo "this is the second line!" >&3
echo "This, is the third line..!" >&3

exec 3>&- # close this file descriptor

echo "Finished creating temp file. The contents are:"
cat "$tempfile"
rm -f "$tempfile" 2>/dev/null
