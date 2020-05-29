#!/bin/bash

## This requires the aliases setup from here - https://edoverflow.com/2017/lightweight-reconnaissance-setup/

mkdir recon 
cd recon/

## Sublist3r -- Get subdomains
python ~/tools/Sublist3r/sublist3r.py -d $1 -o output

## Find only the live domains
cat output | httprobe | tee -a domains

## Take screenshots of every domain
python ~/tools/webscreenshot/webscreenshot.py -i domains

## Dirsearch-one command converted to run with full filepaths and no backslashes
. <(cat domains | awk '{print "python3 ~/tools/dirsearch/dirsearch.py -u " $1 " -e * --json-report=directories"}')

## Openredirect
. <(cat domains | awk '{print "python3 ~/tools/dirsearch/dirsearch.py -u " $1  " -w ~/tools/dirsearch/db/open_redirect_wordlist.txt -e * --json-report=redirects"}')
