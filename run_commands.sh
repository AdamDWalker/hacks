#!/bin/bash

commands=$1
notify='history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*notify$//'\'' | ~/tools/discord_notify/./discord_notify.sh'


echo ""
echo "Beginning Commands"

while IFS= read -r command; do
	
	echo ""
	eval $command; $notify

done < $commands

echo ""
echo "Commands Completed"
