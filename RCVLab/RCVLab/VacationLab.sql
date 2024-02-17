--- VIEW ACTIVE TABLRES IN SCHEMA---
/* 
SELECT table_name FROM user_tables;
*/

---RESET SCHEMA---
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


/* CREATE TABLE IN ORDER AS LISTED FIRST

*/

---Parameters for txt---
SET PAGESIZE 0
SET TRIMSPOOL ON
SET LINESIZE 100
SET UNDERLINE OFF
SET FEEDBACK OFF
SET VERIFY OFF

SPOOL C:\RCVSpool\RCV_Vacation6.txt

set echo on 

alter table rcv_vacation_tour drop constraint sys_rcv_vacation_tour_fk;
alter table rcv_tour_destination drop constraint sys_rcv_tour_code_fk;
alter table rcv_tour_destination drop constraint sys_rcv_tour_dest_code_fk;
alter table rcv_customer drop constraint sys_rcv_customer_agent_id_fk;
alter table rcv_agent_training drop constraint sys_rcv_agent_training_agent_id_fk;
alter table rcv_agent_training  drop constraint sys_rcv_agent_training_code_fk;
alter table rcv_tour_customer drop constraint sys_rcv_tour_customer_tour_code_fk;
alter table rcv_tour_customer drop constraint sys_rcv_tour_customer_number_fk;




drop table rcv_agent_training;
drop table rcv_training;
drop table rcv_customer;
drop table rcv_tour_customer;
drop table rcv_tour_destination;
drop table rcv_destination;
drop table rcv_vacation_tour;
drop table rcv_rating;
drop table rcv_agent;

/* CREAT IN THIS ORDER NOW

rcv_agent
rcv_training
rcv_agent_training
rcv_rating
rcv_customer
rcv_vacation_tour
rcv_tour_customer
rcv_destination
rcv_tour_destination

*/

create table rcv_rating (
    rating_code char(1) constraint sys_rcv_rating_code_pk primary key, 
    rating_description varchar(50)
);
create table rcv_training (
    training_code number(1) constraint sys_rcv_training_number_pk primary key,
    training_description varchar(10) not null,
    durationHours number(2)
);
create table rcv_agent (
    agent_id number,
    first_name varchar2(10) not null,
    last_name varchar2(10) not null, 
    agent_level varchar2(5) not null, 
    yearsExperience number(2) not null,
    agent_speciality varchar2(2) not null, 
    constraint sys_rcv_agent_id_pk primary key (agent_id),
    constraint sys_rcv_agent_level_ck 
        check (agent_level in ('1','2','3','4')),
    constraint sys_rcv_agent_speciality_ck
        check (agent_speciality in ('CA', 'US', 'EU'))
);
create table rcv_destination (
    dest_code number constraint sys_rcv_destination_code_pk primary key,
    city varchar2(50) not null,
    dest_state char(2) constraint sys_rcv_destionation_dest_state_ck 
        check (dest_state in ('BC', 'AB', 'SK', 'MB', 'ON', 'QC', 'NB', 'NS', 'NL', 'NU', 'PE', 'YT')),
    country varchar2(50) not null, 
    dest_description varchar2(100) not null, 
    price number(10,2) not null
);
create table rcv_vacation_tour (
    tour_code number,
    tour_description varchar(20) not null,
    tour_region varchar(2) not null,
    rating_code char(1) not null,  
    constraint sys_rcv_vacation_tour_pk primary key(tour_code),
    constraint sys_rcv_vacation_tour_fk foreign key (rating_code)
        references rcv_rating(rating_code)
);
create table rcv_tour_destination (
    tour_code number,
    dest_code number, 
    order_num number,
    constraint sys_rcv_tour_pk primary key (tour_code, dest_code),
    constraint sys_rcv_tour_code_fk foreign key (tour_code)
        references rcv_vacation_tour(tour_code),
    constraint sys_rcv_tour_dest_code_fk foreign key (dest_code)
        references rcv_destination (dest_code)
);
create table rcv_customer (
    customer_number number constraint sys_rcv_customer_number_pk primary key,
    first_name varchar2(10) not null,
    last_name varchar2(10) not null, 
    customer_phone varchar2(12) not null,
    customer_street_address varchar2(20) not null, 
    customer_city varchar2(15) not null, 
    customer_province varchar2(2),
    agent_id number,
    constraint sys_rcv_customer_agent_id_fk foreign key (agent_id)
        references rcv_agent(agent_id)
);
create table rcv_agent_training (
    agent_id number,
    training_code number(1),
    date_completed date
);
  alter table rcv_agent_training
    add constraint sys_rcv_agent_training_pk primary key (agent_id, training_code);
  alter table rcv_agent_training
    add constraint sys_rcv_agent_training_agent_id_fk foreign key (agent_id)
        references rcv_agent (agent_id);
  alter table rcv_agent_training
    add constraint sys_rcv_agent_training_code_fk foreign key(training_code)
        references rcv_training(training_code);
create table rcv_tour_customer (
    tour_code number,
    customer_number number,
    state_date date,
    end_date date
);
  alter table rcv_tour_customer 
      add constraint sys_rcv_tour_customer_pk primary key (tour_code, customer_number);
  alter table rcv_tour_customer
      add constraint sys_rcv_tour_customer_tour_code_fk foreign key (tour_code)
          references rcv_vacation_tour(tour_code);
  alter table rcv_tour_customer
      add constraint sys_rcv_tour_customer_number_fk foreign key (customer_number)
          references rcv_customer(customer_number);







