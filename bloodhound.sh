#!/bin/bash

# Bloodhound
# Simple script to sniff through JS files and find interesting things. For now it will probably just be really basic

targets=("token" "key" "api" "amazonaws" "username" "password" "pass" "credential" "secret" "todo" "vulnerable" "random" "hmac" "md5" "sha-1" "sha-2" "hash" "csrf" "hostname" "window")

echo ""
echo "Downloading JS file..."
echo ""

wget $1 -O input.js

echo ""
echo "Beginning scan..."
echo ""

for i in "${targets[@]}"
do
	grep -in $i input.js --color
done

echo ""
echo "Scan complete."
echo ""
