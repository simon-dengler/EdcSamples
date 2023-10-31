#!/bin/bash
set -x
#export assetPolicy=$(echo -e $( { tail -1 assetIds ; echo "=" ; < /dev/urandom tr -dc A-Za-z0-9 | head -c 12 ; } ) | tee -a assetPolicies)
policyId=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 12)
echo -e $( { tail -1 assetIds ; echo "=" ; echo $policyId ; } ) | tee -a assetPolicies
curl -d '{
           "@context": {
             "edc": "https://w3id.org/edc/v0.0.1/ns/",
             "odrl": "http://www.w3.org/ns/odrl/2/"
           },
           "@id": "'$policyId'",
           "policy": {
             "@type": "set",
             "odrl:permission": [],
             "odrl:prohibition": [],
             "odrl:obligation": []
           }
         }' -H 'content-type: application/json' http://localhost:19193/management/v2/policydefinitions \
         -s | jq
