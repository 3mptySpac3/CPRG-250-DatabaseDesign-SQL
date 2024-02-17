set feedback off -- To turn off the statement execution result
set echo off -- To turn off the echoing of the SQL statements
set linesize 200 -- To increase the size of the line
set pagesize 15 -- To increase the number of rows displayed per page

Spool C:\Reports\ReportD.txt
--Report D


TTITLE left 'Report D'
BTITLE left 'End of Report'
column "Customer Number" format a10
column "Total Amount" format a10
Select customer_number, total_amount
From (
  Select TMB_CUSTOMERS.customer_number AS customer_number, 
         SUM(TMB_ORDER_ITEMS.order_quantity * TMB_PRODUCTS.price) AS total_amount
  From TMB_CUSTOMERS
  Join TMB_ORDERS On TMB_CUSTOMERS.customer_number = TMB_ORDERS.customer_number
  Join TMB_ORDER_ITEMS On TMB_ORDERS.order_number = TMB_ORDER_ITEMS.order_number
  Join TMB_PRODUCTS On TMB_ORDER_ITEMS.product_number = TMB_PRODUCTS.product_number
  Where province In ('AB', 'BC', 'MB', 'QC')
  Group By TMB_CUSTOMERS.customer_number
) subquery
ORDER BY total_amount DESC;


commit;

Spool off
