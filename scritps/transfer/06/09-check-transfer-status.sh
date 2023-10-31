#!/bin/bash
set -x
TRANSFER_PROCESS_ID=$(cat ./transferProcessId) #<-- edit here
curl -X GET "http://localhost:29193/management/v2/transferprocesses/$TRANSFER_PROCESS_ID" -s | jq
