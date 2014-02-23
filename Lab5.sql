-- Lab 5: "The Three-quel"
-- Clayton Enright 2/24/14

-- Query 1
select a.city
from agents a,
     orders o,
     customers c
where a.aid = o.aid
  and c.cid = o.cid
  and c.name = 'Basics';

-- Query 2
select distinct o2.pid
from orders o1, customers c, agents a, orders o2
where o1.cid = c.cid
  and o1.aid = a.aid
  and o2.aid = a.aid
  and c.city = 'Kyoto'
order by o2.pid;


-- Query 3
select name
from customers
where cid not in (select o.cid
		  from orders o,
		       customers c
		  where c.cid = o.cid);

-- Query 4
select c.name
from customers c left outer join orders o on c.cid = o.cid
where o.ordno is null;

-- Query 5
select distinct c.name, a.name
from orders o
inner join customers c on o.cid = c.cid
inner join agents a on o.aid = a.aid
where c.city = a.city;

-- Query 6
select c.name, a.name, a.city
from customers c, agents a
where c.city = a.city;

-- Query 7
select name, city
from customers
where city = (select city
              from (select sum(quantity) as "sq", city
	            from products p
	            group by city
	            order by sq asc
	            limit 1) as "LeastCity");