#!/bin/bash
./gradlew clean transfer:transfer-01-file-transfer:file-transfer-consumer:build
java -Dedc.fs.config=transfer/transfer-01-file-transfer/file-transfer-consumer/config.properties \
-jar transfer/transfer-01-file-transfer/file-transfer-consumer/build/libs/consumer.jar
