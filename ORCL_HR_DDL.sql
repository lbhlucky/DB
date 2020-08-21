-- <20. 08. 21>

-- DDL 구문의 종류
--  1) CREATE : 새로운 오브젝트의 구조를 정의
--  2) ALTER : 기존 오브젝트의 구조를 변형
--  3) DROP : 기존 오브젝트를 삭제
--  4) RENAME : 기존 오브젝트의 이름을 변경
--  5) TRUNCATE : 테이브르이 데이터를 절단 

CREATE TABLE dept
            (deptno NUMBER(2),
            dname VARCHAR2 (14),
            loc VARCHAR2(13),
            create_date DATE DEFAULT SYSDATE);
            
desc dept;

insert into dept(deptno, dname, loc)
values (10, 'BOB', 200);

select * from dept;

-- 제약 조건!!
--  1) Primary key
--  2) Foreign key 
--  3) Unique
--  4) Not Null
--  5) Check

-- 제약 조건 선언 방식
-- 1) Not Null : null값 허용하지 않음, 컬럼레벨의 문법만 사용가능
desc departments;

create table test1      -- 실습예제 test1 테이블 생성
( id number(10) constraint t1_id_nn not null,
 name varchar2(30) constraint t1_name_nn not null,
 job varchar2(20),
 email varchar2(20),
 phone varchar2(20) constraint t1_ph_nn not null,
 start_date date );
 
 desc test1;

--  2) Unique : 중복 값을 허용하지 않음, 컬럼레벨문법과 테이블레벨 문법 둘 다 사용가능
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



