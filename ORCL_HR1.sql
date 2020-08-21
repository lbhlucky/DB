select employee_id,
last_name, manager_id
from employees;

select worker.employee_id, worker.last_name, worker.manager_id, 
    manager.employee_id, manager.last_name 
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select e.last_name Employee, e.employee_id Emp#,
        m.last_name Manager, m.employee_id Mgr#
from employees e join employees m
on e.manager_id = m.employee_id
order by e.employee_id asc;

select e.last_name Employee, 
        e.employee_id Emp#,
        m.last_name Manager,
        e.manager_id Mgr#
from employees e join employees m
on e.manager_id = m.employee_id
order by e.employee_id asc; 

SELECT e.employee_id, d.department_id, d.department_name,
        d.location_id, l.city, l.country_id, c.country_name,
        c.region_id, r.region_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
JOIN countries c
ON l.country_id = c.country_id
JOIN regions r
ON c.region_id = r.region_id;

SELECT employee_id, department_id, department_name
FROM employees 
natural JOIN departments
natural JOIN locations
natural JOIN countries;

select employee_id, last_name, salary
from employees
where salary IN (select salary
                from employees
                where last_name = 'King'
                );


select last_name, job_id, salary
from employees
where salary = ( select min(salary)
                from employees);
                
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50);
                    
select a.last_name, a.salary, a.department_id, b.salavg
from employees a join (select department_id, avg(salary) salavg from employees group by department_id) b
on a.department_id = b.department_id
and a.salary > b.salavg;
                    
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary) from employees)
order by salary asc;



