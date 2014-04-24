-- Stored Procedure #1 --
create or replace function PreReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
   course      int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select prereqnum
      from   prerequisites
       where  courseNum = course;
   return resultset;
end;
$$ 
language plpgsql;

select PreReqsFor(499, 'results');
Fetch all from results;



-- Stored Procedure #2 --
create or replace function IsPreReqFor(int, REFCURSOR) returns refcursor as 
$$
declare
   prereq      int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select coursenum
      from   prerequisites
       where  prereqnum = prereq;
   return resultset;
end;
$$ 
language plpgsql;

select IsPreReqFor(120, 'results');
Fetch all from results;



select *
from prerequisites