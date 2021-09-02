#!/bin/bash

echo "Getting all target urls..."
cat hosts | sed 's/https\?:\/\///' | gau >> urls.txt

echo "Sorting all JS urls..."
cat urls.txt | grep -P "\w+\.js(\?|$)" | sort -u >> jsurls.txt

echo "Now run: ffuf -mc 200 -w jsurls.txt:HFUZZ -u HFUZZ -replay-proxy http://127.0.0.1:8080"
