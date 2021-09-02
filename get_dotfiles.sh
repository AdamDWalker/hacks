#!/bin/bash

curl -H "Accept: application/json" -H "Content-Type: application/json" -X GET https://api.github.com/orgs/$1/members | jq '.[] .login' | tr -d '"' >> members.txt

while IFS= read -r line; do
	echo "Testing user: $line"
	#curl -I https://api.github.com/repos/$line/dotfiles

	status_code=$(curl --write-out %{http_code} --silent --output /dev/null https://api.githubcom/repos/$line/dotfiles)

	if [[ "$status_code" -ne 200 ]] ; then
  		echo "$line has no dotfiles repository"
	else
  		echo "Found dotfiles belonging to user: $line"
	fi
done < members.txt



