#!/bin/bash


if [[ $# -eq 0 ]] ; then
    echo "Please enter a target."
    exit 1
fi

target=$1

> repos.txt

echo $'\e[1;33m'"========== Fetching Repositories ==========" $'\e[0m'
#echo "Fetching repos from $target..."

## Get all repos from a give org
curl -s https://api.github.com/orgs/$target/repos?per_page=500 | jq '.[]|.html_url' | sed 's/"//g' >> repos.txt

## Get all users from a given org
#curl -s https://api.github.com/orgs/deliveroo/members?per_page=500 | jq '.[]|.html_url' | sed 's/"//g'

## Get all repos from a given user
# curl -s https://api.github.com/users/$user/repos?per_page=500 | jq '.[]|.html_url' | sed 's/"//g'


cat repos.txt

echo ""
echo $'\e[1;33m'"========== Scanning Repositories ==========" $'\e[0m'
#echo "Beginning scan of target repositories..."
while IFS= read -r line; do
	
	> tmp.json
	gitleaks -r $line -o tmp.json 
	cat tmp.json >> gitleaks.json

done < repos.txt

rm tmp.json

jq '.[].offender' gitleaks.json >> offenders.txt
#jq '.[] | "\(.offender) \(.date)"' gitleaks.json >> offenders.txt

sort -u offenders.txt >> unique.txt
