set echo on
set linesize 100
set pagesize 66
@"C:\Users\marti\Desktop\School\Database and Design Programming\cprg250s\build_JLDB.sql" 
spool C:\Users\marti\Desktop\School\Database and Design Programming\cprg250s\GEOUTPUT.txt


select AuthorID "AUTH", Fname "FNAME", Lname "LNAME",
from AUTHOR natural join BOOKAUTHOR 
where BOOKAUTHOR.ISBN not in (
    Select ISBN FROM ORDERITEMS
    union 
    Select ISBN from Book 
    );

column "ORDER#" format a20
column "ITEM#" format a20
column "TITLE" format a20
column "QUANTITY" format a20
column "PAIDEACH" format a20 
column "Item Total" format a20
column "GIFT" format a20 
select ORDERITEMS.Order# "ORDER#", ORDERITEMS.Item# "ITEM#", Books.Title "TITLE", ORDERITEMS.Quantity "QUANTITY", ORDERITEMS.PaidEach "PAIDEACH", ORDERITEMS.quantity*ORDERITEMS.paideach "Item Total", promotion.gift "GIFT"
from  ORDERITEMS, Books, promotion
where ORDERITEMS.ISBN = Books.ISBN;


select customer# "CUSTOMER#", FirstName "FIRSTNAME", LastName "LASTNAME", Title "TITLE"
from Customer left outer join Orders using (Customer#)
    left join ORDERITEMS using (Order#)
    right join Books on ORDERITEMS.ISBN = BOOKS.ISBN
    order by 3, 4, 2;

spool off 