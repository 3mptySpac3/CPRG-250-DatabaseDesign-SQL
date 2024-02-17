set feedback off -- To turn off the statement execution result
set echo off -- To turn off the echoing of the SQL statements
set linesize 200 -- To increase the size of the line
set pagesize 15 -- To increase the number of rows displayed per page
Spool C:\Reports\ReportA.txt
--Report A

TTITLE left 'Report A - Sales Info by Province' 
BTITLE left 'End of Report' 
column "Customer Number" format 99
column "Prov" format a4
column "Email" format a15
column 'Max' format '$'99.99
column 'Min' format '$'99.99
column 'Average' format '$'99.99
compute sum of "Max" on price format
compute sum of "Min" on price 
compute sum of "Average" on price 
break on province on report
SELECT TMB_CUSTOMERS.customer_number as "Cust.Number", TMB_CUSTOMERS.province as "Prov", 
TMB_CUSTOMERS.email as "Email", TMB_PRODUCTS.title as "Title", 
max(TMB_PRODUCTS.price) as "Max", min(TMB_PRODUCTS.price) as "Min", 
avg(TMB_PRODUCTS.price) as "Average"
FROM TMB_CUSTOMERS
JOIN TMB_ORDERS ON TMB_CUSTOMERS.customer_number = TMB_ORDERS.customer_number
JOIN TMB_ORDER_ITEMS ON TMB_ORDERS.order_number = TMB_ORDER_ITEMS.order_number
JOIN TMB_PRODUCTS ON TMB_ORDER_ITEMS.product_number = TMB_PRODUCTS.product_number
WHERE province IN ('AB', 'BC', 'MB', 'QC') AND TMB_PRODUCTS.price > 0
GROUP BY TMB_CUSTOMERS.customer_number, TMB_CUSTOMERS.province, TMB_PRODUCTS.title, TMB_CUSTOMERS.email
ORDER BY TMB_CUSTOMERS.customer_number;

Commit;

Spool off












