create database flight_analysis;
use flight_analysis ;
select * from airport_project_data;
alter table airport_project_data
rename to meta_Data;

select * from meta_data;

## spliting meta_data into smaller data frames
## airline ,airport ,flights ,route ,Passengers and city. 

## airline table
create table airline (
airline_id int primary  key ,
unique_carrier varchar(10),
unique_carrier_name varchar(100) ,
unique_carrier_entity varchar(10) 
);

## ariport table
create table airport (
airport_id int primary key ,
airport_seo_id int,
city_market_id int ,
airport_code varchar(10),
city_name varchar(100),
state_abr char(2),
state_fips int ,
state_nm varchar(100),
wac int 
);

##flight  table
create table flight (
flight_id int auto_increment primary key ,
airline_id int ,
airport_id int ,
dest_airport_id int ,
distance float ,
distance_group int ,
year int ,
quarter  int ,
month int ,
class char(1) ,
foreign key (airport_id) references airport(airport_id) ,
foreign key (airline_id) references airline(airline_id) ,
foreign key (dest_airport_id) references airport (airport_id)
);

## flightmetrics table
create table flightmetrics(
flight_id int ,
passangers float ,
freight float ,
mail float ,
foreign key  (flight_id) references flight(flight_id)
);
alter table flightmetrics
MODIFY freight varchar(100);



## city table
create table city (
city_id int auto_increment primary key ,
city_name varchar(100),
state_abr char(2) ,
unique (city_name ,state_abr));

alter table city
add column state_nm varchar (100);
select * from city ;

## insterting data in the tables with we have created
# inserting into airline
insert ignore into airline (airline_id ,unique_carrier ,unique_carrier_name ,unique_carrier_entity)
select distinct 
airline_id ,
unique_carrier ,
unique_carrier_name ,
unique_carrier_entity
from meta_data 
where airline_id is not null ;

select * from airline;

select count(distinct airline_id) from airline ;

# inserting into airport
insert into airport (airport_id ,airport_seo_id ,city_market_id ,airport_code ,city_name ,state_abr ,state_fips ,state_nm ,wac )
select  distinct
origin_airport_id ,
origin_airport_seq_id ,
origin_city_market_id ,
origin ,
origin_city_name ,
origin_state_abr,
origin_state_fips,
origin_state_nm,
origin_wac
from meta_data ;
select * from airport ;

 # dense airport id
 insert into airport (airport_id ,airport_seo_id ,city_market_id ,airport_code ,city_name ,state_abr ,state_fips ,state_nm ,wac )
select  distinct
dest_airport_id ,
dest_airport_seq_id ,
dest_city_market_id ,
dest,
dest_city_name ,
dest_state_abr,
dest_state_fips,
dest_state_nm,
dest_wac
from meta_data 
where dest_airport_id not in(
select airport_id from airport
);
select * from airport ;

## flight 
insert into flight (airline_id ,airport_id ,dest_airport_id ,distance ,
                   distance_group ,year ,quarter ,month ,class)
select 
airline_id ,
origin_airport_id ,
dest_airport_id ,
distance ,
distance_group ,
year ,
quarter ,
month ,
class 
from meta_data ;		
select * from flight;

## fligtmertices
INSERT INTO FlightMetrics (
    FLIGHT_ID,passangers, FREIGHT, MAIL
)
SELECT
    f.FLIGHT_ID,
    m.PASSENGERS,
    m.FREIGHT,
    m.MAIL
FROM Meta_Data m
JOIN Flight f
  ON f.AIRLINE_ID = m.AIRLINE_ID
 AND f.AIRPORT_ID = m.ORIGIN_AIRPORT_ID
 AND f.DEST_AIRPORT_ID = m.DEST_AIRPORT_ID
 AND f.YEAR = m.YEAR
 AND f.MONTH = m.MONTH
 AND f.QUARTER = m.QUARTER
 AND f.DISTANCE = m.DISTANCE;
 select * from flightmetrics;
 
 DESC Meta_Data;
DESC FlightMetrics;

select * from flight;

## city 
INSERT INTO City (City_Name, STATE_ABR, State_NM)
SELECT DISTINCT
    CITY_NAME,
    STATE_ABR,
    STATE_NM
FROM Airport;

select * from city;	