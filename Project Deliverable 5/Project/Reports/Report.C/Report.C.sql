set feedback off -- To turn off the statement execution result
set echo off -- To turn off the echoing of the SQL statements
set linesize 200 -- To increase the size of the line
set pagesize 15 -- To increase the number of rows displayed per page

Spool C:\Reports\ReportC.txt
--Report C

TTITLE left 'Report C'
BTITLE left 'End of Report'
column "Comments" format a35
column "Title" format a35
select TMB_REVIEWS.comments, TMB_PRODUCTS.title 
FROM TMB_REVIEWS
JOIN TMB_PRODUCTS ON TMB_REVIEWS.product_number = TMB_PRODUCTS.product_number
WHERE rating < 3
ORDER BY rating;

commit;

Spool off