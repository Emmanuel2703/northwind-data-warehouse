create database northwind 
-----------------------------------------------
use northwind
go
-----------------------------------------------
create table employee(
employee_id int not null primary key,
F_name varchar(100) not null,
L_name varchar(100) not null,
title varchar(100) null,
title_of_coutersy varchar(100) null,
birth_date date null,
hire_date date null,
street varchar(100) null,
city varchar(100) null,
country varchar(100) null,
postal_code varchar(100) null,
extension int null
)
--------------------------------------------
create table region(
region_id int not null primary key,
reg_description varchar(100) not null,
)
--------------------------------------------
create table territory(
territory_id int not null primary key,
terr_description varchar(100) null,
region_id int not null,
foreign key(region_id) references region(region_id)
)
-----------------------------------------------
create table work(
territory_id int not null,
employee_id int not null,
foreign key(territory_id) references territory(territory_id),
foreign key(employee_id) references employee(employee_id),
primary key(territory_id , employee_id)
)
-------------------------------------------------
create table shipper(
shipper_id int not null primary key,
phone varchar(100) null,
company_name varchar(100) null,
)
----------------------------------------------------
create table customer(
customer_id varchar(100) not null primary key,
phone varchar(100) not null,
country varchar(100) null,
city varchar(100) null,
street varchar(100) null,
postal_code varchar(100) null,
contact_title varchar(100) null,
contact_name varchar(100) null,
company_name varchar(100) null,
fax varchar(100) null,
)
----------------------------------------------------
create table orders(
order_id int not null primary key,
freight decimal(10,2) null,
order_date date null,
required_date date null,
shipped_date date null,
country varchar(100) null,
city varchar(100) null,
street varchar(100) null,
ship_region varchar(100) null,
ship_postal varchar(100) null,
employee_id int not null,
foreign key(employee_id) references employee(employee_id),
shipper_id int not null,
foreign key(shipper_id) references shipper(shipper_id),
customer_id varchar(100),
foreign key(customer_id) references customer(customer_id)
)
---------------------------------------------------------
create table category(
category_id int not null primary key,
category_name varchar(100) null,
description varchar(255) null
)
---------------------------------------------------------
create table supplier(
supplier_id int not null primary key,
company_name varchar(100) null,
phone varchar(20) null,
fax varchar(100) null,
contact_name varchar(100) null,
contact_title varchar(100) null,
region varchar(100) null,
country varchar(100) null,
city varchar(100) null,
street varchar(100) null,
postal_code varchar(100) null,
home_page varchar(255) null,
)
---------------------------------------------------------
create table products(
product_id int not null primary key,
recored_level int null,
quantity_per_unite varchar(100) null,
discount decimal(10,2) null,
product_name varchar(100) null,
unite_on_record int null,
unite_in_order int null,
unite_in_stock int null,
category_id int not null,
foreign key (category_id) references category(category_id),
supplier_id int not null,
foreign key (supplier_id) references supplier(supplier_id)
)
---------------------------------------------------------
create table order_details(
unite_price decimal(10,2) not null,
discount decimal (10,2) not null,
quantity int not null,
order_id int not null,
foreign key(order_id) references orders(order_id),
product_id int not null,
foreign key(product_id) references products(product_id),
primary key(product_id,order_id)
)
--------------------------------------------------------------
---create star schama----
create view DIM_product
as
select 
product_id,
recored_level,
quantity_per_unite,
discount,
product_name,
unite_on_record,
unite_in_order,
unite_in_stock,
C.category_id,
C.category_name,
C.description
from products as P Inner JOIN category as C
on C.category_id = P.category_id;
----------------------------------------------------------
create table DIM_Orders(
order_key int primary key identity(1,1),
order_id int,
freight decimal(10,2),
order_date date,
required_date date,
shipped_date date,
country varchar(100),
city varchar(100),
street varchar(100),
ship_region varchar(100),
ship_postal varchar(100),
employee_id int
)
insert into DIM_Orders(
order_id,
freight,
order_date,
required_date,
shipped_date,
country,
city,
street,
ship_region,
ship_postal,
employee_id
)
select
O.order_id,
O.freight,
O.order_date,
O.required_date,
O.shipped_date,
O.country,
O.city,
O.street,
O.ship_region,
O.ship_postal,
E.employee_id
from orders as O 
Inner join employee as E on E.employee_id = O.employee_id
------------------------------------------------------------
Create view DIM_employee
as
select 
E.employee_id,
E.F_name,
E.L_name,
E.title,
E.title_of_coutersy,
E.birth_date,
E.hire_date,
E.street,
E.city,
E.country,
E.postal_code,
E.extension
from employee as E 
---------------------------------------------------------
Create view DIM_customer 
as
Select
C.customer_id,
C.phone,
C.country,
C.city,
C.street,
C.postal_code,
C.contact_title,
C.contact_name,
C.company_name
from customer as C
-------------------------------------------------------------
create view DIM_region
as 
select
R.region_id,
R.reg_description,
T.territory_id,
T.terr_description
from region as R inner join territory as T on R.region_id = T.region_id
--------------------------------------------------------------------------
create view DIM_supplier
as 
select
supplier_id,
company_name,
phone,
fax,
contact_name,
contact_title,
region,
country,
city,
street,
postal_code,
home_page
from supplier 
----------------------------------------------------------------
create view DIM_shipper
as
select
shipper_id,
phone,
company_name
from shipper
-----------------------------------------------------------------
Create Table Dim_Date (
    Datekey Int Primary Key,
    [Date] Date Not Null,
    [Year] Int Not Null,
    [Quarter] Int Not Null,
    [Quartername] Varchar(2) Not Null,
    [Month] Int Not Null,
    [Monthname] Varchar(15) Not Null,
    [Day] Int Not Null,
    [Dayofweeknumber] Int Not Null,
    [Dayofweekname] Varchar(15) Not Null
);
GO
With Alldates AS (
    Select Try_Cast(Order_Date As Date) As Cleandate From Orders Where Order_Date Is Not Null
    Union All
    Select Try_Cast(Shipped_Date As Date) From Orders Where Shipped_Date Is Not Null
    Union All
    Select Try_Cast(Required_Date As Date) From Orders Where Required_Date Is Not Null
),
Daterange As (
    Select 
        Min(Cleandate) As Startdate,
        Max(Cleandate) As Enddate
    From Alldates
    Where Cleandate Is Not Null 
      And Year(Cleandate) Between 1900 And 2099
),
Datesequence AS (
    Select Startdate As [Date], Enddate
    From Daterange
    
    UNION ALL
    
    Select Dateadd(Day, 1, [Date]), Enddate
    From Datesequence
    Where [Date] < Enddate
)
Insert Into Dim_Date
Select 
    (YEAR([Date]) * 10000) + (MONTH([Date]) * 100) + DAY([Date]) AS Datekey,
    [Date],
    YEAR([Date]) AS [Year],
    Datepart(Quarter, [Date]) As [Quarter],
    'Q' + Cast(Datepart(Quarter, [Date]) As Varchar(1)) As [Quartername],
    Month([Date]) As [Month],
    Datename(Month, [Date]) As [Monthname],
    Day([Date]) As [Day],
    Datepart(Weekday, [Date]) As [Dayofweeknumber],
    Datename(Weekday, [Date]) As [Dayofweekname]
From Datesequence
WHERE [Date] IS NOT NULL 
Option (Maxrecursion 0);
Go
----------------------------------------------------------------------------
create table fact_sales(
employee_id int not null,
customer_id int not null,
region_id int not null,
territory_id int not null,
order_id int not null,
shipper_id int not null,
supplier_id int not null,
category_id int not null,
product_id int not null,
unite_price decimal(10,2) not null,
discount decimal (10,2) not null,
quantity int not null,
constraint PK_fact_sales primary key(employee_id,customer_id)
);
----------------------------------------------------------------------
ALTER TABLE Fact_Sales 
ADD order_date_key INT;
GO
----------------------------------------------------------------------
alter table fact_sales 
add order_key int
go
----------------------------------------------------------------------
---convert view to table---
SELECT * 
INTO DIM_Product_table 
FROM DIM_Product;
alter table DIM_Product_table 
add constraint pk_DIM_Product_table primary key(product_id)

select *
into DIM_customer_table
from  DIM_customer
alter table DIM_customer_table
add constraint pk_DIM_customer_table primary key(customer_id)

select *
into DIM_employee_table
from DIM_employee
alter table DIM_employee_table
add constraint pk_DIM_employee_table primary key(employee_id)

select *
into DIM_region_table
from DIM_region
alter table DIM_region_table
add constraint pk_DIM_region_table primary key(territory_id)

select *
into DIM_shipper_table
from DIM_shipper
alter table DIM_shipper_table
add constraint pk_DIM_shipper_table primary key(shipper_id)

select *
into DIM_supplier_table
from DIM_supplier
alter table DIM_supplier_table
add constraint pk_DIM_supplier_table primary key(supplier_id)
