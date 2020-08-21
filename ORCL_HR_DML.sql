-- < 20. 08. 19 >
-- INSERT - VALUES 구문 ( 테이블 내의 컬럼 생성 )

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

create table sales_reps         -- sales_reps 테이블 생성
AS (select employee_id id, last_name name, salary, commission_pct -- sales_reps 테이블에 id, name, salary, commission_pct 컬럼생성
from employees      
where 1=2);

DROP TABLE sales_reps;      --테이블 삭제 구문

-- < 20. 08. 21 >

INSERT INTO sales_reps(id, name, salary, commission_pct)    -- sales_reps 테이블에 id, naem, salary, commission_pct 데이터 추가
    SELECT employee_id,  last_name, salary, commission_pct  -- employee_id,  last_name, salary, commission_pct 컬럼의 데이터 복사
    FROM employees
    WHERE job_id LIKE '%REP%';                              -- job_id중에서 REP패턴을 가진 데이터들
    
select * from sales_reps;


-- UPDATE - SET 구문 ( 테이블 내의 컬럼 내용 수정, 여래개 가능 )

CREATE TABLE copy_emp   -- 실습용 테이블 생성
AS SELECT * FROM employees;

UPDATE copy_emp
SET department_id = 50
WHERE employee_id = 113;        -- employee_id = 113번인 사람의 department_id 를 50으로 변경

select employee_id, department_id from copy_emp where employee_id = 113;    -- 변경 내용 확인

UPDATE copy_emp
SET department_id = 110;        -- copy_emp 테이블의 모든 사람의 department_id를 110 으로 변경

select employee_id, department_id from copy_emp;        -- 변경 내용 확인

ROLLBACK;           -- 실행시 디폴트 값으로 되돌림

UPDATE copy_emp
SET job_id = (SELECT job_id
              FROM employees
              WHERE employee_id = 205),
    salary = (SELECT salary
              FROM employees
              WHERE employee_id = 205)
WHERE employee_id = 113;

-- > 113번 사원의  job_id, salary를 205번 사원의  job_id, salary로 변경

select employee_id, job_id, salary from copy_emp where employee_id = 205 or employee_id = 113;  -- 변경 내용 확인

-- DELETE 구문 (테이블 내의 컬럼 내용 삭제)

select * from departments;

DELETE FROM departments
WHERE department_name = 'NOC';      -- departments 테이블의 NOC 부서의 데이터 컬럼을  삭제함

select count(*) from copy_emp;      -- copy_emp 테이블 삭제 전 컬럼 갯수 확인

DELETE copy_emp;                --  copy_emp 테이블 삭제

select count(*) from copy_emp;      -- copy_emp 테이블 삭제 후 컬럼 갯수 확인


-- 트랜잭션 (Transaction)
--  - 논리적인 작업단위
--  - 여러 DML이 모여서 하나의 트랜잭션이 구성됨
--  - DML 작업 후 commit, rollback으로 트랜잭션 종료해야함.

-- 트랜잭션 제어어(TCL : Transaction Control Language)
-- COMMIT : 진행 중인 트랜잭션의 내용을 데이터베이스에 기록하는 명령어
--          미사용시에는 작업중인 화면에서만 변경된 값이 보이고, 실제 데이터베이스에는 저장안됨
-- ROLLBACK : 진행 중인 트랜잭션의 내용을 취소하는 명령어
-- SAVEPOINT : 트랜잭션 진행 중 되돌아갈 수 있는 지점을 생성하는 명려어

rollback;

UPDATE copy_emp
SET salary = 24000
WHERE employee_id = 113;

SAVEPOINT update_done;

DELETE copy_emp;

ROLLBACK TO SAVEPOINT update_done;

select * from copy_emp;





