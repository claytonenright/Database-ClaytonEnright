-- Lab #6: Really Interesting Queries
-- Clayton Enright 2/28/14

-- #1 Get the name and city of customers who live in a city where the
-- most number of products are made.
select name, city
from customers
where city in (select city
	       from (select city, sum(quantity) as "sq"
		     from products
		     group by city
		     order by sq desc
		     limit 1) as "mostcity")

-- #2 Get the name and city of customers who live in any city where the
-- most number of products are made. (Not sure of difference between this question and first one. Used number of types of products for this one.)
select name, city
from customers
where city in (select city
	       from (select city, count(name) as "cn"
		     from products
		     group by city
		     order by cn desc
		     limit 1) as "mostcity")
		     
		     
-- #3 List the products whose priceUSD is above the average priceUSD
select name
from products
where priceUSD > (select avg(priceUSD)
		  from products)


-- #4 Show the customer name, pid ordered, and the dollars
-- for all customer orders, sorted by dollars high to low
select c.name, o.pid, o.dollars
from orders o, customers c
where o.cid = c.cid
order by dollars desc

-- #5 Show all customer names (in order) and their total ordered,
-- and nothing more. Use coalesce to avoid showing NULLs.
select c.name, coalesce (sum(dollars), 0)
from orders o right outer join customers c on o.cid = c.cid
group by c.name, c.city
order by c.name

-- #6 Show the names of all customers who bought products from agents
-- based in New York along with the names of the products they ordered,
-- and the names of the agents who sold it to them.
select c.name, p.name, a.name
from orders o, customers c, products p, agents a
where o.cid = c.cid
  and o.pid = p.pid
  and o.aid = a.aid
  and a.city = 'New York'

-- #7 Write a query to check the accuracy of the dollars column in the Orders table.
-- This means calculating Orders.dollars from other data in other tables and then
-- comparing those values to the values in Orders.dollars
select o.ordno, o.pid, o.qty * p.priceUSD * (1 - c.discount/100) as "totalcheck", o.dollars as "Order.dollars"
from orders o , products p, customers c
where o.pid = p.pid
  and o.cid = c.cid
