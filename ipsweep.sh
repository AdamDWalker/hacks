#!/bin/bash

if [ "$1" == "" ]
then
echo "Error - Script requires one IP address as an argument"

else
for ip in `seq 1 254`; do
	ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":"&
	sleep 0.01
done
fi

echo "Scan complete"
