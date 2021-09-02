#!/bin/bash

while IFS= read -r line
do
    echo ""
    echo "===================="
    echo "Bucket - $line"
    echo "===================="
    echo ""
    echo "Attempting to list contents"
    aws s3 ls s3://$line --no-sign-request
    aws s3 ls s3://$line
    #echo ""
    #echo "Attempting to upload"
    #aws s3 cp h1.txt s3://$line/test-file.txt --no-sign-request
    echo ""
    echo "Attempting ACL access"
    aws s3api get-bucket-acl --bucket $line --no-sign-request
    aws s3api get-bucket-acl --bucket $line
    echo "--------------------"
    echo ""

done < $1
