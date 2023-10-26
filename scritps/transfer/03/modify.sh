#!/bin/bash
./gradlew transfer:transfer-03-modify-transferprocess:modify-transferprocess-consumer:build
java -Dedc.fs.config=transfer/transfer-03-modify-transferprocess/modify-transferprocess-consumer/config.properties \
-jar transfer/transfer-03-modify-transferprocess/modify-transferprocess-consumer/build/libs/consumer.jar
