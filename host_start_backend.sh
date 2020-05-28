#!/bin/sh

docker-compose rm -f tracing_database backend
./backend/gradlew build
docker-compose up --build --force-recreate
