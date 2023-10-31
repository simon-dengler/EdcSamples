#!/bin/bash
if [ -z "$1" ]; then
    read -e -s -p 'Auth code from logger or press enter for automatic grep from syslogs: ' AUTH_CODE
else
    AUTH_CODE=$1 #<-- edit here
fi
[ -z "$AUTH_CODE" ] && AUTH_CODE=$(grep "authCode" /var/log/syslog | tail -1 | sed -E 's~(.*\]: )(\{\"id\":\".*)~\2~gm;t' | jq -r ".authCode")
[ -z "$AUTH_CODE" ] && echo "No auth code supplied" && exit 1

set -x
#echo -e $(curl --location --request GET 'http://localhost:29291/public/' --header "Authorization: $AUTH_CODE" -s)
curl --location --request GET 'http://localhost:29291/public/' --header "Authorization: $AUTH_CODE" -s | jq
