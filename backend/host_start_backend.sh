#!/bin/sh

./gradlew build
docker-compose up --build --force-recreate
