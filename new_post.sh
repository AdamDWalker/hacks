#!/bin/bash


title=$1

if [ $# -eq 0 ]
  then
    echo "No file name provided, defaulting to New-Post"
    title="new-post"
fi

DATE=`date "+%Y-%m-%d"`
#echo "${DATE}-$title.md"

cat > "${DATE}-$title.md" <<- "EOF"
---
layout: post
title: 
author: Adam Walker
---

EOF

