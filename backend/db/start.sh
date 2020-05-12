#! /bin/bash

docker run -d --name tracing_db -p 127.0.0.1:5432:5432 covid_tracing_db
