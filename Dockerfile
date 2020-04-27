FROM java:8-jdk-alpine
COPY ./build/libs/tracing-1.0-SNAPSHOT.war /usr/app/
WORKDIR /usr/app
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "tracing-1.0-SNAPSHOT.war"]