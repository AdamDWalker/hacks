#!/bin/bash


targets=$1
mkdir live_subdomains

#echo ""
#echo $'\e[1;33m'"======== Finding Subdomains ========" $'\e[0m'

while IFS= read -r domain; do

	echo ""
	echo $'\e[1;33m'"======== Finding Subdomains for: $domain ========" $'\e[0m'

	echo ""
	echo $'\e[32m'"----- Amass Started -----" $'\e[0m'
	amass enum --passive -d $domain -o amass_subs.txt

	echo ""
	echo $'\e[32m'"----- Assetfinder Started -----" $'\e[0m'
	assetfinder --subs-only $domain | tee -a asset_subs.txt

	echo ""
	echo $'\e[32m'"----- Sublist3r Started -----" $'\e[0m'
	python /home/adam/tools/Sublist3r/sublist3r.py -d $domain -o sublist3r_subs.txt

	cat amass_subs.txt asset_subs.txt sublist3r_subs.txt | sed 's/<BR>/\n/g' | sort -u > $domain-subs.txt

	echo ""
	echo $'\e[32m'"Finding Live Subdomains..." $'\e[0m'
	cat $domain-subs.txt | httprobe -c 50 -t 3000 > live_subdomains/$domain.txt

	rm amass_subs.txt
	rm asset_subs.txt
	rm sublist3r_subs.txt

done < $targets



