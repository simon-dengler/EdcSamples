#!/bin/bash
java -Dedc.keystore=transfer/transfer-06-consumer-pull-http/certs/cert.pfx \
-Dedc.keystore.password=123456 \
-Dedc.vault=transfer/transfer-06-consumer-pull-http/http-pull-provider/provider-vault.properties \
-Dedc.fs.config=transfer/transfer-06-consumer-pull-http/http-pull-provider/provider-configuration.properties \
-jar transfer/transfer-06-consumer-pull-http/http-pull-connector/build/libs/pull-connector.jar
