rem Lab Unit 10-11 Simple SELECT and Sorting 
set echo on
set linesize 200
set pagesize 66
spool C:\Users\jbsom\Documents\CPRG-250_Activity\lab_simple_select/unit10-11LabOutput.ltxt

rem Q1 - basic select columns with headers

rem insert solution here!
select first_name, last_name
FROM rcv_agent
WHERE agent_level IN ('III', 'IV')
    AND agent_speciality IN ('EU', 'US')
order by last_name;
rem Q2 

rem insert solution here!
SELECT tour_description
FROM rcv_vacation_tour
WHERE (tour_description LIKE '%Paris%')
    AND (tour_region IN ('EU', 'CA'))
ORDER BY tour_description;
rem Q3 

rem insert solution here!
SELECT country, dest_description
FROM rcv_destination
WHERE country IN ('Canada', 'United States')
ORDER BY country, dest_description;


spool off

