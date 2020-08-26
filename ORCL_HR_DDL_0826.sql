-- <20. 08.26 >

-- View, Sequence, Index, Synonym

--1. View - ������ ������ ���̺�, �ٸ� ���̺��� �����͸� �����ͼ� �����
        --  ���� ���� ������ ������ �������� ���� ���
        --  ��ġ ���̺�ó�� ����� �� �ֵ��� �̸��� �ٿ���
        --  ���ȼ� ������ �����
    
    -- OR REPLACE ���� ������ �̸��� �䰡 �ִ� ��� ���Ӱ� �����ϴ� ���� ������ �����ϴ� Ű����
    -- FORCE ���̽����̺��� ���� ��쿡�� �並 ������ �� �ְ� ���ִ� Ű����
    -- NOFORCE ���̽����̺��� �־�� �䰡 �����Ǵ� Ű����� �⺻����!!
        
        
--  1) �� ����(CREATE VIEW)
create view empvu80 -- ���θ��� ���� �̸�
as select employee_id, last_name, salary    -- ������ ������������ ���Ǳ� ������ 'AS' �ʼ�!!
from employees
where department_id = 80;
-- >> ȣ��� ������������ �ڵ������� �����

desc empvu80;   
select * from empvu80;

update employees
set salary = 20000
where last_name = 'Russell';    -- base table�� employees���̺��� Russell�� salary���� ����

select * from empvu80;  -- base table�� �����͸� �����ص� view�±׵� ������ ��

create view salvu50
as select employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY
from employees
where department_id = 50;

desc salvu50;
SELECT * FROM salvu50;

-- �� ���� (CREATE [OR REPLACE] VIEW)
create or replace view empvu80 (id_number, name, sal, department_id)
as select employee_id, first_name || ' ' || last_name, salary, department_id
from employees
where department_id = 80;

select * from empvu80;

create or replace view dept_sum_vu(name, minsal, maxsal, avgsal)
as select d.department_name, MIN(e.salary), MAX(e.salary), AVG(e.salary)
from employees e join departments d
on (e.department_id = d.department_id)
group by d.department_name;

desc dept_sum_vu;
select * from dept_sum_vu;

-- base table = 1�� �ϰ�� => simple table �̶�� �ϸ�, group by ��� �Ұ�
-- base table > 1�� �ϰ�� => complex table �̶�� �ϸ�, group by ��� ����

desc salvu50;

CREATE VIEW empvu50
AS SELECT employee_id, last_name
FROM employees
WHERE department_id = 50;

INSERT INTO empvu50
VALUES (300, 'KIM');    -- ���� �߻� !!! : base table�� �������ǰ� ���� ������ �ٸ� ���̺� �߰��ؾ���

desc employees

-- �� ����
drop view empvu80;

-- 2. Sequence : ���� ������, 6���� �ɼ��� �̿���

--  1) ������ ����(create sequence)
create sequence dept_deptid_seq
                increment by 10
                start with 120
                maxvalue 9999
                nocache
                nocycle;

--  2) ������ ���(��������.nextval, ��������.currval)
select dept_deptid_seq.nextval  -- ���� ������ ȣ���ϰ� ���� ��
from dual;

select dept_deptid_seq.currval  -- ������ ������ ȣ���ϰ� ���� ��
from dual;

insert into departments (department_id, department_name)
values (DEPT_DEPTID_SEQ.nextval, concat('�츮��', dept_deptid_seq.currval));

select * from departments;

--  3) ������ ����(alter sequence)
    -- start with �� ������ ������ �ɼ��� ��������

--  4) ������ ����(drop sequence)
drop sequence dept_deptid_seq; 

-- 3. Index : å�� �������� �ִ� ���ΰ� ���� ����

--  1) ����
create index emp_last_name_idx
on employees(last_name);

--  2) ����
drop index emp_last_name_idx;

-- 4. Synonym   : ��ü�� �ٸ� �̸�(����) �ο�

--  1) ����
create synonym d_sum
for dept_sum_vu;
--  2) ����
drop synonym d_sum;