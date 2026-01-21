-- Data Analysis
select * from flight_metrics; 
select * from flight;
select * from airport;


select * from city;

### Route wise flight analysis
select 
  f.Origin_Airport_ID,
  f.Dest_Airport_Id,
  a1.City_Name as Origin_City,
  a2.City_Name as Dest_City,
  sum(fm.Passengers) as Total_Passengers
from flight f
join flightmetrics fm ON f.Flight_ID = fm.Flight_ID
join Airport a1 on f.Origin_Airport_ID = a1.Airport_Id
join Airport a2 on f.Dest_Airport_Id = a2.Airport_Id
group by f.Origin_Airport_ID, f.Dest_Airport_Id
order by Total_Passengers Desc
limit 10;

# Total passenger served in the duration
select
  f.year,
  f.month,
  concat(round(sum(fm.Passengers)/1000000,2), ' Million') as Total_Passengers
from flight f
join flightmetrics fm on f.Flight_ID = fm.Flight_ID
group by f.year, f.month
order by  f.year, f.month;

## Average Passengers per Origin City
use flight_analysis;
select * from flight_metrics; 
select * from flight;
select * from airport;

Select
  f.Origin_Airport_ID,
  a.City_Name as Origin_City,
  count(f.Flight_ID) as Total_flight,
  sum(fm.Passengers) as Total_Passengers,
  round(avg(fm.Passengers),2) as Avg_Passengers_per_Flight
from flight f
join flightmetrics fm on f.Flight_ID = fm.Flight_Id
join Airport a on f.Origin_Airport_ID = a.Airport_Id
group by f.Origin_Airport_ID
order by Avg_Passengers_per_Flight desc
limit 7;


## Average Passengers per destination City
select
  f.Dest_Airport_Id,
  a.City_Name as Dest_City,
  count(f.Flight_ID) as Total_Flight,
  sum(fm.Passengers) as Total_Passengers,
  round(avg(fm.Passengers),2) as Avg_Passengers_per_Flight
from flight f
join flight_metrics fm on f.Flight_ID = fm.Flight_Id
join Airport a on f.Dest_Airport_Id = a.Airport_Id
group by f.Dest_Airport_Id
order by Avg_Passengers_per_Flight desc
limit 7;

use flight_analysis;

## Corelation Between Population and Air Traffic.

select * from city;
select * from all_city_pop;

## extracting city name from city table

update city
set CityName = substring_index(CityName, ',',1);

SET SQL_Safe_Updates = 0;

create table City_New
(select City_id,substring_index(CityName,',',1) as City_Name,State_ABR,
State_NM, Population
from city c
left join all_city_pop as a
on a.city_name = c.Cityname);

drop table city;
 
select *  from City_New;


### Analyse the relation between city population and airport traffic. 

## Cities as Origin

-- rename city_new table
alter table city_new rename city;

update airport
SET CITY_NAME = substring_index(CITY_NAME, ',',1);

select * from city;
select * from flightmetrics;
select * from Airport;
select * from flight;

select
  c.City_Name,
  c.Population,
  sum(fm.Passengers) AS Total_Passenger
from city c
join airport a on a.CITY_NAME = c.CITY_NAME
join flight f on f.ORIGIN_AIRPORT_ID = a.AIRPORT_ID
join flightmetrics fm on f.FLIGHT_ID = fm.FLIGHT_ID
group by c.city_name, c.Population
order by Total_Passenger DESC;

--  Passenger Population Ratio
select
  c.City_Name,
  c.Population,
  sum(fm.Passengers) AS Total_Passenger
from city c
join airport a on a.CITY_NAME = c.CITY_NAME
join flight f on f.ORIGIN_AIRPORT_ID = a.AIRPORT_ID
join flightmetrics fm on f.FLIGHT_ID = fm.FLIGHT_ID
group by c.city_name, c.Population
order by Total_Passenger DESC;

select
  c.City_Name,
  c.Population,
  sum(fm.Passengers) AS Total_Passenger,
  round(sum(fm.Passengers)/c.Population,2) as Pass_Pop_Ratio
from city c
join airport a on a.CITY_NAME = c.CITY_NAME
join flight f on f.ORIGIN_AIRPORT_ID = a.AIRPORT_ID
join flightmetrics fm on f.FLIGHT_ID = fm.FLIGHT_ID
group by c.city_name, c.Population
order by Pass_Pop_Ratio DESC;


## Cities as Destination
select
  c.City_Name,
  c.Population,
  sum(fm.Passengers) AS Total_Passenger
from city c
join airport a on a.CITY_NAME = c.CITY_NAME
join flight f on f.Dest_AIRPORT_ID = a.AIRPORT_ID
join flightmetrics fm on f.FLIGHT_ID = fm.FLIGHT_ID
group by c.city_name, c.Population
order by Total_Passenger DESC;

select
  c.City_Name,
  c.Population,
  sum(fm.Passengers) AS Total_Passenger,
  count(f.flight_id) as Total_Flight,
  round(sum(fm.Passengers)/c.Population,2) as Pass_Pop_Ratio
from city c
join airport a on a.CITY_NAME = c.CITY_NAME
join flight f on f.ORIGIN_AIRPORT_ID = a.AIRPORT_ID
join flightmetrics fm on f.FLIGHT_ID = fm.FLIGHT_ID
group by c.city_name, c.Population
order by Pass_Pop_Ratio DESC;









