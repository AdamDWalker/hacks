#!/bin/bash

output=grepper.txt

while IFS= read -r line; do
	
	echo "Searching for: $line"
	echo "" >> $output
	echo "----- $line -----" >> $output
	echo "" >> $output
	git grep -i $line $(git rev-list --all) >> $output

done < $1
