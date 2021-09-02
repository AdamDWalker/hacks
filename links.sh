#!/bin/bash

links="links.txt"

while IFS= read -r line; do

	echo "" | tee -a  $secrets
	echo "----- $line -----" | tee -a $secrets
	python3 ~/tools/LinkFinder/linkfinder.py -i $line -o cli | tee -a $links

done < $1
