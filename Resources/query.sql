----Inserting data to various tables in Employee Database----
---1. Copying data to employees table
COPY employees FROM 'C:\Users\indum\OneDrive\Documents\SQL-Challenge\data\employees.csv' DELIMITER ',' CSV HEADER;

---Viewing the table
select * from employees limit 5;

---2.Copying data to departments table
COPY departments FROM 'C:\Users\indum\OneDrive\Documents\SQL-Challenge\data\departments.csv' DELIMITER ',' CSV HEADER;

---Viewing the table
select * from departments;

---3.Copying data to dept_emp table
COPY dept_emp FROM 'C:\Users\indum\OneDrive\Documents\SQL-Challenge\data\dept_emp.csv' DELIMITER ',' CSV HEADER;

---Viewing the table
select * from dept_emp limit 5;

---4.Copying data to dept_manager table
COPY dept_manager FROM 'C:\Users\indum\OneDrive\Documents\SQL-Challenge\data\dept_manager.csv' DELIMITER ',' CSV HEADER;

---Viewing the table
select * from dept_manager limit 5;

---5.Copying data to titles table
COPY titles FROM 'C:\Users\indum\OneDrive\Documents\SQL-Challenge\data\titles.csv' DELIMITER ',' CSV HEADER;

---Viewing the table
select * from titles limit 5;

---6.Copying data to salaries table
COPY salaries FROM 'C:\Users\indum\OneDrive\Documents\SQL-Challenge\data\salaries.csv' DELIMITER ',' CSV HEADER;

---Viewing the table
select * from salaries limit 5;

-----------------------------------Data Analysis----------------
-----1. List the following details of each employee: employee number, last name, first name, gender, and salary.
select e.emp_no AS "Employee Number", e.last_name AS "Last Name",e.first_name AS "First Name",e.gender AS "Gender",s.salary AS "Salary"
		from employees e
		left join salaries s ON e.emp_no = s.emp_no;
		


-----2. List employees who were hired in 1986.
select * 
		from employees 
		where extract(YEAR from hire_date) = 1986;
		
----3. List the manager of each department with the following information: department number, department name, 
----the manager's employee number, last name, first name, and start and end employment dates.
select d.dept_no AS "Department Number", d.dept_name AS "Department Name", dm.emp_no AS "Mgr Employee Number",
		e.last_name AS "Mgr Last Name",e.first_name AS "Mgr First Name",dm.from_date AS "Start Date",dm.to_date AS "End Date"
		from departments d
		left join dept_manager dm ON d.dept_no=dm.dept_no AND extract(year from to_date)=9999
		left join employees e ON dm.emp_no=e.emp_no;


-----4. List the department of each employee with the following information: employee number, last name, first name, and department name.
select e.emp_no ,e.last_name,e.first_name,d.dept_name
		from employees e
		left join dept_emp de ON e.emp_no=de.emp_no AND extract(year from to_date)=9999
		right join departments d ON de.dept_no=d.dept_no;
		
----5. List all employees whose first name is "Hercules" and last names begin with "B."
select * 
		from employees
		where first_name='Hercules' AND last_name LIKE 'B%';

----6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
----This list includes only those employees who are still working in the Sales department and not previously worked.
select de.emp_no AS "Employee Number",e.last_name AS "Last Name",e.first_name AS "First Name",d.dept_name AS "Department Name"
		from dept_emp de 
		inner join employees e ON de.emp_no=e.emp_no AND extract(year from de.to_date)=9999
		inner join departments d ON de.dept_no=d.dept_no AND d.dept_name='Sales';

----7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select de.emp_no AS "Employee Number",e.last_name AS "Last Name",e.first_name AS "First Name",d.dept_name AS "Department Name"
		from dept_emp de 
        inner join employees e ON de.emp_no=e.emp_no AND extract(year from de.to_date)=9999
		inner join departments d ON de.dept_no=d.dept_no AND d.dept_name IN ('Sales','Development');
	        
----8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name AS "Employee Last Name", count(last_name) AS "Count"
		from employees e
		group by last_name
		order by "Count" DESC;
										