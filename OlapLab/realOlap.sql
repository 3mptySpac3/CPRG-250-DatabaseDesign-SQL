---Reset
/*
SET SERVEROUTPUT ON;
DECLARE
  l_table_name VARCHAR2(50);
BEGIN
  FOR cur IN (SELECT table_name FROM user_tables)
  LOOP
    l_table_name := cur.table_name;
    EXECUTE IMMEDIATE ('DROP TABLE ' || l_table_name || ' CASCADE CONSTRAINTS');
    DBMS_OUTPUT.PUT_LINE('Dropped table: ' || l_table_name);
  END LOOP;
END;
/
*/


/*
1. For each vacation tour show the number of destinations and the total price for all the destinations.
 Only include vacation tours that have more than 3 destinations.

2. What is the total value of all the vacation tours taken by all customers?

*/

---Create 
@"C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Week 12\ReallyCheapVacationsDB\reallycheapvacationcreatetable.sql"
---Populate
@"C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Week 12\ReallyCheapVacationsDB\reallycheapvacationspopulate.sql"


Spool C:\spool\Olap3.txt

set linesize 150;



column "# of destinations" format 999
column "Total" format 999,999.99
select vt.tour_description as "Tour", count(td.dest_code) as "# of Destinations", sum(d.price) as "Total"
from rcv_vacation_tour vt, rcv_tour_destination td, rcv_destination d
where vt.tour_code = td.tour_code
and td.dest_code = d.dest_code
group by vt.tour_code, vt.tour_description
having count(td.dest_code) > 3
order by vt.tour_code;
clear columns

select sum(d.price) as "Total For all Customers"
from rcv_tour_customer tc, rcv_tour_destination td, rcv_destination d
where tc.tour_code = td.tour_code
and td.dest_code = d.dest_code;

Commit;

Spool off;