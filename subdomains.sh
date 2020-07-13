#!/bin/bash

amass enum --passive -d $1 -o domains_$1
assetfinder --subs-only $1 | tee -a domains_$1

python /home/adam/tools//Sublist3r/sublist3r.py -d $1 -o domains_sublist3r_$1
cat domains_sublist3r_$1 | tee -a domains_$1


sort -u domains_$1 -o domains_$1
#cat domains_$1 | filter-resolved | tee -a domains_$1.txt
sort -u domains_$1 | httprobe | tee -a subs.txt
rm domains_sublist3r_$1 domains_$1
