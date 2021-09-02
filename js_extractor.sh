#!/bin/bash

targets=$1
links="links.txt"
secrets="secrets.txt"
results="results"

if [ -z "$2" ]
  then
    echo "No argument supplied, default output is in results/"
		mkdir $results
	else
		results=$2
		mkdir $results
fi

echo ""
echo ""
echo $'\e[1;33m'"======== Finding Links ========" $'\e[0m'

while IFS= read -r line; do

	echo "" | tee -a  $links
	echo "----- $line -----" | tee -a $links
	python3 ~/tools/LinkFinder/linkfinder.py -i $line -o cli | tee -a $links

done < $targets

echo ""
echo ""
echo $'\e[1;33m'"======== Finding Secrets ========" $'\e[0m'

while IFS= read -r line; do

	echo "" | tee -a  $secrets
	echo "----- $line -----" | tee -a $secrets
	python3 ~/tools/SecretFinder/SecretFinder.py -i $line -o cli | tee -a $secrets

done < $targets

mv $links $secrets $results
