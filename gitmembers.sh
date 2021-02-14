#!/bin/bash


if [[ $# -eq 0 ]] ; then
    echo "Please enter a target."
    exit 1
fi

target=$1

> members.txt

echo $'\e[1;33m'"========== Fetching Users ==========" $'\e[0m'
#echo "Fetching repos from $target..."

## Get all repos from a give org
#curl -s https://api.github.com/orgs/$target/repos?per_page=500 | jq '.[]|.html_url' | sed 's/"//g' >> repos.txt

## Get all users from a given org
curl -s https://api.github.com/orgs/$target/members?per_page=500 | jq '.[]|.login' | sed 's/"//g' >> members.txt

## Get all repos from a given user
# curl -s https://api.github.com/users/$user/repos?per_page=500 | jq '.[]|.html_url' | sed 's/"//g'

cat members.txt
