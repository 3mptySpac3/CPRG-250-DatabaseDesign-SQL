README.Population TMB_DATABASE

Table Creation README
This README provides instructions on how to insert data into the tables of TMB system using SQL.

Prerequisites
To create the tables, you will need access to an SQL database management system such as Oracle, MySQL or PostgreSQL.

Insert instruction
The following insert should be created in the order specified below:

tmb_category
  -Holds information on the product categories available
tmb_supplier
  -Holds information on the suppliers for products
tmb_tax_rate
  gives the tax rate for specific Province in Canada
tmb_shipping_rate
  -Holds data on shipping rate dependent on predetermined parameters: ie weight:cost ratio
tmb_customers
  -Holds data on the customers within the system
tmb_orders
  -This holds data on the customer order
tmb_products
  -This holds data on the products within the database
tmb_product_supplier
  -This holds data on who supplies the products
tmb_order_items
  -This is the items ordered
tmb_reviews
  -This holds data on the revies given by customers
