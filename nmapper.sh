#!/bin/bash

## Simple script to run a few different nmap scans on a target and collect the results together
## Requires: Nmap (Obviously)

## Clear the results file first
: > results.txt
echo -e "Beginning scans on target: $1\n" | tee -a results.txt

## Run with default NSE scripts, Version detection and output to results file
nmap -v -sC -sV $1 -oN results.txt --append-output

echo -e "\n1. Default scripts & Version detection scan completed\n" | tee -a results.txt

## Scan all ports
nmap -v -sC -sV -p 1-1000 $1 -oN results.txt --append-output
echo -e "\n2. Total port scan completed\n" | tee -a results.txt

## Scan top ports 
nmap -v -sU -sV --top-ports 20 $1 -oN results.txt --append-output
echo -e "\n3. Top 20 ports scan complete\n" | tee -a results.txt

## Scan for vulnerabilities 
nmap -v --script vuln $1 -oN results.txt --append-output
echo -e "\n4. Vulnerability scan completed\n" | tee -a results.txt

echo -e "\nAll scans complete, results can be found in results.txt" | tee -a results.txt
