create database project;
use project;

DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Employee_Log;

CREATE TABLE Department (
    Deptno INT Not null PRIMARY KEY default 0,
    Dname VARCHAR(14),
    Loc VARCHAR(13)
);

INSERT INTO Department (Deptno, Dname, Loc) VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

CREATE TABLE Employee (
    Empno INT NOT NULL PRIMARY KEY DEFAULT 0,
    Ename VARCHAR(10),
    Job VARCHAR(9),
    Mgr INT,
    Hiredate DATE,
    Sal DECIMAL(7,2),
    Comm DECIMAL(7,2),
    Deptno INT,
    FOREIGN KEY (Deptno) REFERENCES Department(Deptno) 
);

INSERT INTO Employee (Empno, Ename, Job, Mgr, Hiredate, Sal, Comm, Deptno) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800.00, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-06-11', 3000.00, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-08-09', 1500.00, 0.00, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-07-13', 1100.00, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-03-12', 950.00, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-03-12', 3000.00, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, 2000, 10);

CREATE TABLE Student (
    Rno INT NOT NULL PRIMARY KEY DEFAULT 0,
    Sname VARCHAR(14),
    City VARCHAR(20),
    State VARCHAR(20)
);

INSERT INTO Student (Rno, Sname, City, State)
VALUES (1, 'Rahul Sharma', 'Mumbai', 'Maharashtra'),
(2, 'Anjali Verma', 'Lucknow', 'Uttar Pradesh'),
(3, 'Amit Kumar', 'Patna', 'Bihar'),
(4, 'Neha Singh', 'Jaipur', 'Rajasthan'),
(5, 'Vikram Joshi', 'Indore', 'Madhya Pradesh'),
(6, 'Pooja Mehta', 'Ahmedabad', 'Gujarat');

CREATE TABLE Employee_Log (
    Emp_id INT NOT NULL,
    Log_date DATETIME default current_timestamp,
    New_salary INT,
    Action VARCHAR(20) default 'New Salary'
);

INSERT INTO Employee_Log (Emp_id, Log_date, New_salary, Action) 
VALUES  (7369, '2025-08-01', 1200, 'Salary Update'),
(7499, '2025-08-05', 1800, 'Promotion'),
(7654, '2025-08-07', 1500, 'Annual Review'),
(7521, '2025-08-10', NULL, 'Leave'),
(7900, '2025-08-11', 1000, 'Salary Update'),
(7788, NULL, NULL, NULL);

## Q-1.Select unique job from EMP table.

select distinct job from employee;

## Q-2. List the details of the emps in asc order of the Dptnos and desc of Jobs?

select * from employee
order by deptno;

select * from employee
order by job desc;

## Q-3. Display all the unique job groups in the descending order?

select distinct job from employee
order by job desc;

## Q-4. List the emps who joined before 1981.

select * from employee
where hiredate < "1981-01-01";

## 5. List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal

select Empno, 
     Ename, 
     Sal,
     sal*12 as Annsal 
     from employee
     order by Annsal;


## 6. List the Empno, Ename, Sal, Exp of all emps working for Mgr 7698.

select empno,
       ename,
	   sal,
       hiredate 
from employee
where Mgr = 7698;


## 7. Display all the details of the emps who’s Comm. Is more than their Sal?

select * from employee
where Comm > sal;

## 8. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.

select * from employee
where job = "Clerk" or job = "Analyst"
order by job desc;

## 9. List the emps Who Annual sal ranging from 22000 and 45000.

select * from employee
where (sal*12) >= 22000 and (sal*12)<= 45000; 

## 10. List the Enames those are starting with ‘S’ and with five characters.

select * from employee
where Ename like "S____";

## 11. List the emps whose Empno not starting with digit78.

select * from employee
where Empno not like "78%";

## 12. List all the Clerks of Deptno 20.

select * from employee
where job = "Clerk" and Deptno = 20;

## 13. List the Emps who are senior to their own MGRS.

select * from employee
where Empno < mgr;

## 14. List the Emps of Deptno 20 who’s Jobs are same as Deptno10.

select E1.* 
from employee E1
join employee E2
on E1.job = E2.job
where E1.Deptno = 20 and E2.Deptno = 10;

## 15. List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal.

Select E1.* 
from employee E1
join Employee E2
on E1.sal = E2.Sal
where E2.Ename  in ("Ford","Smith")
order by E1.sal desc;

## 16. List the emps whose jobs same as SMITH or ALLEN.

Select E1.*
from employee E1
join Employee E2
on E1.job = E2.job
where E2.Ename in ("Smith","Allen");


## 17. Any jobs of deptno 10 those that are not found in deptno 20.

select * from employee
where deptno = 10 and job not in (select job from employee where deptno = 20); 

## 18. Find the highest sal of EMP table.

select max(sal) as highest_salary from employee;


## 19. Find details of highest paid employee.

select * from employee
order by sal desc
limit 1;

## 20. Find the total sal given to the MGR.

select sum(sal) as Total_sal from employee
where job = "Manager";

## 21. List the emps whose names contains ‘A’.

select * from employee
where Ename like "%A%";

## 22. Find all the emps who earn the minimum Salary for each job wise in ascending order.

select min(sal) as min_sal from employee
group by job
order by min_sal;

## 23. List the emps whose sal greater than Blake’s sal.

select * from employee
where sal > (select sal from employee where Ename = "Blake");

## 24. Create view v1 to select ename, job, dname, loc whose deptno are same.

create view V1 as
select department.dname,
	department.loc,
    employee.ename,
    employee.job
from department
left join employee
on employee.deptno = department.deptno;

## 25. Create a procedure with dno as input parameter to fetch ename and dname.

delimiter $$
create procedure Fetch_data(in A int)
begin
     select employee.Ename,
            department.dname
	from department
    left join employee
    on employee.deptno = department.deptno
    where employee.Deptno = A;
end $$
delimiter ;

call Fetch_data(20);

## 26. Add column Pin with bigint data type in table student.

Alter table student
add Pin bigint;

select * from student;

## 27. Modify the student table to change the sname length from 14 to 40.

alter table student
modify column sname varchar(40);

## 28. Create trigger to insert data in emp_log table whenever any update of sal in EMP table. You can set action as ‘New Salary’.
 
 Delimiter $$
 create trigger new_sal
 after insert on employee
 for each row
 begin
       insert into Employee_Log (Emp_id, Log_date,New_salary, Action) 
       values (new.empno, default , new.sal, default);
 end $$
 Delimiter ;
 
 insert into employee
 values (7901, 'Christian', 'CEO', 7782, '2014-01-23', 15000.00, 5000, 20);
 
 select * from Employee_Log;