#!/bin/bash

# Bloodhound
# Simple script to sniff through JS files and find interesting things. For now it will probably just be really basic


#
# TODO: Make the target list into an external wordlist and implement argument parsing
#


logo(){
echo $'\e[1;31m'"
 ____  _                 _ _                           _
| __ )| | ___   ___   __| | |__   ___  _   _ _ __   __| |
|  _ \| |/ _ \ / _ \ / _' | '_ \ / _ \| | | | '_ \ / _' |
| |_) | | (_) | (_) | (_| | | | | (_) | |_| | | | | (_| |
|____/|_|\___/ \___/ \__,_|_| |_|\___/ \__,_|_| |_|\__,_|
    " $'\e[0m'
}
logo


# targets=("token" "key" "api" "amazonaws" "username" "password" "pass" "credential" "secret" "todo" "vulnerable" "random" "hmac" "md5" "sha-1" "sha-2" "hash" "csrf" "hostname" "auth" "bucket" "ec2")
# inputfile=input.js
#
# while read LINE; do
#
# 	echo "==============="
# 	echo ${LINE}    # do something with it here
#
# 	echo ""
# 	echo "Downloading JS file..."
# 	echo ""
#
# 	wget ${LINE} -O $inputfile
#
# 	echo ""
# 	echo "Beautifying JS file..."
# 	echo ""
#
# 	js-beautify $inputfile >> target.js
#
# 	echo ""
# 	echo "Beginning scan..."
# 	echo ""
#
# 	for i in "${targets[@]}"
# 	do
# 		grep -in $i target.js --color
# 	done
#
# 	echo ""
# 	echo "Scan complete."
# 	echo ""
# done
