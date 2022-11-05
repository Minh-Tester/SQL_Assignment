--1. Create a query that displays the last name and hire date of any employee in the same department as the employee with name = Zlotkey and excluding employee Zlotkey from the result returns.
select last_name, hire_date from employees
where department_id = 80 and last_name != 'Zlotkey '

select e1.last_name, e1.hire_date from employees e1
inner join employees e2 on e1.department_id = e2.department_id
where e1.last_name != 'Zlotkey' and e2.last_name = 'Zlotkey'

select last_name, hire_date from employees where department_id in
(Select department_id from employees where last_name='Zlotkey') and last_name <> 'Zlotkey' 

--2. Create a report that displays the employee number, last name, and salary of all employees who earn more than the average salary. Sort the results in order of ascending salary.
select employee_id, last_name, salary 
from employees 
where salary > (select AVG(salary) from employees)
order by salary asc

--3. Write a query that displays the employee number and last name of all employees who work in a department with any employee whose last name contains the letter “u”
select employee_id, last_name 
from employees
where last_name like '%u%'

--4. The HR department needs a report that displays the last name, department number, and job ID of all employees whose department location ID is 1700.
select e.last_name, e.department_id, e.job_id from employees e
inner join departments d on e.department_id = d.department_id
where d.location_id = 1700

select last_name, department_id, job_id from employees where department_id in
(select department_id from departments where location_id = 1700)

--5. Create a report for HR that displays the last name and salary of every employee who reports to King.
select last_name, salary from employees
where manager_id in ( select employee_id from employees where last_name = 'King')

select last_name, salary from employees
where manager_id in ( 156, 100)

--6. Create a report for HR that displays the department number, last name, and job ID for every employee in the Executive department.
select e.department_id, e.last_name, e.job_id from employees e
join departments d on e.department_id = d.department_id
where department_name = 'Executive'

select department_id, last_name, job_id from employees
where department_id in (select department_id from departments where department_name ='Executive')

--7. Create query to display the employee number, last name, and salary of all the employees who earn more than the average salary and who work in a department with any employee whose last name contains a letter “u”.
select employee_id, last_name, salary from employees
where salary > (select AVG(salary) from employees) or last_name like '%u%'

select employee_id, last_name, salary from employees
where salary > (select AVG(salary) from employees)
union
select employee_id, last_name, salary from employees
where last_name like '%u%'

--8. Find the highest, lowest, sum, and average salary of all employees. Label the columns as Maximum, Minimum, Sum, and Average, respectively. Round your results to the nearest whole number
select Round(MAX(salary),0) as Maximum,
Round(MIN(salary),0) as Minimum,
round(SUM(salary),0) as Sum,
round(AVG(salary),0) as Average
from employees

--9. Write a query that displays the last name (with the first letter in uppercase and all the other letters in lowercase) and the length of the last name for all employees whose name starts with the letters “J,” “A,” or “M.” Give each column an appropriate label. Sort the results by the employees’ last names.
select upper(left(last_name,1)) + SUBSTRING(last_name,2, LEN(last_name)) as First_Name, 
len(last_name) as Length_of_Last_Name
from employees
where last_name like 'J%'
or last_name like 'A%'
or last_name like 'M%'
order by last_name

--10. The HR department needs a report to display the employee number, last name, salary, and salary increased by 15.5% (expressed as a whole number) for each employee. Label the column New Salary
select employee_id, last_name, salary, round((salary*1.155),0) as "new salary" 
from employees

--11.The HR department needs a report with the following specifications:
--	Last name and department ID of all employees from the employees table, regardless of whether or not they belong to a department
--	Department ID and department name of all departments from the departments table, regardless of whether or not they have employees working in them. 
--  Write a compound query to accomplish this.
select last_name, department_id, CAST(NULL as varchar(30))
from employees
union
select CAST(NULL as varchar(25)), department_id, department_name
from departments

--12. Produce a list of employees who joined the company later than their manager and who work in Toronto. Display the employee_id by using the set operators. 
SELECT * FROM employees  
WHERE department_id = 
(SELECT department_id  
FROM departments 
WHERE location_id = 
(SELECT location_id 
FROM locations  
WHERE city ='Toronto'));
