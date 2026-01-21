### Acccess flight frequency and identify high-traffic corridors.
# To assess flight frequency and identify high-traffic corridors, we will:
# 1.Count how often each route (origin → destination) appears — that’s flight frequency.
# 2.Identify routes with the highest number of flights — these are high-traffic corridors.

Select * from airport;
select * from flight;
use flight_analysis;
select
  f.Origin_Airport_ID,
  f.Dest_Airport_Id,
  a1.City_Name as Orgin_City,
  a2.City_Name as Dest_City,
  count(*) as Total_Flight
from flight f
join airport a1 on f.Origin_Airport_ID = a1.Airport_Id
join airport a2 on f.Dest_Airport_Id = a2.Airport_Id
group by f.Origin_Airport_ID, f.Dest_Airport_Id
order by Total_Flight desc
limit 10;

## Los Angels is a part of The top 10 busiest air routes.