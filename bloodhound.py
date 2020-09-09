#!/usr/bin/env python3

'''
    File Name: bloodhound.py
    Author: Adam Walker
    Date Created: 07/09/2020
    Date Last Modified: 09/09/2020
'''

import re
import json

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


target_file = "test.txt"
pattern_file = "patterns.json"

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
                    output = f"%s[{target_file}:{line_num}]%s - Found pattern [{data[target]['key']}]: %s {line}" % (G, Y, W)
                    print(output)
                    break

        line_num = line_num + 1


## Let's get on with it
banner()
hunt()
