FROM java:8-jdk-alpine
COPY ./build/libs/tracing-1.0-SNAPSHOT.war /usr/app/
WORKDIR /usr/app
EXPOSE 8080
EXPOSE 5432
COPY ./start_backend.sh /start_backend.sh
ENTRYPOINT ["/bin/sh", "/start_backend.sh"]
# Old entrypoint, doesn't wait for DB to be up and running
# ENTRYPOINT ["java", "-jar", "tracing-1.0-SNAPSHOT.war"]
