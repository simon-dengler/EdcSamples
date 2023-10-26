#!/bin/bash
./gradlew transfer:transfer-06-consumer-pull-http:http-pull-connector:build
./gradlew util:http-request-logger:build
