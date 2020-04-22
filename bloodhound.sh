#!/bin/bash

# Bloodhound
# Simple script to sniff through JS files and find interesting things. For now it will probably just be really basic


#
# TODO: Make the target list into an external wordlist and implement argument parsing 
#

targets=("token" "key" "api" "amazonaws" "username" "password" "pass" "credential" "secret" "todo" "vulnerable" "random" "hmac" "md5" "sha-1" "sha-2" "hash" "csrf" "hostname" "auth")
inputfile=input.js

while read LINE; do

	echo "==============="
	echo ${LINE}    # do something with it here

	echo ""
	echo "Downloading JS file..."
	echo ""

	wget ${LINE} -O $inputfile

	echo ""         
	echo "Beautifying JS file..."
	echo ""

	js-beautify $inputfile >> target.js
	
	echo ""
	echo "Beginning scan..."
	echo ""

	for i in "${targets[@]}"
	do
		grep -in $i target.js --color
	done

	echo ""
	echo "Scan complete."
	echo ""
done
