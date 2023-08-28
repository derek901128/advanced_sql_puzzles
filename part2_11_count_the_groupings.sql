with
base
(
    step_number,
    status
) as 
(
    select 1, 'passed' from dual union all
    select 2, 'passed' from dual union all
    select 3, 'passed' from dual union all
    select 4, 'passed' from dual union all
    select 5, 'failed' from dual union all
    select 6, 'failed' from dual union all
    select 7, 'failed' from dual union all
    select 8, 'failed' from dual union all
    select 9, 'failed' from dual union all
    select 10, 'passed' from dual union all
    select 11, 'passed' from dual union all
    select 12, 'passed' from dual
),
groupings as
(
    select 
		step_number,
    	status,
    	step_number - row_number() over(partition by status order by step_number) as grp
    from
    	base
),
count_groupings as
(
	select 
    	grp,
    	status,
    	min(step_number) as min_step_number,
    	max(step_number) as max_step_number,
    	count(*) as consecutive_count
    from
    	groupings
    group by
    	grp,
    	status
)
select * from count_groupings order by grp;
