#!/bin/bash
set -x
CONTRACT_AGREEMENT_ID=$(cat contractAgreementId) #<-- edit here
export assetId=$(cat ./offerIdAndAssetId | jq -r ".assetId")
curl -X POST "http://localhost:29193/management/v2/transferprocesses" \
    -H "Content-Type: application/json" \
    -d '{
        "@context": {
          "edc": "https://w3id.org/edc/v0.0.1/ns/"
        },
        "@type": "TransferRequestDto",
        "connectorId": "provider",
        "connectorAddress": "http://localhost:19194/protocol",
        "contractId": "'$CONTRACT_AGREEMENT_ID'",
        "assetId": "'$assetId'",
        "protocol": "dataspace-protocol-http",
        "dataDestination": {
          "type": "HttpProxy"
        }
    }' \
    -s | jq | \
tee >(jq -r '."@id"' | tee transferProcessId)
