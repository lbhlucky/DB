-- <20. 08.26 >

-- View, Sequence, Index, Synonym

--1. View - 가상의 논리적인 테이블, 다른 테이블의 데이터를 빌려와서 출력함
        --  자주 쓰는 데이터 구조를 가상으로 만들어서 사용
        --  마치 테이블처럼 사용할 수 있도록 이름을 붙여줌
        --  보안성 때문에 사용함
    
    -- OR REPLACE 기존 동일한 이름의 뷰가 있는 경우 새롭게 정의하는 뷰의 내용을 갱신하는 키워드
    -- FORCE 베이스테이블이 없는 경우에도 뷰를 생성할 수 있게 해주는 키워드
    -- NOFORCE 베이스테이블이 있어야 뷰가 생성되는 키워드로 기본값임!!
        
        
--  1) 뷰 생성(CREATE VIEW)
create view empvu80 -- 새로만들 뷰의 이름
as select employee_id, last_name, salary    -- 무조건 서브쿼리문이 사용되기 때문에 'AS' 필수!!
from employees
where department_id = 80;
-- >> 호출시 서브쿼리문을 자동적으로 실행됨

desc empvu80;   
select * from empvu80;

update employees
set salary = 20000
where last_name = 'Russell';    -- base table인 employees테이블의 Russell의 salary값을 변경

select * from empvu80;  -- base table의 데이터를 수정해도 view태그도 갱신이 됨

create view salvu50
as select employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY
from employees
where department_id = 50;

desc salvu50;
SELECT * FROM salvu50;

-- 뷰 수정 (CREATE [OR REPLACE] VIEW)
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

-- base table = 1개 일경우 => simple table 이라고 하며, group by 사용 불가
-- base table > 1개 일경우 => complex table 이라고 하며, group by 사용 가능

desc salvu50;

CREATE VIEW empvu50
AS SELECT employee_id, last_name
FROM employees
WHERE department_id = 50;

INSERT INTO empvu50
VALUES (300, 'KIM');    -- 오류 발생 !!! : base table의 제약조건과 같기 때문에 다른 테이블도 추가해야함

desc employees

-- 뷰 삭제
drop view empvu80;

-- 2. Sequence : 숫자 생성기, 6가지 옵션을 이용해

--  1) 시퀀스 생성(create sequence)
create sequence dept_deptid_seq
                increment by 10
                start with 120
                maxvalue 9999
                nocache
                nocycle;

--  2) 시퀀스 사용(시퀀스명.nextval, 시퀀스명.currval)
select dept_deptid_seq.nextval  -- 다음 순서값 호출하고 싶을 때
from dual;

select dept_deptid_seq.currval  -- 마지막 순서값 호출하고 싶을 때
from dual;

insert into departments (department_id, department_name)
values (DEPT_DEPTID_SEQ.nextval, concat('우리집', dept_deptid_seq.currval));

select * from departments;

--  3) 시퀀스 수정(alter sequence)
    -- start with 를 제외한 나머지 옵션은 수정가능

--  4) 시퀀스 삭제(drop sequence)
drop sequence dept_deptid_seq; 

-- 3. Index : 책의 마지막에 있는 색인과 같은 역할

--  1) 생성
create index emp_last_name_idx
on employees(last_name);

--  2) 삭제
drop index emp_last_name_idx;

-- 4. Synonym   : 객체에 다른 이름(별명) 부여

--  1) 생성
create synonym d_sum
for dept_sum_vu;
--  2) 삭제
drop synonym d_sum;