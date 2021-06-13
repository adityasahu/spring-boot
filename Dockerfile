FROM openjdk:8-jre-alpine

COPY ./target/hello-world-0.0.1-SNAPSHOT.jar /usr/app/

WORKDIR /usr/app

ENTRYPOINT ["java","-jar","hello-world-0.0.1-SNAPSHOT.jar"]
