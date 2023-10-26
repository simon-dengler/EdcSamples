#!/bin/bash
AGREEMENT_ID="bed9094f-1e90-4768-b6c9-77d8aa72b730" # <-- edit this id
curl -X GET "http://localhost:29193/management/v2/contractnegotiations/$AGREEMENT_ID" \
    --header 'Content-Type: application/json' \
    -s | jq
