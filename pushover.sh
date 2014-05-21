#!/bin/bash

#FILE NAMES
USER_FILE="PUSHOVER_USER"
TOKEN_FILE="PUSHOVER_TOKEN"

#SET API VARIABLES USING FILES
#THIS ALLOWS THIS PROJECT TO BE
#OPENSOURCED WITHOUT SHARING PERSONAL
#TOKENS AND DATA, ALSO THIS FILES
#WILL BE GIT IGNORED

if [[ ! -f "$USER_FILE" ]]; then
	echo "$USER_FILE file not found!, you need to create this file and put your User Key"
	exit
fi

if [[ ! -f "$TOKEN_FILE" ]]; then
	echo "$TOKEN_FILE file not found!, you need to create this file and put your API Key/Token"
	exit
fi

PUSHOVER_USER_KEY=$(cat $USER_FILE);
PUSHOVER_TOKEN_KEY=$(cat $TOKEN_FILE);

##############################
#DO NOT EDIT AFTER THIS POINT
##############################

while getopts "t:m:p:n" opt; do
	case $opt in
		t)
			TITLE="$OPTARG"
			;;
		m)
			MESSAGE="$OPTARG"
			;;
		p)
			PRIORITY="$OPTARG"
			;;
		n)
			DEBUG="$OPTARG"
			;;
	esac
done

#DEFAULTS
if [ -z "$PRIORITY" ]; then PRIORITY="0"; fi

curl -s \
	-F "token=$PUSHOVER_TOKEN_KEY" \
	-F "user=$PUSHOVER_USER_KEY" \
	-F "title=$TITLE" \
	-F "message=$MESSAGE" \
	-F "priority=$PRIORITY" \
	https://api.pushover.net/1/messages.json