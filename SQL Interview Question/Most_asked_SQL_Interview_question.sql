--Q 1. Find monthly sales and sort it by desc order

CREATE TABLE Products (
Order_date date,
Sales int );

INSERT INTO Products(Order_date,Sales)
VALUES
('2021-01-01',20), ('2021-01-02',32), ('2021-02-08',45), ('2021-02-04',31),
('2021-03-21',33), ('2021-03-06',19), ('2021-04-07',21), ('2021-04-22',10)

select * from products

select extract(year from order_date), to_char(order_date, 'Month'), Sales 
from products
order by sales Desc

------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Q 2. Find the candidates best suited for an open Data Science job. Find candidates who are proficient in Python, SQL, and Power BI.
-- Write a query to list the candidates who possess all of the required skills for the job. Sort the output
-- by candidate ID in ascending order.

CREATE TABLE Applications (
candidate_id int,
skills varchar);

INSERT INTO Applications(candidate_id,skills)
VALUES
(101, 'Power BI'), (101, 'Python'), (101, 'SQL'), (102, 'Tableau'), (102, 'SQL'),
(108, 'Python'), (108, 'SQL'), (108, 'Power BI'), (104, 'Python'), (104, 'Excel')

select * from applications

select candidate_id, count(skills) as Skills_counts
from applications
group by candidate_id
having count(skills) >=3

------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q 3. List all the matches between teams, if matches are played once

CREATE TABLE match ( team varchar(20) )
INSERT INTO match (team) VALUES ('India'), ('Pak'), ('Aus'), ('Eng')

with cte as( 
	select row_number()over(order by team) as id, team 
	from match
)
select a.team as Team_A, b.team as Team_b, a.id, b.id
	from cte as a
	join cte b on a.id <> b.id
	where a.id > b.id

------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q 4. write a query to get the output

CREATE TABLE emp ( ID int, NAME varchar(10) )

INSERT INTO emp (ID, NAME)
VALUES (1,'Emp1'), (2,'Emp2'), (3,'Emp3'), (4,'Emp4'),
(5,'Emp5'), (6,'Emp6'), (7,'Emp7'), (8,'Emp8');

select * from emp

with cte as (
	select concat(id,' ',name), ntile(4) over(order by id asc) as groups
	from emp
)
select string_agg(concat,', '), groups
from cte
group by groups

------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q 5. write a query Make the table short, like distance between Mumbai to Bangalore or Bangalore to Mumbai will be same make them one entry.

create table plane (
	source varchar(20),
	destination varchar(20),
	distance int8
);
insert into plane(source,destination,distance)
values 
('Mumbai','Bangalore', 500),
('Bangalore','Mumbai', 500),
('Delhi','Mathura', 150),
('Mathura','Delhi', 150),
('Nagpur','Pune', 500),
('Pune','Nagpur', 500)

select greatest(source, destination) as source, least(source,destination) as destination, distance 
from plane
group by 1,2,3
