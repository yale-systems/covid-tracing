-- DROP TABLE IF EXISTS dummy_data;
-- CREATE TABLE dummy_data (
--   id SERIAL PRIMARY KEY,
--   trace_id INT,
--   start_time TIMESTAMP,
--   latitude FLOAT,
--   longitude FLOAT,
--   end_time TIMESTAMP ,
--   confirmed BOOLEAN
-- );

DROP TABLE IF EXISTS dummy_data;
CREATE TABLE dummy_data (
  id SERIAL PRIMARY KEY,
  trace_id integer,
  start_time timestamp without time zone,
  end_time timestamp without time zone,
  confirmed boolean,
  geom public.geometry(Point,4326)
);

--INSERT INTO test_data (data) VALUES ('automatically inserted');


