
-- ---Create 
-- @"C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Week 12\ReallyCheapVacationsDB\reallycheapvacationcreatetable.sql"
-- ---Populate
-- @"C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Week 12\ReallyCheapVacationsDB\reallycheapvacationspopulate.sql"


@"C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Week 13\Subway\subway.sql"

Spool C:\spool\subway1.txt

set echo on
set pagesize 40;
set linesize 200;

--QUESTION 1'S

--1a.	What is the value of each vacation tour? -

column "Tour Code" format a10
column "Price" format $9,999.99
select vt.tour_code, sum(d.price) as "Price"
from rcv_vacation_tour vt, rcv_tour_destination td, rcv_destination d
where vt.tour_code = td.tour_code
and td.dest_code = d.dest_code
group by vt.tour_code
order by vt.tour_code, "Price";
clear columns


--1b. What is the value of the most expensive tour? 

set pagesize 40;
set linesize 200;

column "Price" format $9,999.99
select max(price) as "Price"
from (select sum(d.price) as price
from rcv_vacation_tour vt, rcv_tour_destination td, rcv_destination d
where vt.tour_code = td.tour_code
and td.dest_code = d.dest_code
group by vt.tour_code);
clear columns

--1. What is the most expensive tour (based on vacation_tours)?

set pagesize 40;
set linesize 200;

column "Tour Description" format a30
column "Price" format $9,999.99
select vt.tour_description, sum(d.price) as "Price"
from rcv_vacation_tour vt, rcv_tour_destination td, rcv_destination d
where vt.tour_code = td.tour_code
and td.dest_code = d.dest_code
group by vt.tour_code, vt.tour_description
having sum(d.price) = (
select max(total_price)
from (select sum(d.price) as total_price
from rcv_vacation_tour vt, rcv_tour_destination td, rcv_destination d
where vt.tour_code = td.tour_code
and td.dest_code = d.dest_code
group by vt.tour_code))
order by vt.tour_description, "Price" desc;
clear columns

--QUESTION 2'S

--2a. What are the prices of all the Canadian tours (tour_region = CA). Tour_Description and Price only. 

set pagesize 40;
set linesize 200;

column "Tour Description" format a30
column "Price" format $9,999.99
select vt.tour_description, sum(d.price) as "Price"
from rcv_vacation_tour vt, rcv_tour_destination td, rcv_destination d
where vt.tour_code = td.tour_code
and td.dest_code = d.dest_code
and vt.tour_region = 'CA'
group by vt.tour_code, vt.tour_description
order by vt.tour_description, "Price" desc;
clear columns




-- testing What are the prices of all the European tours (tour_region = EU). Tour_Description and Price only.

set pagesize 40;
set linesize 200;

column "Tour Description" format a30
column "Price" format $9,999.99
select vt.tour_description, sum(d.price) as "Price"
from rcv_vacation_tour vt, rcv_tour_destination td, rcv_destination d
where vt.tour_code = td.tour_code
and td.dest_code = d.dest_code
and vt.tour_region = 'EU'
group by vt.tour_code, vt.tour_description
order by vt.tour_description, "Price" desc;
clear columns




--2. Which tours in Europe (tour_region is EU) are more expensive than any Canadian tour (tour_region is CA)?

set pagesize 40;
set linesize 200;

COLUMN "Tour Description" FORMAT A20
COLUMN "Price" FORMAT 999999.99
select vt.tour_description, SUM(d.price) AS "Price"
from rcv_vacation_tour vt
join rcv_tour_destination td ON vt.tour_code = td.tour_code
join rcv_destination d ON td.dest_code = d.dest_code
where vt.tour_region = 'EU'
group by vt.tour_description, vt.tour_region
having SUM(d.price) > (
select MIN(total_price)
from (select vt2.tour_code, SUM(d2.price) as total_price
from rcv_vacation_tour vt2
join rcv_tour_destination td2 ON vt2.tour_code = td2.tour_code
join rcv_destination d2 ON td2.dest_code = d2.dest_code
where vt2.tour_region = 'CA'
group by vt2.tour_code
    )
)
order by SUM(d.price);
clear columns

--QUESTION 3'S

-- 3a. Construct a table with the average price. Include that table in the FROM clause of your final solution.

set pagesize 40;
set linesize 200;

column "Average" format $9,999.99
select avg(price) as "Average"
from rcv_destination;
clear columns


--3. Show all dest_description whose price is less than tour destination average. 
--Display the dest_description only.

set pagesize 40;
set linesize 200;

column "Destination Description" format a30
select d.dest_description
from rcv_destination d
where d.price < (
select avg(price)
from rcv_destination);
clear columns



--QUESTION 4'S

--4a. Make a list of all vacation tours for Ethan Hunt's customers.

set pagesize 40;
set linesize 200;

column "Tour Code" format 999
select vt.tour_code
from rcv_vacation_tour vt
where vt.tour_code in (select vt.tour_code from rcv_vacation_tour vt where vt.tour_code in (1, 4, 5))
order by vt.tour_code;




--4. Which customers have taken the same vacation tours as Ethan Hunt's customers? 
--Do not include Ethan's Hunt's customers in the list.

set pagesize 40;
set linesize 200;

column "First Name" format a20
column "Last Name" format a20
select distinct c.first_name, c.last_name
from rcv_customer c, rcv_vacation_tour vt, rcv_tour_customer tc
where c.customer_number = tc.customer_number
and vt.tour_code in (select vt.tour_code from rcv_vacation_tour vt where vt.tour_code in (1, 4, 5))
and c.agent_id != 1
order by c.first_name, c.last_name;
clear columns

Commit;

spool off;

































































































