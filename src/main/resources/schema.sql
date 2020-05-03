DROP TABLE IF EXISTS dummy_data;
CREATE TABLE dummy_data (
  id SERIAL PRIMARY KEY,
  trace_id INT,
  start_time TIMESTAMP,
  latitude FLOAT,
  longitude FLOAT,
  end_time TIMESTAMP ,
  confirmed BOOLEAN
);

--INSERT INTO test_data (data) VALUES ('automatically inserted');


