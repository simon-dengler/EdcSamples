#!/bin/bash
set -x
AGREEMENT_ID=$(cat ./agreementId) # <-- edit this id
curl -X GET "http://localhost:29193/management/v2/contractnegotiations/$AGREEMENT_ID" \
    --header 'Content-Type: application/json' \
    -s | jq | \
tee >(jq -r '."edc:contractAgreementId"' | tee contractAgreementId)
