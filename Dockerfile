FROM gradle:jdk17 AS build

WORKDIR /home/gradle/project/
#COPY --chown=gradle:gradle . /home/gradle/project/
COPY --chown=gradle:gradle . /home/gradle/project/
RUN gradle transfer:transfer-00-prerequisites:connector:build

FROM openjdk:17-slim

WORKDIR /app
COPY --from=build /home/gradle/project/transfer/transfer-00-prerequisites/connector/build/libs/connector.jar /app/cus-connector.jar
COPY --from=build /home/gradle/project/cus/resources /app/prerequisites

ENTRYPOINT ["java", "-Dedc.keystore=/app/prerequisites/certs/cert.pfx", "-Dedc.keystore.password=123456", "-Dedc.fs.config=/app/prerequisites/configuration/cus-connector-configuration.properties", "-jar", "/app/cus-connector.jar"]
