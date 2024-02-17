--- VIEW ACTIVE TABLRES IN SCHEMA---
/* 
SELECT owner, table_name FROM all_tables;

*/

---RESET SCHEMA---
/*
-- Disable foreign key constraints
SET SERVEROUTPUT ON;
DECLARE
  l_sql VARCHAR2(2000);
BEGIN
  FOR r IN (SELECT table_name FROM user_tables) LOOP
    l_sql := 'ALTER TABLE ' || r.table_name || ' DISABLE CONSTRAINT ALL';
    EXECUTE IMMEDIATE l_sql;
  END LOOP;
END;
/

-- Delete all tables
BEGIN
  FOR r IN (SELECT table_name FROM user_tables) LOOP
    EXECUTE IMMEDIATE 'DROP TABLE ' || r.table_name || ' CASCADE CONSTRAINTS';
  END LOOP;
END;
/


*/

/*CREATE THE TABLE IN THIS ORDER

tmb_category
tmb_supplier
tmb_tax_rate
tmb_shipping_rate
tmb_customers
tmb_orders
tmb_products
tmb_product_supplier
tmb_order_items
tmb_reviews

*/



---Parameters for txt---
SET PAGESIZE 100
SET LINESIZE 200


SPOOL C:\ProjectD4\Valid1.txt --- Location of output file---


---ALTER IN THIS ORDER---
alter table tmb_order_items drop constraint sys_tmb_order_item_product_number_fk;
alter table tmb_order_items drop constraint sys_tmb_order_item_order_number_fk;
alter table tmb_reviews drop constraint sys_tmb_reviews_fk;
alter table tmb_orders drop constraint sys_tmb_orders_customer_fk;
alter table tmb_orders drop constraint sys_tmb_orders_fk;
alter table tmb_orders drop constraint sys_tmb_orders_shipping_fk;
alter table tmb_product_suppliers drop constraint sys_product_suppliers_fk;
alter table tmb_product_suppliers drop constraint sys_product_suppliers_fk2;
alter table tmb_products drop constraint sys_tmb_product_fk;


---DROP IN THIS ORDER---
drop table tmb_order_items;
drop table tmb_reviews;
drop table tmb_customers;
drop table tmb_product_suppliers;
drop table tmb_products;
drop table tmb_supplier;
drop table tmb_category;
drop table tmb_orders;
drop table tmb_shipping_rate;
drop table tmb_tax_rate;

---SPOOL IN REVERSE ORDER---

---Hierachical entity---
create table tmb_category(
  category_number number constraint sys_tmb_category_pk primary key,
  names varchar2(100) not null
);

---^CATEGORY_NUMBER alter table tmb_products drop constraint sys_tmb_product_fk---


---If country is in Canada, then customer_provices are AB,BC...---
create table tmb_supplier(
  supplier_number number constraint sys_tmb_supplier_pk primary key,
  supplier_name varchar2(50) not null,
  email varchar2(100) not null,
  city varchar2(100) not null,
  province char(2) not null,
  country char(2) not null,
  country_subdivision_code varchar2(6) not null,
  constraint sys_tmb_supplier_province_ck
    check (( province in ('AB', 'BC', 'SK', 'MB', 'ON', 'QC', 'NB', 'NS', 'NL', 'NT', 'NU', 'PE', 'YT')))
);

---^SUPPLIER_NUMBER alter table tmb_product_suppliers drop constraint sys_product_suppliers_fk2---


---if in canada customer_province are AB,BC... province tax HST,GST,PST---
create table tmb_tax_rate(
  tax_rate_id number constraint sys_tmb_tax_rate_pk primary Key,
  province char(2) not null constraint sys_tmb_tax_rate_province_ck
    check (province in ('AB', 'BC', 'SK', 'MB', 'ON', 'QC', 'NB', 'NS', 'NL', 'NT', 'NU', 'PE', 'YT')),
  tax_rate char(3) not null constraint sys_tmb_tax_rate_tax_rate_ck
    check (tax_rate in ('HST', 'GST', 'PST'))
);

---^TAX_RATE_ID alter table tmb_orders drop constrain sys_tmb_orders_fk---


/*Weight (kg)	Shipping Cost
1 kg up to but not including 5 kg	$9.95
5 kg up to but not including 10 kg	$19.95
10 kg up to but not including 20 kg	$39.95
20 kg up to but not including 100 kg	$79.97
No shipping over 100kg	
*/
create table tmb_shipping_rate(
  shipping_rate_id number constraint sys_tmb_shipping_rate_pk primary key,
  shipping_cost number(8,2) not null,
  waight_kg number(4,1) not null
);

---^SHIPPING_RATE_ID alter table tmb_orders drop constraint sys_tmb_orders_shipping_fk---


create table tmb_customers(
  customer_number number constraint sys_tmb_customers_pk primary key,
  address_ varchar2(100) not null,
  city varchar2(100) not null,
  province char(2) not null constraint sys_tmb_customers_province_ck
    check ( province in ('AB', 'BC', 'SK', 'MB', 'ON', 'QC', 'NB', 'NS', 'NL', 'NT', 'NU', 'PE', 'YT')),
  postal_code char(6) not null,-- constraint sys_tmb_customers_postal_code_ck
    --check(postal_code like '[A-Z][0-9][A-Z][0-9][A-Z][0-9]'),
  phone_number char(12) not null, --constraint sys_tmb_customers_phone_number_ck
    --check(phone_number like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' or phone_number like '[0-9][0-9][0-9].[0-9][0-9][0-9].[0-9][0-9][0-9][0-9]' or phone_number like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
  email varchar(100) not null, --constraint sys_tmb_customers_email_ck
    --check(email like '%@%'),
  review_date date null,
  timber_membership number(1) not null constraint sys_tmb_customers_timber_membership_ck
    check (timber_membership in (0,1)) ---1 means a member, 0 means not a member
);

---^CUSTOMER_NUMBER alter table tmb_orders drop constraint sys_tmb_orders_customer_fk---

---^CUSTOMER_NUMBER alter table tmb_reviews drop constraint sys_tmb_reviews_fk---

/*
create table tmb_orders(
  order_number number constraint sys_tmb_orders_pk primary key (order_number),
  customer_number number constraint sys_tmb_orders_customer_fk --------EDITED HERE-------
    references tmb_customers(customer_number)not null,
  tax_rate_id number constraint sys_tmb_orders_fk --------EDITED HERE before tax_id.. now tax_rate_id-------
    references tmb_tax_rate(tax_rate_id)not null, --------EDITED HERE-------
  shipping_rate_id number constraint sys_tmb_orders_shipping_fk
    references tmb_shipping_rate(shipping_rate_id)not null, --------EDITED HERE-------
  order_date date not null,
  delivery_date date not null
);*/

create table tmb_orders(
  order_number number constraint sys_tmb_orders_pk primary key,
  customer_number number constraint sys_tmb_orders_customer_fk 
    references tmb_customers(customer_number) not null,
  tax_rate_id number constraint sys_tmb_orders_tax_fk 
    references tmb_tax_rate(tax_rate_id) not null,
  shipping_rate_id number constraint sys_tmb_orders_shipping_fk 
    references tmb_shipping_rate(shipping_rate_id) not null,
  order_date date not null,
  delivery_date date not null
);



---tax_exempt_flag should be "1" for tax exempt or "0" for non-tax exampt---
create table tmb_products(
  product_number number constraint sys_tmb_product_pk primary key,
  category_number number constraint sys_tmb_product_fk
    references tmb_category (category_number),
  title varchar2(60) not null,
  description_ varchar2(200) not null,
  price number(8,2) not null,
  waight_kg number(4,1) not null,
  tax_exempt_flag number(1),
  constraint sys_tmb_product_tax_exempt_flag_ck
    check(tax_exempt_flag in (0,1))
);

---^PRODUCT_NUMBER alter table tmb_product_suppliers drop constraint sys_product_suppliers_fk
---^PRODUCT_NUMBER alter table tmb_order_items drop constraint sys_tmb_order_item_product_number_fk
---^PRODUCT_NUMBER alter table tmb_reviews drop constraint sys_tmb_reviews_product_fk


/*quantity_on_hand >0
  delivary_day >0
*/
create table tmb_product_suppliers(
  product_number number constraint sys_product_suppliers_fk
    references tmb_products(product_number),
  supplier_number number constraint sys_product_suppliers_fk2
    references tmb_supplier(supplier_number),
  quantity_on_hand number not null constraint sys_tmb_product_supplier_quantity_on_hand_ck
    check (quantity_on_hand >= 0),
  delivery_day number not null constraint sys_tmb_product_suppliers_delivery_day_ck
    check (delivery_day >= 0)
  --constraint sys_tmb_product_suppliers_pk primary key(product_number, supplier_number)
);


create table tmb_reviews(
  review_number number(10) constraint sys_tmb_reviews_pk primary key,
  customer_number number(10) constraint sys_tmb_reviews_fk
    references tmb_customers (customer_number),
  product_number number constraint sys_tmb_reviews_product_fk
    references tmb_products (product_number),
  price float(24) constraint price_ck check (price > 0) not null,
  rating number(1) not null constraint sys_tmb_reviews_rating_ck
      check (rating in (1,2,3,4,5)),
  comments varchar2(200) not null,
  waight_kg float constraint waight_kg_ck
      check (waight_kg >= 0) not null,
  tax_exempt_flag number(1) constraint sys_tmb_reviews_tax_exempt_flag_ck
      check (tax_exempt_flag in (0,1)) not null
    );

---^REVIEW_NUMBER alter table 
   
---alter tables still hold values true to main table---

 




---^ORDER_NUMBER alter table tmb_order_items drop constraint sys_tmb_order_item_order_number_fk---

create table tmb_order_items(
  order_number number,
  product_number number,
  order_quantity number,
  constraint sys_tmb_order_item_pk primary key(product_number)
  );

---alter tables still hold values true to main table---
  --alter table tmb_order_items
    --add constraint sys_tmb_order_item_order_number_fk foreign key (order_number)
      --references tmb_orders(order_number);
  alter table tmb_order_items
    add constraint sys_tmb_order_item_product_number_fk foreign key (product_number)
      references tmb_products(product_number);
  alter table tmb_order_items
    add constraint sys_tmb_order_item_order_quantity_ck 
      check (order_quantity > 0);



spool off;

----spool testing---
/* 
  spool on
  
    create table testing_customer(
      testing_number number constraint sys_tmb_test_pk primary key,
      number_name varchar2(50) not null
    );
  
    SET SERVEROUTPUT ON
    SET VERIFY OFF
  
    ACCEPT testing_number PROMPT 'Enter testing number: '
    ACCEPT number_name PROMPT 'Enter number name: '
  
    SPOOL "C:\TimberSpool\testing.txt"
  
    DECLARE
      v_category VARCHAR2(50) := 'testing_customer';
    BEGIN
      INSERT INTO testing_customer (testing_number, number_name)
      VALUES (&testing_number, '&number_name');
  
      DBMS_OUTPUT.PUT_LINE('Data inserted into ' || v_category || ' table');
    END;
    /
  
    SPOOL OFF
  
    SET PAGESIZE 0
    SET TRIMSPOOL ON
    SET LINESIZE 100
    SET UNDERLINE OFF
    SPOOL "C:\TimberSpool\testing.txt"
    desc tmb_category
    SPOOL OFF*/



