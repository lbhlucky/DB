SELECT
    e.employee_id,
    e.last_name,
    e.department_id,
    d.department_id,
    d.department_name,
    d.location_id
FROM
         employees e
    JOIN departments d ON ( e.department_id = d.department_id )
WHERE
    d.location_id = 1700
ORDER BY
    e.department_id DESC;
    
    
    select e.employee_id,e.last_name, e.salary, d.department_id, d.department_name
    from employees e
    join departments d
    on (e.department_id = d.department_id);
    
    select e.last_name "Employee", e.employee_id "Emp#", e.manager_id "Manager", e.manager_id "Mgr#"
    from employees e
    join departments d
    on (d.manager_id = e.employee_id);

    
    select e.last_name "Employee", e.employee_id "Emp#", s.last_name "Manager", e.manager_id "Mgr#"
    from employees e join employees s
    on(e.manager_id = s.employee_id)
    order by e.employee_id asc;
    