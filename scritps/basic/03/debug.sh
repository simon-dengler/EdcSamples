#!/bin/bash
./gradlew clean basic:basic-03-configuration:build
java -Dedc.fs.config=/home/simon/eclipse-edc/Samples/basic/basic-03-configuration/config.properties \
-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005 \
-jar basic/basic-03-configuration/build/libs/filesystem-config-connector.jar
