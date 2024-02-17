
SET PAGESIZE 50
SET LINESIZE 500
SET FEEDBACK ON
SET VERIFY OFF

SPOOL C:\ProjectD4\Valid2.txt --- Location of output file---

set echo on


--delete existing data from tables, children followed parents---
delete tmb_product_suppliers;
delete tmb_shipping_rate;
delete tmb_tax_rate;
delete tmb_customers;
delete tmb_reviews;
delete tmb_order_items;
delete tmb_orders;
delete tmb_products;
delete tmb_supplier;
delete tmb_category;


-- insert data, parents followed by children Reverse Order---
/* 
INSERT IN THIS ORDER
tmb_reviews
tmb_category
tmb_products
tmb_customers
tmb_supplier



tmb_tax_rate
tmb_shipping_rate
tmb_supplier
tmb_products
tmb_customers
tmb_orders
tmb_product_suppliers
tmb_reviews
tmb_order_items
*/


--TMB_CATEGORY--
  insert into tmb_category(category_number,names)
    values(101,'Books');

  insert into tmb_category(category_number,names)
    values(102,'Games');
  
  insert into tmb_category(category_number,names)
    values(103,'Art');

  insert into tmb_category(category_number,names)
    values(104,'Music');


--TMB_TAX_RATE--
  insert into tmb_tax_rate(tax_rate_id,province,tax_rate)
    values(12345,'AB','GST');

  insert into tmb_tax_rate(tax_rate_id,province,tax_rate)
    values(12346,'BC','PST');

  insert into tmb_tax_rate(tax_rate_id,province,tax_rate)
    values(12347,'ON','HST');

  insert into tmb_tax_rate(tax_rate_id,province,tax_rate)
    values(12348,'QC','GST');

  insert into tmb_tax_rate(tax_rate_id,province,tax_rate)
    values(12349,'AB','GST');
  
  insert into tmb_tax_rate(tax_rate_id,province,tax_rate)
    values(12341,'BC','PST');

  insert into tmb_tax_rate(tax_rate_id,province,tax_rate)
    values(11234,'AB','GST');


--TMB_SHIPPING_RATE--
  insert into tmb_shipping_rate(shipping_rate_id,shipping_cost,waight_kg)
    values(99,9.95,1);

  insert into tmb_shipping_rate(shipping_rate_id,shipping_cost,waight_kg)
    values(88,9.95,1);

  insert into tmb_shipping_rate(shipping_rate_id,shipping_cost,waight_kg)
    values(77,39.95,10);

  insert into tmb_shipping_rate(shipping_rate_id,shipping_cost,waight_kg)
    values(66,9.95,1);

  insert into tmb_shipping_rate(shipping_rate_id,shipping_cost,waight_kg)
    values(55,9.95,1);

  insert into tmb_shipping_rate(shipping_rate_id,shipping_cost,waight_kg)
    values(44,9.95,1);

  insert into tmb_shipping_rate(shipping_rate_id,shipping_cost,waight_kg)
    values(33,19.95,5);


--TMB_SUPPLIER--
  insert into tmb_supplier(supplier_number,supplier_name,email,city,province,country,country_subdivision_code)
    values(28439567,'John John Contracting and Ship.','JohnJohnCon@gmail.com','John Vill','AB','CA','AB-01');

  insert into tmb_supplier(supplier_number,supplier_name,email,city,province,country,country_subdivision_code)
    values(2948532,'Impossibly Good Shipping.co','GoodGoods@gmail.com','Vancouver','BC','CA','BC-03');

  insert into tmb_supplier(supplier_number,supplier_name,email,city,province,country,country_subdivision_code)
    values(38592038,'Dream Shipping','SleepNowShipLater@gmail.com','LA','ON','CA','ON-09');


--TMB_PRODUCTS--
  insert into tmb_products(product_number,category_number,title,description_,price,waight_kg,tax_exempt_flag)
    values(1935,101,'To Kill A Mockingbird','Great, Fun, Must read',12.99,1,0);

  insert into tmb_products(product_number,category_number,title,description_,price,waight_kg,tax_exempt_flag)
    values(2394,102,'Call of Duty Modern III','Graphic, CD',89.99,1,0);

  insert into tmb_products(product_number,category_number,title,description_,price,waight_kg,tax_exempt_flag)
    values(5869,103,'Mona Lisa','Priceless',25.99,10,1);

  insert into tmb_products(product_number,category_number,title,description_,price,waight_kg,tax_exempt_flag)
    values(3395,104,'All Ghibli OST','GOAT, Record',99.99,1,0);

  insert into tmb_products(product_number,category_number,title,description_,price,waight_kg,tax_exempt_flag)
    values(2834,101,'1984','Cool, Nice',14.99,1,0);

  insert into tmb_products(product_number,category_number,title,description_,price,waight_kg,tax_exempt_flag)
    values(4956,102,'Mincraft','Best, CD',19.99,1,0);

  insert into tmb_products(product_number,category_number,title,description_,price,waight_kg,tax_exempt_flag)
    values(6032,103,'Starring Night','Priceless',21.99,5,1);

  insert into tmb_products(product_number,category_number,title,description_,price,waight_kg,tax_exempt_flag)
    values(1123,104,'Triller Vinyl MJ','The Best Record',38.99,1,0);




--TMB_ORDER_ITEMS--
  insert into tmb_order_items(order_number,product_number,order_quantity)
    values(283,1935,2);

  insert into tmb_order_items(order_number,product_number,order_quantity)
    values(384,2394,1);

  insert into tmb_order_items(order_number,product_number,order_quantity)
    values(847,5869,1);

  insert into tmb_order_items(order_number,product_number,order_quantity)
    values(239,3395,3);

  insert into tmb_order_items(order_number,product_number,order_quantity)
    values(839,2834,1);

  insert into tmb_order_items(order_number,product_number,order_quantity)
    values(125,4956,5);

  insert into tmb_order_items(order_number,product_number,order_quantity)
    values(928,6032,2);



--TMB_CUSTOMERS--
  insert into tmb_customers(customer_number,address_,city,province,postal_code,phone_number,email,review_date,timber_membership)
    values(33,'1251 Random Close','Red Deer','AB','T4B9A4','587-123-4985','John@gmail.com',to_date('12/3/2022','MM/DD/YYYY'),1);

  insert into tmb_customers(customer_number,address_,city,province,postal_code,phone_number,email,review_date,timber_membership)
    values(12,'583 John John Road','Mississippi','BC','A7AO82','825-193-8409','Serah@gmail.com',to_date('2/6/2022','MM/DD/YYYY'),1);

  insert into tmb_customers(customer_number,address_,city,province,postal_code,phone_number,email,review_date,timber_membership)
    values(9,'8893 Bayside SW','Chicken Vill','ON','Y9Y3O4','403-691-0036','Ligma@gmail.com',to_date('6/6/2022','MM/DD/YYYY'),0);

  insert into tmb_customers(customer_number,address_,city,province,postal_code,phone_number,email,review_date,timber_membership)
    values(15,'North Side SW','Farm Vill','QC','P4F3M9','203-957-8803','Kim@gmail.com',to_date('9/27/2022','MM/DD/YYYY'),1);

  insert into tmb_customers(customer_number,address_,city,province,postal_code,phone_number,email,review_date,timber_membership)
    values(21,'Angry Street','Pighouse','AB','T4B3K8','123-904-8765','Karen@gmail.com',to_date('4/1/2022','MM/DD/YYYY'),0);


--TMB_ORDERS--
  insert into tmb_orders(order_number,customer_number,tax_rate_id,shipping_rate_id,order_date,delivery_date)
    values(238,33,12345,99,to_date('1/1/2022', 'MM/DD/YYYY'),to_date('1/4/2022','MM/DD/YYYY'));

  insert into tmb_orders(order_number,customer_number,tax_rate_id,shipping_rate_id,order_date,delivery_date)
    values(384,12,12346,88,to_date('1/1/2022','MM/DD/YYYY'),to_date('1/4/2022','MM/DD/YYYY'));

  insert into tmb_orders(order_number,customer_number,tax_rate_id,shipping_rate_id,order_date,delivery_date)
    values(857,9,12347,77,to_date('1/1/2022','MM/DD/YYYY'),to_date('1/8/2022','MM/DD/YYYY'));

  insert into tmb_orders(order_number,customer_number,tax_rate_id,shipping_rate_id,order_date,delivery_date)
    values(239,15,12348,66,to_date('1/1/2022','MM/DD/YYYY'),to_date('1/3/2022','MM/DD/YYYY'));

  insert into tmb_orders(order_number,customer_number,tax_rate_id,shipping_rate_id,order_date,delivery_date)
    values(839,21,12349,55,to_date('1/1/2022','MM/DD/YYYY'),to_date('5/11/2022','MM/DD/YYYY'));

  insert into tmb_orders(order_number,customer_number,tax_rate_id,shipping_rate_id,order_date,delivery_date)
    values(125,12,12341,44,to_date('1/1/2022','MM/DD/YYYY'),to_date('1/5/2022','MM/DD/YYYY'));

  insert into tmb_orders(order_number,customer_number,tax_rate_id,shipping_rate_id,order_date,delivery_date)
    values(928,9,11234,33,to_date('1/1/2022','MM/DD/YYYY'),to_date('1/10/2022','MM/DD/YYYY'));

--TMB_REVIEWS--
  insert into tmb_reviews(review_number,customer_number,product_number,rating,comments,price,waight_kg,tax_exempt_flag)
    values(1,33,1935,5,'Beyond amazing...',12.99,1,0);

  insert into tmb_reviews(review_number,customer_number,product_number,rating,comments,price,waight_kg,tax_exempt_flag)
    values(2,12,2394,4,'Pretty Cool!',89.99,1,0);

  insert into tmb_reviews(review_number,customer_number,product_number,rating,comments,price,waight_kg,tax_exempt_flag)
    values(3,9,5869,3,'It was ok.',25.99,10,1);

  insert into tmb_reviews(review_number,customer_number,product_number,rating,comments,price,waight_kg,tax_exempt_flag)
    values(4,15,3395,2,'Dissapointed...',99.99,1,0);

  insert into tmb_reviews(review_number,customer_number,product_number,rating,comments,price,waight_kg,tax_exempt_flag)
    values(5,21,2834,1,'Manager...Now...',14.99,1,0);



--TMB_PRODUCT_SUPPLIER--
  insert into tmb_product_suppliers(product_number,supplier_number,quantity_on_hand,delivery_day)
    values(1935,38592038,5,3);
  
  insert into tmb_product_suppliers(product_number,supplier_number,quantity_on_hand,delivery_day)
    values(2394,28439567,3,3);

  insert into tmb_product_suppliers(product_number,supplier_number,quantity_on_hand,delivery_day)
    values(5869,2948532,1,7);

  insert into tmb_product_suppliers(product_number,supplier_number,quantity_on_hand,delivery_day)
    values(3395,28439567,10,2);

  insert into tmb_product_suppliers(product_number,supplier_number,quantity_on_hand,delivery_day)
    values(2834,38592038,6,10);

  insert into tmb_product_suppliers(product_number,supplier_number,quantity_on_hand,delivery_day)
    values(4956,98432567,17,1);

  insert into tmb_product_suppliers(product_number,supplier_number,quantity_on_hand,delivery_day)
    values(6032,2948532,2,8);
  
  insert into tmb_product_suppliers(product_number,supplier_number,quantity_on_hand,delivery_day)
    values(1123,38592038,3,5);






  COMMIT;

SET PAGESIZE 60
SET LINESIZE 250

select * from  tmb_product_suppliers;
select * from tmb_shipping_rate;
select * from tmb_tax_rate;
select * from tmb_customers;
select * from tmb_reviews;
select * from tmb_order_items;
select * from tmb_orders;
select * from tmb_products;
select * from tmb_supplier;
select * from tmb_category;

spool off;

