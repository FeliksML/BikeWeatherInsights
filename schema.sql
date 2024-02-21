CREATE SCHEMA ridership_weather;

SET search_path TO ridership_weather;

CREATE TABLE rider_info (
    ride_id varchar(20) primary key,
    rideable_type varchar(20),
    member_casual varchar(6),
    duration_min float
);

COPY rider_info(ride_id, rideable_type, member_casual, duration_min)
FROM 'data/ridership.csv'
WITH (FORMAT csv, HEADER true);

CREATE TABLE starting_point (
    ride_id varchar(20),
    started_at timestamp,
    start_station_name varchar,
    start_station_id varchar(7),
    start_lat float,
    start_lng float,
    FOREIGN KEY (ride_id) REFERENCES rider_info(ride_id)
);

COPY starting_point(ride_id, started_at, start_station_name, start_station_id, start_lat, start_lng)
FROM 'data/ridership.csv'
WITH (FORMAT csv, HEADER true);

CREATE TABLE ending_point (
    ride_id varchar(20),
    ended_at timestamp,
    end_station_name varchar,
    end_station_id varchar(7),
    end_lat float,
    end_lng float,
    FOREIGN KEY (ride_id) REFERENCES rider_info(ride_id)
);

COPY ending_point(ride_id, ended_at, end_station_name, end_station_id, end_lat, end_lng)
FROM 'data/ridership.csv'
WITH (FORMAT csv, HEADER true);

CREATE TABLE weather (
    date DATE PRIMARY KEY,
    tavg DECIMAL(5,2),
    tmin DECIMAL(5,2),
    tmax DECIMAL(5,2),
    prcp DECIMAL(5,2),
    snow DECIMAL(5,2),
    wdir INT,
    wspd DECIMAL(5,2),
    pres DECIMAL(7,2)
);

COPY weather(date, tavg, tmin, tmax, prcp, snow, wdir, wspd, pres)
FROM 'data/weather.csv'
WITH (FORMAT csv, HEADER true);
