
--Create
@ "C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Week 11\ReallyCheapVacationsDB\reallycheapvacationcreatetable.sql"

--Populate
@ "C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Week 11\ReallyCheapVacationsDB\reallycheapvacationspopulate.sql"

spool C:\spool\lab_week11_4.txt

/*
This SQL code retrieves information about a specific customer named Sheldon Cooper and the tours and destinations he has booked. 
The code uses a subquery to join several tables (rcv_customer, rcv_tour_customer, rcv_vacation_tour, rcv_tour_destination, 
and rcv_destination) to retrieve the necessary information.

*/

set linesize 200; 

SQL> select
  2    case
  3      when row_num = 1 then first_name
  4      else ''
  5    end as "First Name",
  6    case
  7      when row_num = 1 THEN last_name
  8      else ''
  9    end as "Last Name",
 10    tour_description as "Tour Description",
 11    order# as "Order#",
 12    dest_description as "Destination Description"
 13  from (
 14    select
 15      c.last_name,
 16      c.first_name,
 17      v.tour_description,
 18      d.dest_description,
 19      t.order#,
 20      ROW_NUMBER() over (order by v.tour_description, t.order#) as row_num
 21    from rcv_customer c
 22    join rcv_tour_customer tc on c.customer_number = tc.customer_number
 23    join rcv_vacation_tour v on tc.tour_code = v.tour_code
 24    join rcv_tour_destination t on v.tour_code = t.tour_code
 25    join rcv_destination d on t.dest_code = d.dest_code
 26    where c.last_name = 'Cooper' and c.first_name = 'Sheldon'
 27    order by v.tour_description, t.order#
 28  ) subquery;


 --Number 1.
 /*
 This query retrieves vacation tour information for a customer named Sheldon Cooper. It uses the ROW_NUMBER function 
 to assign a row number to each tour, and selects only the first tour for each customer. It then sorts the result by 
 tour description and order number.
 */    
COLUMN "Tour Description" FORMAT A30

select
  case
    when row_num = 1 then first_name
    else ''
  end as "First Name",
  case
    when row_num = 1 then last_name
    else ''
  end as "Last Name",
  TRIM(tour_description) as "Tour Description",
  order# as "Order#",
  dest_description as "Destination Description"
from (
  select
    c.first_name,
    c.last_name,
    v.tour_description,
    t.order#,
    d.dest_description,
    ROW_NUMBER() over (partition by c.first_name, c.last_name order by v.tour_description, t.order#) as row_num
  from rcv_customer c
  join rcv_tour_customer using (customer_number)
  join rcv_vacation_tour v using (tour_code)
  join rcv_tour_destination t using (tour_code)
  join rcv_destination d using (dest_code)
  where c.last_name = 'Cooper' and c.first_name = 'Sheldon'
) subquery
order by "Tour Description", "Order#";


/*
This SQL query selects data from several tables and returns the first and last name of a specific customer, 
the tour description, order number, and destination description. 

*/

--Number 2. 
COLUMN "Tour Description" FORMAT A30

select
  case
    when row_num = 1 then first_name
    else ''
  end as "First Name",
  case
    when row_num = 1 then last_name
    else ''
  end as "Last Name",
  TRIM(tour_description) as "Tour Description",
  order# as "Order#",
  dest_description as "Destination Description"
from (
  select
    c.first_name,
    c.last_name,
    v.tour_description,
    d.dest_description,
    t.order#,
    ROW_NUMBER() over (order by v.tour_description, t.order#) as row_num
  from rcv_customer c, rcv_tour_customer tc, rcv_vacation_tour v, rcv_tour_destination t, rcv_destination d
  where c.customer_number = tc.customer_number
    and tc.tour_code = v.tour_code
    and v.tour_code = t.tour_code
    and t.dest_code = d.dest_code
    and c.last_name = 'Cooper' and c.first_name = 'Sheldon'
) subquery
order by "Tour Description", "Order#";




--Number 3. 

/*
This query retrieves the names of customers who have visited a destination in Canada. It uses LEFT JOIN to join 
the destination, tour destination, vacation tour, tour customer, and customer tables. It selects only the 
customers who have visited Canada and sorts the result by destination description, first name, and last name.
*/
select distinct
  d.dest_description as "Destination",
  c.first_name as "First Name",
  c.last_name as "Last Name"
from rcv_destination d
left join rcv_tour_destination t on d.dest_code = t.dest_code
left join rcv_vacation_tour v on t.tour_code = v.tour_code
left join rcv_tour_customer tc on v.tour_code = tc.tour_code
left join rcv_customer c on tc.customer_number = c.customer_number
where d.country = 'Canada'
order by d.dest_description, c.first_name, c.last_name;


--Number 4. 
/*
This query retrieves agent training information. It uses the LAG function to compare the values of the current 
row with the previous row and selects only the first occurrence of each agent's name. It then sorts the result 
by first name, last name, training description, and date completed.

*/

select
  case
    when first_name = LAG(first_name) over (order by first_name, last_name, training_description, date_completed) then ''
    else first_name
  end as "First Name",
  case
    when last_name = LAG(last_name) over (order by first_name, last_name, training_description, date_completed) then ''
    else last_name
  end as "Last Name",
  training_description as "Training Description",
  TO_CHAR(date_completed, 'DD-MON-YY') as "Date Completed"
from (
  select
    a.first_name,
    a.last_name,
    r.training_description,
    t.date_completed
  from rcv_agent a
  natural join rcv_agent_training t
  natural join rcv_training r
) subquery
order by first_name, last_name, training_description, date_completed;