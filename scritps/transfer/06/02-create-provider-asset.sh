#!/bin/bash
curl -d '{
           "@context": {
             "edc": "https://w3id.org/edc/v0.0.1/ns/"
           },
           "asset": {
             "@id": "assetId",
             "properties": {
               "name": "product description",
               "contenttype": "application/json"
             }
           },
           "dataAddress": {
             "type": "HttpData",
             "name": "Test asset",
             "baseUrl": "https://jsonplaceholder.typicode.com/users",
             "proxyPath": "true"
           }
         }' -H 'content-type: application/json' http://localhost:19193/management/v2/assets \
         -s | jq
