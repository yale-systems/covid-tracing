#!/bin/sh
echo "===== Removing old containers ====="
docker-compose rm -f database backend
echo ""
echo "===== Rebuilding backend ====="
./backend/gradlew build
echo ""
echo "===== Spinning up new containers ====="
docker-compose up --build --force-recreate
