set feedback off -- To turn off the statement execution result
set echo off -- To turn off the echoing of the SQL statements
set linesize 200 -- To increase the size of the line
set pagesize 15 -- To increase the number of rows displayed per page

Spool C:\Reports\ReportB.txt
--Report B


TTITLE left 'Report B'
BTITLE left 'End of Report'
SELECT product_number, title, total_order_quantity
FROM (
  SELECT TMB_PRODUCTS.product_number AS product_number,
         TMB_PRODUCTS.title AS title,
         SUM(TMB_ORDER_ITEMS.order_quantity) AS total_order_quantity
  FROM TMB_CUSTOMERS
  JOIN TMB_ORDERS ON TMB_CUSTOMERS.customer_number = TMB_ORDERS.customer_number
  JOIN TMB_ORDER_ITEMS ON TMB_ORDERS.order_number = TMB_ORDER_ITEMS.order_number
  JOIN TMB_PRODUCTS ON TMB_ORDER_ITEMS.product_number = TMB_PRODUCTS.product_number
  WHERE province in ('AB', 'BC', 'MB', 'QC')
  GROUP BY TMB_PRODUCTS.product_number, TMB_PRODUCTS.title
) subquery
ORDER BY product_number;

commit;

Spool off
