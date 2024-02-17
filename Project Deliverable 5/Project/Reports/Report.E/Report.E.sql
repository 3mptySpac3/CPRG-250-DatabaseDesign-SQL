set feedback off -- To turn off the statement execution result
set echo off -- To turn off the echoing of the SQL statements
set linesize 200 -- To increase the size of the line
set pagesize 15 -- To increase the number of rows displayed per page

Spool C:\Reports\ReportE.txt
-- Report E

TTITLE left 'Report E'
BTITLE left 'End of Report'
column "Customer Number" format a10
column "Phone Number" format a10
column "Email" format a35
SELECT TMB_CUSTOMERS.customer_number, TMB_CUSTOMERS.phone_number, TMB_CUSTOMERS.email
FROM TMB_CUSTOMERS
JOIN TMB_ORDERS ON TMB_CUSTOMERS.customer_number = TMB_ORDERS.customer_number
JOIN TMB_ORDER_ITEMS ON TMB_ORDERS.order_number = TMB_ORDER_ITEMS.order_number
JOIN TMB_PRODUCTS ON TMB_ORDER_ITEMS.product_number = TMB_PRODUCTS.product_number
WHERE tax_exempt_flag = 0
ORDER BY customer_number;

commit;

Spool off