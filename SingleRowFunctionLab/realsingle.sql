
---Create 
@"C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Week 12\ReallyCheapVacationsDB\reallycheapvacationcreatetable.sql"
---Populate
@"C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Week 12\ReallyCheapVacationsDB\reallycheapvacationspopulate.sql"


Spool C:\spool\RealSingle1.txt

set echo on;
set linesize 150;

--Q1

column "Destination Description" format a30
column "Start Date" format a10
column "Desc" format a20
column "Price" format 999.99
column "Duration" format a10
break on 'Desc' on 'start date' on 'Duration'
SELECT vt.tour_description AS "Desc", tc.start_date AS "Start Date", (tc.end_date - tc.start_date) || ' days' AS "Duration", td.order# ,SUBSTR(d.dest_description,1 ,15) AS "Destination Description", d.price AS "Price" 
FROM rcv_tour_customer tc, rcv_vacation_tour vt, rcv_tour_destination td, rcv_destination d
WHERE tc.tour_code = vt.tour_code
AND tc.tour_code = td.tour_code
AND td.dest_code = d.dest_code
AND tc.customer_number = 3
ORDER BY vt.tour_description, tc.start_date, td.order#;
clear columns


set linesize 150;

--Q2

column "Tour Cost" format a20
column "Destination Description" format a5
column "Country" format a20
column "City" format a20
select d.dest_description, d.country, d.city,
case
when d.price < 50 then '$'
when d.price < 100 then '$$'
when d.price < 200 then '$$$'
when d.price < 500 then '$$$$'
when d.price > 500 then '$$$$$'
end as "Tour Cost"
from rcv_destination d
where d.country != 'Canada'
and d.country != 'United States'
order by d.country, d.city, d.price;
clear columns

set linesize 150;

--Q3

column "Country" format a20
column "State" format a20
column "Destination Description" format a50
SELECT 
    d.dest_description,
    CASE
        WHEN d.country = 'United States' THEN 'USA'
        ELSE d.country
    END AS "Country",
    CASE
        WHEN d.state IS NULL THEN 'NA'
        ELSE d.state
    END AS "State"
FROM 
    rcv_destination d
WHERE 
    INSTR(d.dest_description, 'Cook') > 0
    OR INSTR(d.dest_description, 'Wine') > 0
    OR INSTR(d.dest_description, 'Dinner') > 0
ORDER BY 
    d.dest_description;
clear columns

commit;

spool off;

