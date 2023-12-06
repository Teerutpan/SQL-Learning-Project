--- Basic Queries

create table student (
	student_id INT,
    name varchar(20) not null,
    major varchar(20),
    primary key(student_id)
);
select * from student;

describe student

drop table student;

insert into student values(1, 'Jack', 'Biology');
insert into student values(2, 'kate', 'Sociology');
insert into student values(3, 'Claire', 'Chemistry');
insert into student values(4, 'Jack', 'Biology');
insert into student values(5, 'Mike', 'Computer Science');

select *
from student 
order by student_id asc;

select *
from student 
order by major, student_id desc;

select *
from student 
limit 2;

select *
from student
where major <> 'Chemistry';

-- <, >, <=, >=, -, <>, AND, OR

select *
from student
where name in ('Claire', 'Kate', 'Mike') AND student_id > 2;

--- Creating Tables

create table student (
	student_id INT,
    name varchar(20),
    major varchar(20),
    primary key(student_id)
);

describe student

drop table student;

alter table student add gpa decimal(3, 2);

alter table student drop column gpa;

--- Inserting Data

insert into student values(1, 'Jack', 'Biology');
insert into student values(2, 'kate', 'Sociology');
insert into student values(3, null, 'Claire');
insert into student values(4, 'Jack', 'Biology');
insert into student values(5, 'Mike', 'Computer Science');

--- Inserting value auto increment

insert into student(name, major) values('Jack', 'Biology');
insert into student(name, major) values('Kate', 'Sociology');

--- Update & Delete

update student
set major = 'Bio'
where major = 'Biology';

delete from student
where student_id = 5;

delete from student
where name = 'Jack' and major = 'Biology';

--- Union

select first_name
from employee
union
select branch_name
from branch;

-- Find a list of all clients & branch suppliers's name
select client_name, client.branch_id
from client
union
select supplier_name, branch_supplier.branch_id
from branch_supplier;

--- Nest

-- Find names of all employees who have
-- sold over 30,000 to a single client
select employee.first_name, employee.last_name
from employee
where employee.emp_id in (
	select works_with.emp_id
	from works_with
	where works_with.total_sales > 30000

--- Wildcards

-- % = any # characters, _ = one character

select *
from client
where client_name like '%LLC';

select *
from employee
where birth_day like '____-02%';

--- left right position

SELECT 
    ContactName,
    LEFT(contactname,
        POSITION(' ' IN contactname)) AS first_name,
    RIGHT(contactname,
        CHAR_LENGTH(contactname) - POSITION(' ' IN contactname))
FROM
    suppliers

--- case when statement

select freight, case 
	when Freight >= 100 then 'Heavy'
    when freight >= 50 then 'Medium'
    when freight >= 10 then 'Light'
    else 'Feather'
    end as how_heavy
from orders

select freight, sum(freight), case 
	when sum(Freight) >= 1000 then 'Heavy'
    when sum(freight) >= 500 then 'Medium'
    when sum(freight) >= 100 then 'Light'
    else 'Feather'
    end as how_heavy
from orders
group by 1

--- Group by, Having, Where

SELECT 
    country, city, COUNT(*)
FROM
    customers
WHERE
    country LIKE '%a%'
GROUP BY 1 , 2
HAVING COUNT(*) < 3
ORDER BY COUNT(*) DESC

-- with statement(common table exoressions)

-- We want the average number of orders per customer per country
with cte_orders as (
    SELECT 
        CustomerID, ShipCountry, COUNT(*) AS num_orders
    FROM
        orders
    GROUP BY 1 , 2), 
    
    cte_customers as (
    select customerid, companyname
    from customers)
    
SELECT 
    ShipCountry, AVG(num_orders)
FROM cte_orders
join cte_customers using (customerid)
GROUP BY 1

--- Aggregation from chinook database

SELECT
	ge.name,
    COUNT(*) AS songs
FROM artists ar
LEFT JOIN albums al ON ar.artistid = al.artistid
LEFT JOIN tracks tr ON al.albumid = tr.albumid
INNER JOIN genres ge ON tr.genreid = ge.genreid
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5



