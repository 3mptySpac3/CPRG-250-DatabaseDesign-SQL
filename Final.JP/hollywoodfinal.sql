-- Create
@ "C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Final Exam\Database for Final\Database for Final\hollywoodnorthcreatetables.sql"
-- populate
@ "C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Final Exam\Database for Final\Database for Final\populatehollywoodnorth.sql"


Spool C:\spool\FinalExamSpool.txt

--Solution for Question 1

set echo off;
set feedback off;
set LINESIZE 175;
set pagesize 30;

column "Entertainer ID" format 9
column "Client ID" format 9
column "Date" format 99-99-99
column "Client Fee" format 99999
select g.entertainerID as "Entertainer ID", g.clientID as "Client ID", g.startDate as "Date", g.clientFee as "Client Fee"
from hn_entertainerGig g
inner join hn_entertainer e on g.entertainerID = e.entertainerID
where g.startDate between TO_DATE('2021-05-01', 'YYYY-MM-DD') and TO_DATE('2021-05-31', 'YYYY-MM-DD')
order by g.startDate desc;



-- Solution for Question 2

set echo off;
set feedback off;
set LINESIZE 175;
set pagesize 30;


column "Client Name" format a20
column "Start Date" format 99-99-99
column "Client Fee" format 99999
column "Stage Name" format a20
column "Event Type" format a30
select c.firstName || ' ' || c.lastName as "Client Name", g.startDate as "Start Date", g.clientFee as "Client Fee", e.stageName as "Stage Name", e.eventType as "Event Type"
from hn_client c
inner join hn_entertainerGig g on c.clientID = g.clientID
inner join hn_entertainer e on g.entertainerID = e.entertainerID
order by c.lastName, g.startDate;


-- Solution for Question 3

set echo off;
set feedback off;
set LINESIZE 175;
set pagesize 30;

column "Client First" format a20
column "Client Last" format a20
column "Stage Name" format a20
column "Event Date" format 99-99-99
select c.firstName as "Client First", c.lastName as "Client Last", e.stageName as "Stage Name", g.startDate as "Event Date"
from hn_client c
inner join hn_entertainerGig g on c.clientID = g.clientID
inner join hn_entertainer e on g.entertainerID = e.entertainerID
order by c.lastName, g.startDate;




-- Solution for Question 4

set echo off;
set feedback off;
set LINESIZE 175;
set pagesize 30;

column "Total" format $99,999.99
column "Most Expensive" format $99,999.99
column "Average Price" format $99,999.99
column "Number" format 9
select SUM(g.clientFee) as "Total", MAX(g.clientFee) as "Most Expensive", AVG(g.clientFee) as "Average Price", COUNT(g.entertainerID) as "Number"
from hn_entertainerGig g
inner join hn_entertainer e on g.entertainerID = e.entertainerID;

-- Solution for Question 5


set echo off;
set feedback off;
set LINESIZE 175;
set pagesize 30;

column "Stage Name" format a20
column "Client ID" format 9
column "Start Date" format a20
column "Entertainer Fee" format 99999
select e.stageName as "Stage Name", g.clientID as "Client ID", g.startDate as "Start Date", g.clientFee as "Entertainer Fee"
from hn_entertainerGig g
inner join hn_entertainer e on g.entertainerID = e.entertainerID
where g.clientFee > (select AVG(clientFee) from hn_entertainerGig);


Spool off











