#!/usr/bin/env bash

exec 3>testoutputfile
echo "Testing output redirection..."
exec 3>&-

cat testoutputfile

exec 3>testoutputfile
echo "This will overwrite the original testoutputfile"
cat testoutputfile
