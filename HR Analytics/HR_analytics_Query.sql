-- Importring .csv File
create database hr_database

create table hr_data(
	emp_no int8 primary key,
	gender varchar(50),
	marital_status varchar(50),
	age_band varchar(50),
	age int8,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	business_travel varchar(50),
	employee_count int8,
	attrition varchar(50),
	attrition_label varchar(50),
	job_satisfaction int8,
	active_employee int8
);

copy hr_data(emp_no,gender,marital_status,age_band,age,department,education,education_field,job_role,business_travel,
			 employee_count,attrition,attrition_label,job_satisfaction,active_employee)
from 'D:\hrdata.csv'
delimiter ','
csv header

select * from hr_data

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1.	Employee Count

select count(emp_no) as Employee_count 
from hr_data

-- 2.	Attrition Count

select count(Attrition) as Attrition_count
from hr_data
where attrition = 'Yes'

-- 3.	Attrition Rate

select round(((select count(Attrition) from hr_data where attrition='Yes')/
			  (select sum(employee_count)))*100,2) as Attrition_Rate
from hr_data

-- 4.	Active Employees

select count(active_Employee) as Active_Employees_count
from hr_data
where Active_Employee = 1

-- 5.	Average Age

select round(avg(age),0) as average_age
from hr_data

-- 6.	Attrition by Gender

select gender, count(attrition) as Attrition_count
from hr_data
where attrition = 'Yes'
group by gender


-- 7.	Department-wise Attrition

select Department, count(attrition) as Attrition_count
from hr_data
where attrition = 'Yes'
group by Department

-- 8.	Number of Employees by Age Group

select age_band, sum(employee_count) as Employee_count
from hr_data
group by age_band

-- 9.	Job Satisfaction Ratings

select job_role,
	(case job_satisfaction when 1 then sum(employee_count) end) as "One",
	(case job_satisfaction when 2 then sum(employee_count) end) as "Two",
	(case job_satisfaction when 3 then sum(employee_count) end) as "Three",
	(case job_satisfaction when 4 then sum(employee_count) end) as "Four"
	from hr_data
	group by job_role,job_satisfaction
	order by job_role,job_satisfaction

-- 10.	Education field by Attrition

select education_field, count(attrition) as Attrition_count
from hr_data
where attrition = 'Yes'
group by education_field





