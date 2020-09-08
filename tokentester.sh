#!/bin/bash

while IFS=read -r line
do

	echo ""
	echo "--- Testing: $line ---"
	curl https://circleci.com/api/v2/me?circle-token=$line

done < $1
