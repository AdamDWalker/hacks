#!/bin/bash

secrets="secrets.txt"

while IFS= read -r line; do

	echo "" | tee -a  $secrets
	python3 ~/tools/SecretFinder/SecretFinder.py -i $line -o cli | tee -a $secrets

done < $1

