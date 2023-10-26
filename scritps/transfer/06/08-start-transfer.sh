#!/bin/bash
CONTRACT_AGREEMENT_ID="bbecd71c-9a61-45ec-9d77-9fe82864a843" #<-- edit here
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
        "assetId": "assetId",
        "protocol": "dataspace-protocol-http",
        "dataDestination": {
          "type": "HttpProxy"
        }
    }' \
    -s | jq
