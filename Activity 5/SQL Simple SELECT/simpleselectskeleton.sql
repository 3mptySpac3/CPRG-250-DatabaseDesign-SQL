
rem Unit 10 Group Exercise Simple SELECT and Sorting 
set echo on
set linesize 100
set pagesize 66

spool C:\spool\activity_6.txt



--rem Q1 - basic select columns with headers
--rem insert solution here!
select Fname "First", Lname "Last" From Author;
rem insert solution here!

--rem Q2 
--rem insert solution here!
column "Order-Item #" format a20
select order# || '-' || item# "Order-Item #", isbn "Book ISBN", quantity "Qty",
    paideach "Price", paideach * quantity "Line Total", paideach * quantity * 0.05 "GST",
    paideach * quantity * 1.05 "Total Price"
from orderitems;
clear columns

--rem Q3 
--rem insert solution here!
select DISTINCT AuthorID "ID" from BOOKAUTHOR;


--rem Q4 
--rem insert solution here!
column "Cust#-Order#" format a20
select Customer# || '-' || Order# "Customer#-Order#", ShipDate - OrderDate "Days to Ship" from Orders;


--rem Q5 
--rem insert solution here!
Select Lastname || ', '|| Firstname "Name", Address || ', ' || City ||', '|| State || ', ' || Zip "Address" 
From CUSTOMERS;
clear columns 



spool off

