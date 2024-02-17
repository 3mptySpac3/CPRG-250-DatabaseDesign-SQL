set echo on
set linesize 100
set pagesize 66
spool 'C:\Users\marti\Desktop\School\Database and Design Programming\cprg250s\simplesectoutput.txt'

select Title "Title", PubDate "Pub Date", Category "Category", Retail "Retail Price"
from Books
where PubDate > '31-DEC-05' or Category = 'COMPUTER' and Retail < 30
order by PubDate asc;

select Order# "Order #", Customer# "Customer #", OrderDate "Date Ord"
from Orders
where ShipDate is null
order by Customer# asc, Order# asc;

select Order# "Order#", ShipDate "ShipDate", ShipState "SH"
from Orders
where ShipDate >= '1-APR-09' and ShipDate <= '3-APR-09' and not ShipState = 'WA'
order by ShipDate asc;

select Title "Title", PubID "PubID", Retail "Retail"
from Books
where (PubID in ('2', '3', '4') and Retail > 30) or retail <=30 
order by Title asc;

Select Customer# "Customer#", Address "Address", Referred "Referred", Email "Email"
from CUSTOMERS
where Referred = 1003 or Address like 'P.O.%' or Email like '%axe.com'
order by Customer# asc; 

spool off
