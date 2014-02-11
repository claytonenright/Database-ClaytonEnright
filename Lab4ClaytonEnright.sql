-- Lab 4: The Sequel
-- Clayton Enright 2/14/14

-- Query #1
select city
from agents
where aid in (select aid
	      from orders
	      where cid in (select cid
			    from customers
			    where name = 'Basics'
			    )
	      )

-- Query #2
select distinct pid
from orders
where aid in (select aid
	      from orders
	      where cid in (select cid
			    from customers
			    where city = 'Kyoto'
			    )
	      )
order by pid asc

-- Query #3
select cid, name
from customers
where cid not in (select cid
		  from orders
		  where aid = 'a03'
		  )

-- Query #4
select cid, name
from customers
where cid in (select cid
	      from orders
	      where pid = 'p01'
	      )
  and cid in (select cid
	      from orders
	      where pid = 'p07'
	      )

-- Query #5
select distinct pid
from orders
where cid in (select cid
	      from orders
	      where aid = 'a03'
	      )
order by pid

-- Query #6
select name, discount
from customers
where cid in (select cid
	      from orders
	      where aid in (select aid
			    from agents
			    where city = 'Dallas'
			    or city = 'Duluth'
			    )
	      )

-- Query #7
select cid, name
from customers
where cid in (select cid
	      from customers
	      where discount in (select discount
				  from customers
				  where city = 'Dallas'
				     or city = 'Kyoto'
				  )
	      )
and city not in ('Dallas','Kyoto')

