task 10 {task 11 @ 89 and task 12 @ 151}
1. Write a PL/SQL code to retrieve the employee name, join date and designation from employee
database of an employee whose number is input by the user.
Aim: To write a PL/SQL code to retrieve the employee name, join date and designation from
employee database of an employee whose number is input by the user.
Program:
/*Employee details*/
DECLARE
v_name varchar2(25);
v_joindate date;
v_dsgn employees.job_id%type;
BEGIN
select last_name,hire_date,job_id into v_name,v_joindate,v_dsgn from employees where
employee_id=&id;
DBMS_OUTPUT.PUT_LINE('Name:'||v_name||' Join Date:'||v_joindate||' Designation:'||v_dsgn);
END;
/

2. Write a PL/SQL code to calculate tax for an employee of an organization.
Aim: To write a PL/SQL code to calculate tax for an employee of an organization.
Program:
/*Calculate Tax*/
DECLARE
v_sal number(8);
v_tax number(8,3);
v_name varchar2(25);
BEGIN
select salary,last_name into v_sal,v_name from employees where employee_id=&id;
if v_sal<10000 then
v_tax:=v_sal*0.1;
elsif v_sal between 10000 and 20000 then
v_tax:=v_sal*0.2;
else
v_tax:=v_sal*0.3;
END IF;
DBMS_OUTPUT.PUT_LINE('Name:'||v_name||' Salary:'||v_sal||'Tax:'||v_tax);
END;
/

3. Write a PL/SQL program to display top 10 employee details based on salary using cursors.
Aim: To write a PL/SQL program to display top 10 employee details based on salary using
cursors.
Program:
/*Top 10 salary earning employee details*/
DECLARE
cursor c_emp_cursor is select employee_id, last_name, salary from employees order by salary
desc;
v_rec c_emp_cursor%rowtype;
v_i number(3):=0;
BEGIN
open c_emp_cursor;
loop
v_i:=v_i+1;
fetch c_emp_cursor into v_rec;
exit when v_i>10;
DBMS_OUTPUT.PUT_LINE(v_rec.employee_id||' '||v_rec.last_name||' '||v_rec.salary);
END LOOP;
close c_emp_cursor;
END;
/

4. Write a PL/SQL program to update the commission values for all employees with salary less
than 2000 by adding 1000 to existing employees.
Aim: To write a PL/SQL program to update the commission values for all employees with
salary less than 2000 by adding 1000 to existing employees.
Program:
/*Updation*/
declare
cursor c_emp is select salary,commission_pct from employees;
v_emp c_emp%rowtype;
v_temp number(7,2);
v_temp1 number;
BEGIN
open c_emp;
loop
fetch c_emp into v_emp;
exit when c_emp%notfound;
v_temp1:=v_emp.commission_pct;
v_temp:=(v_emp.salary*v_emp.commission_pct)+1000;
v_temp:=v_temp/v_emp.salary;
if(v_emp.salary<2000) then
update employees set commission_pct=v_temp where employee_id=v_temp.employee_id;
end if;
DBMS_OUTPUT.PUT_LINE('Commission % updated from '||v_temp1||' to '||v_temp);
end loop;
END;
/

task 11
1. Write a trigger on employee table that shows the old and new values of name after updating
on Employee name.
Aim: Write a trigger on employee table that shows the old and new values of name after
updating on Employee name.
Program:
create or replace trigger t_emp_name after update of last_name on salary_table FOR EACH
ROW
begin
DBMS_OUTPUT.PUT_LINE('Name updated from '||:OLD.last_name||' to '||:NEW.last_name);
END;
/
2. Write a PL/SQL procedure for inserting, deleting and updating in employee table.
Aim: To Write a PL/SQL procedure for inserting, deleting and updating in employee table.
Program:
create or replace procedure proc_dml (p_id emp.employee_id%type, p_sal number,p_case
number) is
BEGIN
case p_case
when 1 then
DBMS_OUTPUT.PUT_LINE('Insertion...');
insert into emp(employee_id,last_name,email,hire_date,job_id)
values(p_id,'Franco',’FJames’,'12-JAN-02','ST_CLERK');
when 2 then
DBMS_OUTPUT.PUT_LINE('Deletion...');
delete from emp where employee_id=p_id;
when 3 then
DBMS_OUTPUT.PUT_LINE('Updation...');
update emp set salary=p_sal where employee_id=p_id;
end case;
DBMS_OUTPUT.PUT_LINE('DML operation performed on '||SQL%rowcount||' rows');
END;
/
DECLARE
v_id employees.employee_id%type:=&id;
v_sal employees.salary%type:=&sal;
v_case number:=&case1or2or3;
begin
proc_dml(v_id,v_sal,v_case);
END;
/
3. Write a PL/SQL function that accepts the department number and returns the totalsalary of
thedepartment.
Aim: To write a PL/SQL function that accepts the department number and returns the total
salaryof the department.
Program:
create function func_dept (p_dept number) return number is
v_total number;
BEGIN
select sum(salary) into v_total from employees where department_id=p_dept;
return v_total;
END;
/
DECLARE
v_dept number:=&department_id;
v_total number;
BEGIN
v_total:=func_dept(v_dept);
DBMS_OUTPUT.PUT_LINE('Totalsalary in Department '||v_dept||' is '||v_total);
END;
/

task 12
1. Write a PL/SQL program to handle predefined exceptions.
Aim: To Write a PL/SQL program to handle predefined exceptions.
Program:
declare
v_id number(6):=&employee_id;
v_sal employees.salary%type;
v_name employees.last_name%type;
v_job employees.job_id%type;
begin
select last_name, salary into v_name, v_sal from employees where employee_id=v_id;
DBMS_OUTPUT.PUT_LINE(v_name||q'['s salary is ]'||v_sal);
select job_id into v_job from employees where last_name=v_name;
DBMS_OUTPUT.PUT_LINE(v_name||q'['s job is ]'||v_job);
EXCEPTION
when no_data_found then
DBMS_OUTPUT.PUT_LINE('No employee with ID:'||v_id);
when too_many_rows then
DBMS_OUTPUT.PUT_LINE('Many employees with Name:'||v_name);
when others then
DBMS_OUTPUT.PUT_LINE('Some other error occured');
end;
/
2. Write a PL/SQL program to handle user defined exception.
Aim: To Write a PL/SQL program to handle user defined exception.
Program:
DECLARE
v_dept number:=&department_id;
e_nodept exception;
BEGIN
update employees set salary=salary+1050 where department_id=v_dept;
IF SQL%notfound then
raise e_nodept;
ELSE
DBMS_OUTPUT.PUT_LINE(SQL%rowcount||' rows updated');
END IF;
EXCEPTION
when e_nodept then
DBMS_OUTPUT.PUT_LINE('No Department with ID:'||v_dept)
END;
/
3. Write a PL/SQL code to create
Aim: To write a program on package Specification and body part.
a) Package specification.
Program:
create or replace package pack_dml is
procedure proc_dml(p_id number,choice number);
END pack_dml;
/
b) Package body for the insert, retrieve, update and delete operations on e m p table.
Program:
create or replace package body pack_dml is
procedure proc_dml(p_id number,choice number) is
v_name varchar2(20);
v_total number;
BEGIN
case choice
when 1 then
DBMS_OUTPUT.PUT_LINE('Insertion...');
insert into student values(p_id,'Franco',90);
when 2 then
DBMS_OUTPUT.PUT_LINE('Deletion...');
delete from student where sid=p_id;
when 3 then
DBMS_OUTPUT.PUT_LINE('Updation...');
update student set total=total+1 where sid=p_id;
when 4 then
select sname,total into v_name,v_total from student where sid=p_id;
DBMS_OUTPUT.PUT_LINE('Total marks of '||v_name||' is '||v_total);
end case;
DBMS_OUTPUT.PUT_LINE('DML operation performed on '||SQL%rowcount||' rows');
END proc_dml;
END pack_dml;
/
BEGIN
pack_dml.proc_dml(&StudentID,&choice1or2or3or4);
END;
/
