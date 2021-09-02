#!/bin/bash

directory=$1

key_patterns=(auth-basic auth-bearer auth-http aws-client-id aws-keys aws-mws-key aws-secret-key cloudinary-basic-auth facebook-access-token facebook-client-id facebook-oauth facebook-secret-key firebase github google-api-key google-cloud-key google-drive-key google-ouath-token google-youtube-key heroku-api linkedin-id linkedin-secret mailchamp-api mailgun-api picatic-api slack-token slack-webhook square-secret square-token stripe-key twilio-key twitter-id twitter-oauth twitter-secret)



for pattern in "${key_patterns[@]}"
do
	echo "[x] Searching for pattern: $pattern"
	gf $pattern $directory
done
