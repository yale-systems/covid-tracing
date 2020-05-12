FROM mdillon/postgis
ENV POSTGRES_USER postgres
ENV POSTGRES_PASS admin_password
ENV POSTGRES_DB tracing

COPY ./postgisz_db_init_data_dump.sql /docker-entrypoint-initdb.d/
EXPOSE 5432
