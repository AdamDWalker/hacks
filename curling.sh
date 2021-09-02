#!/bin/bash

if [ -z "$2" ]
  then
    echo ""
    echo $'\e[1;31m'" No FUZZ provided. Please provide a FUZZ parameter" $'\e[0m'
    echo ""
    exit 1
	else
		fuzz=$2
    echo ""
    echo ""
    echo $'\e[1;33m'"======== Testing for: $fuzz ========" $'\e[0m'
    echo ""
fi

while IFS= read -r line
do

  curl -o /dev/null --silent -Iw '%{http_code}' ${line}/$fuzz
  echo "  -  ${line}/$fuzz"

done < $1
