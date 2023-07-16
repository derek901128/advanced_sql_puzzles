with 
employees(
    employee_id,
    manager_id,
    job_title
) as (
    select 1001, null, 'president' from dual union all
    select 2002, 1001, 'director' from dual union all
    select 3003, 1001, 'office manager' from dual union all
    select 4004, 2002, 'engineer' from dual union all
    select 5005, 2002, 'engineer' from dual union all
    select 6006, 2002, 'engineer' from dual
),
find_depth(
    employee_id,
    manager_id,
    job_title,
    depth
) as (
    select 
        employee_id, 
        manager_id, 
        job_title, 
        0
    from   
        employees
    where
        manager_id is null
    union all
    select 
        e.employee_id,
        fd.employee_id,
        e.job_title,
        fd.depth + 1
    from 
        find_depth fd
    join
        employees e
    on
        fd.employee_id = e.manager_id 
)
select * from find_depth;