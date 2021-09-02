#!/usr/bin/env python3

'''
    File Name: bloodhound.py
    Author: Adam Walker
    Date Created: 07/09/2020
    Date Last Modified: 09/09/2020
'''

import re
import json
import sys

# TODO:
# Print cool banner //
# Parse target arguments
# Read regex search patterns from file //
# Perform regex search //
# Format and output results [WIP]

## Formatting colours
G = '\033[92m'  # green
Y = '\033[93m'  # yellow
B = '\033[94m'  # blue
R = '\033[91m'  # red
W = '\033[0m'   # white


#target_file = "../../APKs/Decompiled/arlo_2.19.1_28105.apk/res/values/strings.xml"
target_file = sys.argv[1]
pattern_file = "/home/adam/Documents/Git/hacks/patterns.json"

def banner():
    print("""%s
 ____  _                 _ _                           _
| __ )| | ___   ___   __| | |__   ___  _   _ _ __   __| |
|  _ \| |/ _ \ / _ \ / _' | '_ \ / _ \| | | | '_ \ / _' |
| |_) | | (_) | (_) | (_| | | | | (_) | |_| | | | | (_| |
|____/|_|\___/ \___/ \__,_|_| |_|\___/ \__,_|_| |_|\__,_|
%s
""" % (R, Y))

with open(pattern_file) as f:
    data = json.load(f)


## For each line in the target file, regex search with every pattern
## in the patterns file and output any matches along with the filename
## and what the matching pattern was
def hunt():
    file = open(target_file, "r")
    line_num = 1
    for line in file:
        for target in data:
            for pattern in data[target]['values']:
                found = re.search(pattern, line)
                if found:
                # if re.search(pattern, line):
                    # print(result.group(0))
                    output = f"%s[{target_file}:{line_num}]%s - Found pattern [{data[target]['key']}]: %s {found.group(0)}" % (G, Y, W)
                    print(output)
                    break

        line_num = line_num + 1


## Let's get on with it
banner()
print("Beginning scan...\n\n")
hunt()
