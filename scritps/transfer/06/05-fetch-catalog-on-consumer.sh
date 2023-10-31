#!/bin/bash
set -x
curl -X POST "http://localhost:29193/management/v2/catalog/request" \
    -H 'Content-Type: application/json' \
    -d '{
      "@context": {
        "edc": "https://w3id.org/edc/v0.0.1/ns/"
      },
      "providerUrl": "http://localhost:19194/protocol",
      "protocol": "dataspace-protocol-http"
    }' -s | jq | tee catalog
jq -r '."dcat:dataset"."odrl:hasPolicy" | {offerId: ."@id", assetId: ."odrl:target"}' catalog | jq -r | tee offerIdAndAssetId
offerIdAndAssetId=$(cat offerIdAndAssetId)
[ -z "$offerIdAndAssetId" ] && jq -r '."dcat:dataset"[] | select(."@id" == "'$(tail -1 assetIds)'")."odrl:hasPolicy" | .[1] | {offerId: ."@id", assetId: ."odrl:target"}' catalog | jq -r | tee offerIdAndAssetId

#echo $(cat offerIdAndAssetId)
