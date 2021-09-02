#!/bin/bash


if [[ $# -eq 0 ]] ; then
    echo "Please enter a target."
    exit 1
fi

org=$1

mkdir member_scan
cd member_scan

> members.txt
> $org-repos.txt

echo $'\e[1;33m'"========== Fetching $org Information ==========" $'\e[0m'

echo ""
echo "Fetching members from $org..."
curl -s https://api.github.com/orgs/$org/members?per_page=500 | jq '.[]|.login' | sed 's/"//g' >> members.txt
cat members.txt

#echo ""
#echo "Fetching repos from $org..." 
#curl -s https://api.github.com/orgs/$org/repos?per_page=500 | jq '.[]|.name' | sed 's/"//g' >> $org-repos.txt
#cat $org-repos.txt

## Get all repos from a given user
#curl -s https://api.github.com/users/$target/repos?per_page=500 | jq '.[]|.html_url' | sed 's/"//g' >> repos.txt

echo ""
echo $'\e[1;33m'"========== Scanning Repositories ==========" $'\e[0m'
#echo "Beginning scan of target repositories..."

while IFS= read -r member; do

	echo ""
	echo $'\e[1;33m'"========== $member ==========" $'\e[0m'
	echo "Beginning scan of repos..."
	mkdir $member
	cd $member
	curl -s https://api.github.com/users/$member/repos?per_page=500 | jq '.[]|.name' | sed 's/"//g' >> repos.txt
	cat repos.txt

	while IFS= read -r repo; do

		> tmp.json
		gitleaks -r https://github.com/$member/$repo -o tmp.json
		cat tmp.json >> leaks.json

	done < repos.txt
	
	rm tmp.json
	jq '.[].offender' leaks.json >> offenders.txt
	sort -u offenders.txt >> uniques.txt
	cd ..

done < members.txt

#while IFS= read -r line; do
#	
#	> tmp.json
#	gitleaks -r $line -o tmp.json 
#	cat tmp.json >> userleaks.json
#
#done < repos.txt

#rm tmp.json

#jq '.[].offender' userleaks.json >> user-offenders.txt
#jq '.[] | "\(.offender) \(.date)"' gitleaks.json >> offenders.txt

#sort -u user-offenders.txt >> user-uniques.txt
