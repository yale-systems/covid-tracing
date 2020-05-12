docker run --rm --name=covid_tracing_db -e POSTGRES_USER=registry_admin -e POSTGRES_PASSWORD=password -e POSTGRES_DB=registry -p 5432:5432 -d mdillon/postgis
