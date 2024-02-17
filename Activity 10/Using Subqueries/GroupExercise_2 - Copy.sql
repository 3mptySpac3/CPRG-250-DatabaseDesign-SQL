set echo on 
set linesize 120
set pagesize 66


@ "C:\Users\marti\Desktop\School\Database and Design Programming\cprg250s\build_JLDB.sql"

SPOOL C:\Users\marti\Desktop\School\GroupExercise2.txt

--Q1-- 1.	Which customers ordered the same books as customers in Texas? Show the book title, state and customer #.
SELECT state, customer#, title
  FROM customers join orders using (customer#) join orderitems using (order#)
    join books using (isbn)
  WHERE state  NOT IN
    (SELECT state
    FROM customers join orders using (customer#) join orderitems using (order#)
      join books using (isbn)
    WHERE state = 'TX')
  AND title in
    (SELECT title
    FROM customers join orders using (customer#) join orderitems using (order#)
      join books using (isbn)
    WHERE state = 'TX')
order by title;

--Q2-- which books have been ordered by customers in the greatest number of states?
select distinct title, state 
from customers join orders using (customer#) join orderitems using (order#)
    join books using (isbn)
where isbn in 
    (select isbn 
    from customers join orders using(customer#) join orderitems using (order#)
    group by isbn
    having count(distinct state) = 
        (select max(count(distinct state))
        from customers join orders using(customer#) join orderitems using (order#)
        group by isbn))
order by title, state;

--Q3--What book was ordered the most based on its quantity in orderitems?
SELECT title 
FROM customers 
JOIN orders USING (customer#) 
JOIN orderitems USING (order#) 
JOIN books USING (isbn)
GROUP BY title 
HAVING SUM(quantity) = (
    SELECT MAX(total_quantity) 
    FROM (
        SELECT SUM(quantity) as total_quantity
        FROM customers 
        JOIN orders USING (customer#) 
        JOIN orderitems USING (order#)
        JOIN books USING (isbn)
        GROUP BY isbn
    ) 
);

--Q4--What was the most recent book ordered in each category and when was it ordered?
SELECT b.category, b.title, MAX(o.orderdate) as Orderdate 
FROM books b
JOIN orderitems oi ON b.isbn = oi.isbn
JOIN orders o ON oi.order# = o.order#
WHERE (b.category, o.orderdate) IN (
    SELECT b2.category, MAX(o2.orderdate) as max_orderdate
    FROM orders o2
    JOIN orderitems oi2 ON o2.order# = oi2.order#
    JOIN books b2 ON oi2.isbn = b2.isbn
    GROUP BY b2.category
)
GROUP BY b.category, b.title
ORDER BY b.category;

spool off











