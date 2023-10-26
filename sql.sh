#!/usr/bin/env bash

outputfile="members.sql"
IFS=","

# the while loop
# reads data one line at a time,
# plug those data values into the `INSERT` statement template,
# then outputs the result into the output file
while read last_name first_name address city state zip; do
	# >> output append redirection - append the `cat` output to $outputfile
	# << input append redirection - redirected from stdin to use the data inside
	# _this_ script!
	# EOF - the start and end delimiter of the data that's appended to $outputfile
	cat >>"$outputfile" <<EOF
	INSERT INTO members (last_name,first_name,address,city,state,zip) VALUES ('$last_name', '$first_name', '$address', '$city', '$state', '$zip');
EOF
	# ^ NOTICE the position of EOF
done <${1}
