#!/bin/bash
curl -d '{
           "@context": {
             "edc": "https://w3id.org/edc/v0.0.1/ns/",
             "odrl": "http://www.w3.org/ns/odrl/2/"
           },
           "@id": "aPolicy",
           "policy": {
             "@type": "set",
             "odrl:permission": [],
             "odrl:prohibition": [],
             "odrl:obligation": []
           }
         }' -H 'content-type: application/json' http://localhost:19193/management/v2/policydefinitions \
         -s | jq
