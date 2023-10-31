#!/bin/bash
set -x
#if [ $# -eq 0 ]
#  then
#    echo "No arguments supplied"
#fi
#if [ -z "$1" ]
#  then
#    echo "No argument supplied"
#fi
[ -z "$1" ] && echo "No argument supplied" && exit 1
export newAssetId=$(echo -e $(< /dev/urandom tr -dc A-Za-z0-9 | head -c 12 ) | tee -a assetIds)
curl -d '{
           "@context": {
             "edc": "https://w3id.org/edc/v0.0.1/ns/"
           },
           "asset": {
             "@id": "'$newAssetId'",
             "properties": {
               "name": "product description",
               "contenttype": "application/json"
             }
           },
           "dataAddress": {
             "type": "HttpData",
             "name": "Test asset",
             "baseUrl": "'$1'",
             "proxyPath": "true"
           }
         }' -H 'content-type: application/json' http://localhost:19193/management/v2/assets \
         -s | jq
