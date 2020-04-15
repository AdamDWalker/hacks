#!/bin/bash

## Simple script to get the robots.txt file from a given site and analyse it

wget $1/robots.txt
mv robots.txt $1-robots.txt
