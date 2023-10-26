#!/bin/bash
TRANSFER_PROCESS_ID="2b27b0bc-c0e8-4fb5-8e84-13d00fd5e117" #<-- edit here
curl -X GET "http://localhost:29193/management/v2/transferprocesses/$TRANSFER_PROCESS_ID"
