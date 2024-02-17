

SPOOL C:\MidTermSpool\exam_output5.txt
set echo on

drop table mid_furniture;
drop table mid_home;
drop table mid_room;



/*
Create in this order

mid_room
mid_home
mid_furniture

*/

create table mid_room(
  room_name varchar2(50) constraint sys_mid_room_pk primary key,
  --owner_name varchar2(50) constraint sys_mid_room_fk
    --references mid_home(owner_name),
  wall_colour varchar2(50) not null
);

create table mid_home(
  owner_name varchar2(50) constraint sys_mid_home_pk primary key,
  room_name varchar2(50) constraint sys_mid_home_fk
    references mid_room(room_name),
  street varchar2(50) not null,
  city varchar2(50) not null,
  prov char(2) not null constraint sys_mid_home_prov_ck
    check(prov in ('AB','BC','SK')),
  postal_code char(6) not null
);




create table mid_furniture(
  furniture_name varchar2(50) constraint sys_mid_furniture_pk primary key,
  room_name varchar2(50) constraint sys_mid_furniture_fk
    references mid_room(room_name),
  size_height number(4,1) not null constraint sys_mid_furniture_size_height_ck
    check(size_height > 0 and size_height <= 9.99),
  size_depth number (4,1) not null constraint sys_mid_furniture_size_depth_ck
    check(size_depth > 0 and size_depth <= 9.99),
  size_length number(4,1) not null constraint sys_mid_furniture_size_length_ck
    check(size_length > 0 and size_length <= 9.99)
);


alter table mid_furniture
  add price number(8,2) constraint sys_mid_furniture_price_ck
    check(price > 0 and price <=99999.99);
alter table mid_furniture
  add purchase_date date not null;


spool off;










