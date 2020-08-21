-- <20. 08. 21>

-- DDL ������ ����
--  1) CREATE : ���ο� ������Ʈ�� ������ ����
--  2) ALTER : ���� ������Ʈ�� ������ ����
--  3) DROP : ���� ������Ʈ�� ����
--  4) RENAME : ���� ������Ʈ�� �̸��� ����
--  5) TRUNCATE : ���̺긣�� �����͸� ���� 

CREATE TABLE dept
            (deptno NUMBER(2),
            dname VARCHAR2 (14),
            loc VARCHAR2(13),
            create_date DATE DEFAULT SYSDATE);
            
desc dept;

insert into dept(deptno, dname, loc)
values (10, 'BOB', 200);

select * from dept;

-- ���� ����!!
--  1) Primary key
--  2) Foreign key 
--  3) Unique
--  4) Not Null
--  5) Check

-- ���� ���� ���� ���
-- 1) Not Null : null�� ������� ����, �÷������� ������ ��밡��
desc departments;

create table test1      -- �ǽ����� test1 ���̺� ����
( id number(10) constraint t1_id_nn not null,
 name varchar2(30) constraint t1_name_nn not null,
 job varchar2(20),
 email varchar2(20),
 phone varchar2(20) constraint t1_ph_nn not null,
 start_date date );
 
 desc test1;

--  2) Unique : �ߺ� ���� ������� ����, �÷����������� ���̺��� ���� �� �� ��밡��
create table test2
( id number(10) constraint t2_id_nn not null
                constraint t2_id_uk unique,
 name varchar2(30) constraint t2_name_nn not null,
 job varchar2(20),
 email varchar2(20),
 phone varchar2(20) constraint t2_ph_nn not null
                    constraint t2_ph_uk unique,
start_date date,
constraint t2_email_uk unique(email));

desc test2;

select constraint_name, constraint_type
from user_constraints
where table_name = 'TEST2';



