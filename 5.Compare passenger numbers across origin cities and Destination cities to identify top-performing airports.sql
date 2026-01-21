### Compare passenger numbers across origin cities to identify top-performing airports.
## Total Passengers and Total No. of Flights

select * from flight;
select * from flight_metrics;
select * from airport;

select
  a.City_Name as Origin_City,
  sum(fm.Passengers) as Total_Passengers,
  count(f.Flight_ID)  as Total_Flight
from flight f
join flight_metrics fm on f.Flight_ID = fm.Flight_Id
join airport a on f.Origin_Airport_ID = a.airport_id
group by a.City_Name
order by Total_Flight desc;

## Destination city
select
  a.City_Name as Dest_City,
  sum(fm.Passengers) as Total_Passsengers,
  count(f.Flight_ID) as Total_Flight
from flight f
join flight_metrics fm on f.Flight_ID = fm.Flight_Id
join airport a on f.Dest_Airport_Id = a.Airport_Id
group by a.City_Name
order by Total_Flight desc
limit 10;