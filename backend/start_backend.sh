#! /bin/bash

echo "Waiting for Database to start....."
while ! nc -z tracing_database 5432; do sleep 2; done
echo "Database found, connecting....."
java -jar tracing-1.0-SNAPSHOT.war
