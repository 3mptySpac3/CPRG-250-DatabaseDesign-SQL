set echo on 
set linesize 120
set pagesize 66



---Create
@ "C:\Users\thefa\OneDrive\Desktop\DatabaseDes\Week 11\JustLeeDatabase (1)\build_JLDB.sql"


Spool C:\spool\groupex_week12_1.txt


--Q1 --20% off all books, except those that already have a discount associated with them. 

select isbn, initcap(title) "Title",
  nvl2(discount, 'Fixed Discount','20% Discount') "Discount Type",
  to_char(retail, '$9,990.00') "Orig Price",
  to_char(nvl(discount, retail * 0.2), '$9,990.00') "Discount",
  to_char(nvl(retail-discount, retail-retail * 0.2), '$9,990.00') "Final $"
from books
order by 2;

--Q2 --  Show all customer orders. Carefully note the formatting of the columns

select initcap(firstname) "First", initcap(lastname) "Last",
  count(distinct authorid) "Number Authors"
from customers join orders using (customer#)
  join orderitems using (order#)
  join books using(isbn)
  join bookauthor using(isbn)
group by firstname, lastname
having count(distinct authorid) >= 2
order by 2,1;


--Q3 -- Show each customer’s book orders 
--and how old the book was when it was ordered by the number of months. Round the number of 
--months to the closest integer. Carefully note the formatting of the columns. Sort by last name and order#.

SELECT c.FirstName || ' ' || c.LastName AS Customer, 
       o.Order# AS "Order #",
       b.Title AS "Book Title",
       TO_CHAR(o.OrderDate, 'DD-MON-YY') AS "Order Date",
       TO_CHAR(b.PubDate, 'DD-MON-YY') AS "Publication Date",
       ROUND((o.OrderDate - b.PubDate) / 30) AS "Months Old"
FROM Orders o
JOIN Customers c ON o.Customer# = c.Customer#
JOIN OrderItems oi ON o.Order# = oi.Order#
JOIN Books b ON oi.ISBN = b.ISBN
ORDER BY c.LastName, o.Order#;




