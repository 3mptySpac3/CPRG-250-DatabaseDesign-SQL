set echo on 
set linesize 120
set pagesize 66

@ "C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Week 11\JustLeeDatabase (1)\build_JLDB.sql"


Spool C:\spool\groupex_week12_2.txt

--Q1

column "Author Name" format A20;
column "Value" format $9,999,990.00;
coilumn "Commission" format $0.00;

select a.FName || ' ' || a.LName as "Author Name",
  SUM(oi.Quantity * oi.PaidEach) as "Value",
  SUM(oi.Quantity * oi.PaidEach) * 0.01 as "Commission"
from Author a
  join BookAuthor ba ON a.AuthorID = ba.AuthorID
  join Books b ON ba.ISBN = b.ISBN
  join OrderItems oi ON b.ISBN = oi.ISBN
  group by a.FName, a.LName
order by a.FName, a.LName;

--Q2

select initcap(firstname) "First" , initcap(lastname) "Last",
  COUNT (distinct authorid) "Number Anchors"
from customers join orders using(customer#)
  join orderitems using (order#)
  join books using(isbn)
  join bookauthor using (isbn)
group by firstname, lastname
having COUNT(distinct authorid) >=2
order by 2, 1;


--Q3

column "Publisher" format A30;
column "Average Profit" format $9,999,990.00;

select p.Name as "Publisher",
AVG(b.Retail - b.Cost) as "Average Profit"
from Publisher p
join Books b on p.PubID = b.PubID
 group by p.Name
 order by p.Name;
