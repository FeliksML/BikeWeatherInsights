CREATE SCHEMA ridership_weather;

CREATE TEMPORARY TABLE temp_ridership_data (
    ride_id varchar(20),
    rideable_type varchar(20),
    started_at timestamp,
    ended_at timestamp,
    start_station_name varchar(255),
    start_station_id varchar(7),
    end_station_name varchar(255),
    end_station_id varchar(7),
    start_lat float,
    start_lng float,
    end_lat float,
    end_lng float,
    member_casual varchar(6),
    duration_min float
);
COPY temp_ridership_data (
                          ride_id,
                          rideable_type,
                          started_at,
                          ended_at,
                          start_station_name,
                          start_station_id,
                          end_station_name,
                          end_station_id,
                          start_lat,
                          start_lng,
                          end_lat,
                          end_lng,
                          member_casual,
                          duration_min
    )
FROM '/var/lib/postgresql/data1/ridership.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',');


CREATE TABLE rider_info (
    ride_id varchar(20) primary key,
    rideable_type varchar(20),
    member_casual varchar(6),
    duration_min float
);

CREATE TABLE starting_point (
    ride_id varchar(20),
    started_at timestamp,
    start_station_name varchar,
    start_station_id varchar(7),
    start_lat float,
    start_lng float,
    FOREIGN KEY (ride_id) REFERENCES rider_info(ride_id)
);

CREATE TABLE ending_point (
    ride_id varchar(20),
    ended_at timestamp,
    end_station_name varchar,
    end_station_id varchar(7),
    end_lat float,
    end_lng float,
    FOREIGN KEY (ride_id) REFERENCES rider_info(ride_id)
);

CREATE TABLE weather (
    date DATE PRIMARY KEY,
    tavg DECIMAL(5,2),
    tmin DECIMAL(5,2),
    tmax DECIMAL(5,2),
    prcp DECIMAL(5,2),
    snow DECIMAL(5,2),
    wdir DECIMAL(5,2),
    wspd DECIMAL(5,2),
    pres DECIMAL(7,2)
);

COPY weather (date, tavg, tmin, tmax, prcp, snow, wdir, wspd, pres)
    FROM '/var/lib/postgresql/data1/weather.csv'
    WITH (FORMAT csv, DELIMITER ',', HEADER true);

-- Insert into rider_info
INSERT INTO rider_info (ride_id, rideable_type, member_casual, duration_min)
SELECT ride_id, rideable_type, member_casual, duration_min
FROM temp_ridership_data;

-- Insert into starting_point
INSERT INTO starting_point (ride_id, started_at, start_station_name, start_station_id, start_lat, start_lng)
SELECT ride_id, started_at, start_station_name, start_station_id, start_lat, start_lng
FROM temp_ridership_data;

-- Insert into ending_point
INSERT INTO ending_point (ride_id, ended_at, end_station_name, end_station_id, end_lat, end_lng)
SELECT ride_id, ended_at, end_station_name, end_station_id, end_lat, end_lng
FROM temp_ridership_data;

DROP TABLE temp_ridership_data;

-- All rides grouped by date
CREATE VIEW rides_per_day AS
WITH ride_date AS (
    SELECT r.ride_id,
           r.duration_min,
           sp.started_at
    FROM rider_info r
    JOIN starting_point sp on r.ride_id = sp.ride_id
)
SELECT w.date,
       w.tavg,
       w.prcp,
       round(AVG(rd.duration_min)::numeric,2) avg_duration,
       COUNT(*) ride_amount
FROM weather w
JOIN ride_date rd ON w.date = DATE(rd.started_at)
GROUP BY w.date;

-- Rides per day grouped by average temperature at day(C)
CREATE OR REPLACE VIEW rpd_grouped_by_tavg AS
WITH ride_date AS (
    SELECT r.ride_id,
           r.duration_min,
           sp.started_at
    FROM rider_info r
             JOIN starting_point sp ON r.ride_id = sp.ride_id
)
SELECT
    CASE
        WHEN w.tavg < 5 THEN 'Negative to 5'
        WHEN w.tavg >= 5 AND w.tavg < 10 THEN '5 to 10'
        WHEN w.tavg >= 10 AND w.tavg < 15 THEN '10 to 15'
        WHEN w.tavg >= 15 AND w.tavg < 20 THEN '15 to 20'
        WHEN w.tavg >= 20 AND w.tavg < 25 THEN '20 to 25'
        WHEN w.tavg >= 25 THEN '25+'
        END AS temp_group,
    round(AVG(rd.duration_min)::numeric, 2) AS avg_duration,
    COUNT(*) AS ride_amount

FROM weather w
         JOIN ride_date rd ON w.date = DATE(rd.started_at)
GROUP BY  temp_group ;



