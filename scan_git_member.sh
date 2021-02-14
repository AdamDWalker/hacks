#!/bin/bash

target=$1
mkdir $target
cd $target

echo "Fetching repos from user: $1..."
curl -s https://api.github.com/users/$target/repos?per_page=500 | jq '.[]|.html_url' | sed 's/"//g' >> repos.txt

echo ""
cat repos.txt

echo ""
echo $'\e[1;33m'"========== Scanning Repositories ==========" $'\e[0m'

while IFS= read -r repo; do

	> tmp.json
	gitleaks -r $repo -o tmp.json
	cat tmp.json >> leaks.json

done < repos.txt

rm tmp.json

jq '.[].offender' leaks.json >> offenders.txt

sort -u offenders.txt >> uniques.txt
