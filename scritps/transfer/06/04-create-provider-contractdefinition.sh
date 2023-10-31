#!/bin/bash
set -x
assetId=$(tail -1 assetIds)
export policyId=$(grep -Po '(?<=^'$assetId' = )\w*$' assetPolicies | tail -1)
contractId=$(< /dev/urandom tr -dc A-Za-z0-9 | head -c 12)
echo -e $( { echo $policyId ; echo "=" ; echo $contractId ; } ) | tee -a policyCopntracts
curl -d '{
           "@context": {
             "edc": "https://w3id.org/edc/v0.0.1/ns/"
           },
           "@id": "'$contractId'",
           "accessPolicyId": "'$policyId'",
           "contractPolicyId": "'$policyId'",
           "assetsSelector": []
         }' -H 'content-type: application/json' http://localhost:19193/management/v2/contractdefinitions \
         -s | jq
#Empty assetsSelector means every asset is targeted!
