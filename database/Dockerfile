FROM mdillon/postgis
ENV POSTGRES_USER postgres
ENV POSTGRES_PASS admin_password
ENV POSTGRES_DB tracing

COPY ./postgisz_dump.sql /docker-entrypoint-initdb.d/postgiz_dump.sql
COPY ./contacts.csv /contacts.csv
COPY ./volunteers.csv /volunteers.csv
COPY ./patients.csv /patients.csv
COPY ./events.csv /events.csv
EXPOSE 5432
