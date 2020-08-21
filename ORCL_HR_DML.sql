-- < 20. 08. 19 >
-- INSERT - VALUES ���� ( ���̺� ���� �÷� ���� )

desc EMPLOYEES;

insert into departments (department_id, department_name, manager_id, location_id)
values(280, 'Play', 100, 1700);

SELECT
    *
FROM departments;

insert into departments(department_id, department_name)
values (290, 'Sleep');

select * from departments;

insert into departments
values (300, 'Home', null, null);

select * from departments;

create table sales_reps         -- sales_reps ���̺� ����
AS (select employee_id id, last_name name, salary, commission_pct -- sales_reps ���̺� id, name, salary, commission_pct �÷�����
from employees      
where 1=2);

DROP TABLE sales_reps;      --���̺� ���� ����

-- < 20. 08. 21 >

INSERT INTO sales_reps(id, name, salary, commission_pct)    -- sales_reps ���̺� id, naem, salary, commission_pct ������ �߰�
    SELECT employee_id,  last_name, salary, commission_pct  -- employee_id,  last_name, salary, commission_pct �÷��� ������ ����
    FROM employees
    WHERE job_id LIKE '%REP%';                              -- job_id�߿��� REP������ ���� �����͵�
    
select * from sales_reps;


-- UPDATE - SET ���� ( ���̺� ���� �÷� ���� ����, ������ ���� )

CREATE TABLE copy_emp   -- �ǽ��� ���̺� ����
AS SELECT * FROM employees;

UPDATE copy_emp
SET department_id = 50
WHERE employee_id = 113;        -- employee_id = 113���� ����� department_id �� 50���� ����

select employee_id, department_id from copy_emp where employee_id = 113;    -- ���� ���� Ȯ��

UPDATE copy_emp
SET department_id = 110;        -- copy_emp ���̺��� ��� ����� department_id�� 110 ���� ����

select employee_id, department_id from copy_emp;        -- ���� ���� Ȯ��

ROLLBACK;           -- ����� ����Ʈ ������ �ǵ���

UPDATE copy_emp
SET job_id = (SELECT job_id
              FROM employees
              WHERE employee_id = 205),
    salary = (SELECT salary
              FROM employees
              WHERE employee_id = 205)
WHERE employee_id = 113;

-- > 113�� �����  job_id, salary�� 205�� �����  job_id, salary�� ����

select employee_id, job_id, salary from copy_emp where employee_id = 205 or employee_id = 113;  -- ���� ���� Ȯ��

-- DELETE ���� (���̺� ���� �÷� ���� ����)

select * from departments;

DELETE FROM departments
WHERE department_name = 'NOC';      -- departments ���̺��� NOC �μ��� ������ �÷���  ������

select count(*) from copy_emp;      -- copy_emp ���̺� ���� �� �÷� ���� Ȯ��

DELETE copy_emp;                --  copy_emp ���̺� ����

select count(*) from copy_emp;      -- copy_emp ���̺� ���� �� �÷� ���� Ȯ��


-- Ʈ����� (Transaction)
--  - ������ �۾�����
--  - ���� DML�� �𿩼� �ϳ��� Ʈ������� ������
--  - DML �۾� �� commit, rollback���� Ʈ����� �����ؾ���.

-- Ʈ����� �����(TCL : Transaction Control Language)
-- COMMIT : ���� ���� Ʈ������� ������ �����ͺ��̽��� ����ϴ� ��ɾ�
--          �̻��ÿ��� �۾����� ȭ�鿡���� ����� ���� ���̰�, ���� �����ͺ��̽����� ����ȵ�
-- ROLLBACK : ���� ���� Ʈ������� ������ ����ϴ� ��ɾ�
-- SAVEPOINT : Ʈ����� ���� �� �ǵ��ư� �� �ִ� ������ �����ϴ� �����

rollback;

UPDATE copy_emp
SET salary = 24000
WHERE employee_id = 113;

SAVEPOINT update_done;

DELETE copy_emp;

ROLLBACK TO SAVEPOINT update_done;

select * from copy_emp;





