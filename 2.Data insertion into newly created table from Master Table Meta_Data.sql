-- IGNORE is used to ignore duplicate entry
INSERT ignore INTO Airline (AIRLINE_ID, UNIQUE_CARRIER, UNIQUE_CARRIER_NAME, UNIQUE_CARRIER_ENTITY)
SELECT DISTINCT
    AIRLINE_ID,
    UNIQUE_CARRIER,
    UNIQUE_CARRIER_NAME,
    UNIQUE_CARRIER_ENTITY
FROM Meta_Data
where Airline_Id is not null;

select * from airline;
select count(distinct airline_id) from airline;

INSERT INTO Airport (
    AIRPORT_ID, AIRPORT_SEQ_ID, CITY_MARKET_ID, AIRPORT_CODE,
    CITY_NAME, STATE_ABR, STATE_FIPS, STATE_NM, WAC
)
SELECT DISTINCT
    ORIGIN_AIRPORT_ID,
    ORIGIN_AIRPORT_SEQ_ID,
    ORIGIN_CITY_MARKET_ID,
    ORIGIN,
    ORIGIN_CITY_NAME,
    ORIGIN_STATE_ABR,
    ORIGIN_STATE_FIPS,
    ORIGIN_STATE_NM,
    ORIGIN_WAC
FROM Meta_Data;

-- Destination
INSERT INTO Airport (
    AIRPORT_ID, AIRPORT_SEQ_ID, CITY_MARKET_ID, AIRPORT_CODE,
    CITY_NAME, STATE_ABR, STATE_FIPS, STATE_NM, WAC
)
SELECT DISTINCT
    DEST_AIRPORT_ID,
    DEST_AIRPORT_SEQ_ID,
    DEST_CITY_MARKET_ID,
    DEST,
    DEST_CITY_NAME,
    DEST_STATE_ABR,
    DEST_STATE_FIPS,
    DEST_STATE_NM,
    DEST_WAC
FROM Meta_Data
where DEST_AIRPORT_ID not in 
(select airport_id from airport);

select * from airport;


INSERT INTO Flight (
    AIRLINE_ID, ORIGIN_AIRPORT_ID, DEST_AIRPORT_ID,
    DISTANCE, DISTANCE_GROUP,
    YEAR, QUARTER, MONTH, CLASS
)
SELECT
    AIRLINE_ID,
    ORIGIN_AIRPORT_ID,
    DEST_AIRPORT_ID,
    DISTANCE,
    DISTANCE_GROUP,
    YEAR,
    QUARTER,
    MONTH,
    CLASS
FROM Meta_Data;

select * from flight;

select freight from meta_data;

INSERT INTO FlightMetrics (
    FLIGHT_ID, PASSENGERS, FREIGHT, MAIL
)
SELECT
    f.FLIGHT_ID,
    m.PASSENGERS,
    cast(m.FREIGHT as float) as FREIGHT,
    m.MAIL
FROM Meta_Data m
JOIN Flight f
  ON f.AIRLINE_ID = m.AIRLINE_ID
 AND f.ORIGIN_AIRPORT_ID = m.ORIGIN_AIRPORT_ID
 AND f.DEST_AIRPORT_ID = m.DEST_AIRPORT_ID
 AND f.YEAR = m.YEAR
 AND f.MONTH = m.MONTH
 AND f.QUARTER = m.QUARTER
 AND f.DISTANCE = m.DISTANCE;
 
select * from city;

insert into city (Cityname, State_ABR, State_NM)
select distinct
   ORIGIN_CITY_NAME,
   ORIGIN_STATE_ABR,
   ORIGIN_STATE_NM
from meta_data;

insert into city (CityName, State_ABR, State_NM)
select distinct
  DEST_CITY_NAME,
  DEST_STATE_ABR,
  DEST_STATE_NM
from meta_data
where DEST_CITY_NAME not in (
  select CityName from city);
  
  select * from city;

