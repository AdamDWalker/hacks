#!/bin/bash

logo(){
echo $'\e[1;31m'"
      _         _
     / \   _ __| |_ ___ _ __ ___ (_)___
    / _ \ | '__| __/ _ \ '_  '_  | / __|
   / ___ \| |  | ||  __/ | | | | | \__ \\
  /_/   \_\_|   \__\___|_| |_| |_|_|___/   " $'\e[0m'
}
logo

domain=$1
mkdir $domain

echo ""
echo ""
echo $'\e[1;33m'"======== Finding Subdomains ========" $'\e[0m'

echo ""
echo $'\e[32m'"----- Amass Started -----" $'\e[0m'
amass enum --passive -d $1 -o $domain/amass_subs.txt

echo ""
echo $'\e[32m'"----- Assetfinder Started -----" $'\e[0m'
assetfinder --subs-only $1 | tee -a $domain/asset_subs.txt

echo ""
echo $'\e[32m'"----- Sublist3r Started -----" $'\e[0m'
python /home/adam/tools//Sublist3r/sublist3r.py -d $1 -o $domain/sublist3r_subs.txt

## Put everything into one file, remove any <BR> bullshit that sublist3r likes to add and remove duplicates
cat $domain/amass_subs.txt $domain/asset_subs.txt $domain/sublist3r_subs.txt | sed 's/<BR>/\n/g' | sort -u > $domain/subdomains.txt
#
rm $domain/asset_subs.txt
rm $domain/amass_subs.txt
rm $domain/sublist3r_subs.txt

echo ""
echo $'\e[32m'"Finding Live Subdomains..." $'\e[0m'
cat $domain/subdomains.txt | httprobe -c 50 -t 3000 > $domain/live_subdomains.txt

echo ""
echo $'\e[1;32m'"----- Subdomain Search Completed -----" $'\e[0m'


echo ""
echo ""
echo $'\e[1;33m'"======== Aquatone Started ========" $'\e[0m'

# python ~/tools/webscreenshot/webscreenshot.py -i $domain/subdomains.txt -o $domain/screenshots/

cat $domain/live_subdomains.txt | aquatone -ports xlarge -out $domain/aquatone/






## Todo
# Get subdomains //
# Get robots.txt 
# Get Directories
# Get Screenshots //
# Get IP addresses, ranges, CIDR, hostnames
# Get live subdomains
# Get waybackurls
# Get vulnerable endpoints
# Get JS code
# Get links
# Get company employees
# Get company repo names / count?
# Internal domains via whoxy.com -> get subs -> JS -> info leak
