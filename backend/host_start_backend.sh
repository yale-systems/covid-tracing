#!/bin/sh

docker-compose rm -f tracing_database backend
./gradlew build
docker-compose up --build --force-recreate
