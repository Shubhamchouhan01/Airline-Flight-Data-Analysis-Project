###  Route wise Flight analysis
select f.airport_id ,f.dest_airport_id ,a1.city_name as original_city ,a2.city_name as dest_city ,
sum(fm.passangers) as Total_passangers
from flight f
join flightmetrics fm 
on f.flight_id =fm.flight_id
join airport a1 
on a1.airport_id =f.airport_id
join airport a2
on a2.airport_id =f.dest_airport_id
group by f.airport_id ,f.dest_airport_id
order by total_passangers desc;

## Total passengers Served in the duration .
select
f.year,
f.month,
round(sum(fm.passangers)/1000000,2) as total_passangers
from flight f
join flightmetrics fm 
on f.flight_id = fm.flight_id
group by f.year ,f.month 
order by f.year ,f.month ;
select * from flight;

## Total Flights per year 
select year ,count(*) as total_flights
from flight 
group by year 
order by year ;

##total passengers per year 
select f.year ,sum(fm.passangers) as total_passengers
from flight f 
join flightmetrics fm 
on fm.flight_id =f.flight_id
group by f.year;

## Determine average passanger per flight of various routes and airports.
## avrage passenger per origin city
select f.airport_id ,a.city_name as origin_city,
count(f.flight_id) as total_flights,
sum(fm.passangers) as total_passangers,
round(avg(fm.passangers),2) as avg_passanger_per_flight
from flight f
join flightmetrics fm 
on fm.flight_id =f.flight_id
join airport a 
on a.airport_id = f.airport_id
group by f.airport_id 
order by avg_passanger_per_flight desc
limit 7;

## avrage passenger per destination city
select f.dest_airport_id ,a.city_name as destination_city,
count(f.flight_id) as total_flights,
sum(fm.passangers) as total_passangers,
round(avg(fm.passangers),2) as avg_passanger_per_flight
from flight f
join flightmetrics fm 
on fm.flight_id =f.flight_id
join airport a 
on a.airport_id = f.dest_airport_id
group by f.dest_airport_id 
order by avg_passanger_per_flight desc
limit 7;

## Top 10 busiest origin airport
select a.city_name ,
count(f.flight_id) as total_flights from flight f  
join airport a on a.airport_id =f.airport_id
group by a.city_name 
order by total_flights desc
limit 10;

## asses flight frequency and identify high - traffic corridors
## asses flight frequency and identify high - traffic corridors we will :
# 1.count how often each route (origin -> destination) appers - thats flight frequency.
# 2. identify routes with the highest number of flights - these are hight - traffic corridors .

select f.airport_id, f.dest_airport_id ,
a1.city_name as origin_city,
a2.city_name as destination_city ,
count(*) as flight_count from flight f
join airport a1 
on a1.airport_id =f.airport_id
join airport a2
on a2.airport_id =f.dest_airport_id
group by f.airport_id ,f.dest_airport_id 
order by flight_count desc
limit 10;
## los angels is a part of the top 10  busiest air routes.

## compare passengers numbers across origin cities to identify top -performing airports.
## top pessengers and total no. of flights
## origin
select a.city_name as origin_City ,
sum(fm.passangers) as total_passengers,
count(f.flight_id) as total_flights
from flight f
join flightmetrics fm on f.flight_id =fm.flight_id
join airport a on a.airport_id =f.airport_id
group by a.city_name
order by total_passengers desc;

## destination
select a.city_name as destination_City ,
sum(fm.passangers) as total_passengers,
count(f.flight_id) as total_flights
from flight f
join flightmetrics fm on f.flight_id =fm.flight_id
join airport a on a.airport_id =f.dest_airport_id
group by a.city_name
order by total_passengers desc;

## analysis the relation between city population and airport traffic.
select * from city;
select c.city_name ,c.population ,
sum(fm.passengers) as total_passengers
from city c 
join airport a on a.city_name = c.city_name
join flight f on f.airport_id = a.airport_id
join flightmetrics fm on fm.flight_id = f.flight_id
group by c.city_name  ,c.population 
order by total_passengers desc;

## top destination airports by passengers
SELECT
    a.city_name,
    SUM(fm.passangers) AS total_passengers
FROM flight f
JOIN flightmetrics fm ON fm.flight_id = f.flight_id
JOIN airport a ON a.airport_id = f.dest_airport_id
GROUP BY a.city_name
ORDER BY total_passengers DESC
LIMIT 10;

## creating views
create view  top_pess_total_flights as(select a.city_name as origin_City ,
sum(fm.passangers) as total_passengers,
count(f.flight_id) as total_flights
from flight f
join flightmetrics fm on f.flight_id =fm.flight_id
join airport a on a.airport_id =f.airport_id
group by a.city_name
order by total_passengers desc);

select * from top_pess_total_flights;


## stored procedures 
delimiter //
create procedure traffic() 
begin
select a.city_name as origin_City ,
sum(fm.passangers) as total_passengers,
count(f.flight_id) as total_flights
from flight f
join flightmetrics fm on f.flight_id =fm.flight_id
join airport a on a.airport_id =f.airport_id
group by a.city_name
order by total_flights desc;
end //

create procedure state_level_traffic(in state varchar(30))
begin
select a.city_name as origin_City ,
sum(fm.passangers) as total_passengers,
count(f.flight_id) as total_flights
from flight f
join flightmetrics fm on f.flight_id =fm.flight_id
join airport a on a.airport_id =f.airport_id
where a.state_nm = state
group by a.city_name
order by total_flights desc;
end //
delimiter ;
call state_level_traffic("Alaska");