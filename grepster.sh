#!/bin/bash

output=grepster.txt

while IFS= read line; do

	echo "Searching for: $line"
	echo "" >> $output
	echo "---- $line ----" >> $output
	echo "" >> $output
	grep -i $line $2 >> $output

done < $1
