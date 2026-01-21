create database flight_analysis;
use flight_analysis;
select * from airport_data;

-- rename table
rename table airport_data to meta_data;


-- Create 5 tables Airline, Airport, Flight, Flight Metrics and City

create table Airline
(
Airline_Id int primary key,
Unique_Carrier varchar(10),
Unique_Carrier_Name varchar(100),
Unique_Carrier_Entity varchar(10)
);

create table Airport(
Airport_Id int primary key,
Airport_Seq_Id int,
City_market_Id int,
Airport_Code varchar(10),
City_Name varchar(100),
State_ABR char(10),
State_FIPS int,
State_NM varchar(100),
WAC int
);

create table Flight(
Flight_ID int Auto_Increment Primary key,
Airline_ID int,
Origin_Airport_ID int,
Dest_Airport_Id int,
Distance float,
Distance_Group int,
Year int,
Quarter int,
Month int,
Class char(2),
Foreign Key (Airline_Id) references Airline(Airline_Id),
foreign key (Origin_Airport_Id) references Airport(Airport_Id),
foreign key (Dest_Airport_Id) references Airport(Airport_Id)
);


Create table Flight_Metrics(
Flight_Id int,
Passengers float,
Freight float,
Mail float,
foreign key (Flight_Id) references Flight(Flight_ID)
);

create table City(
City_Id int auto_increment primary key,
City_Name Varchar(100),
State_ABR char(10),
unique (City_Name, State_ABR)
);