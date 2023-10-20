#!/bin/bash
./gradlew clean transfer:transfer-01-file-transfer:file-transfer-provider:build
java -Dedc.fs.config=transfer/transfer-01-file-transfer/file-transfer-provider/config.properties \
-jar transfer/transfer-01-file-transfer/file-transfer-provider/build/libs/provider.jar
