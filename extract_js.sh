#!/bin/bash

waybackurls $1 | grep -iE "\.js$" | uniq | sort | tee -a $1-js.txt
