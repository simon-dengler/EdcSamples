#!/bin/bash
set -x
export offerIdAndAssetId=$(cat ./offerIdAndAssetId)
export offerId=$(echo $offerIdAndAssetId | jq -r ".offerId")
export assetId=$(echo $offerIdAndAssetId | jq -r ".assetId")
curl -d '{
  "@context": {
    "edc": "https://w3id.org/edc/v0.0.1/ns/",
    "odrl": "http://www.w3.org/ns/odrl/2/"
  },
  "@type": "NegotiationInitiateRequestDto",
  "connectorId": "provider",
  "connectorAddress": "http://localhost:19194/protocol",
  "consumerId": "consumer",
  "providerId": "provider",
  "protocol": "dataspace-protocol-http",
  "offer": {
   "offerId": "'$offerId'",
   "assetId": "'$assetId'",
   "policy": {
     "@id": "'$offerId'",
     "@type": "Set",
     "odrl:permission": [],
     "odrl:prohibition": [],
     "odrl:obligation": [],
     "odrl:target": "'$assetId'"
   }
  }
}' -X POST -H 'content-type: application/json' http://localhost:29193/management/v2/contractnegotiations \
-s | jq | \
tee >(jq -r '."@id"' | tee agreementId)
