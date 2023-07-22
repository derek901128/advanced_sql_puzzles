with
base (
    pid,
    sid
) as (
    select 'pat', 'charlie' from dual union all
    select 'jordan', 'casey' from dual union all
    select 'ashley', 'dee' from dual union all
    select 'charlie', 'pat' from dual union all
    select 'casey', 'jordan' from dual union all
    select 'dee', 'ashley' from dual
),
spouse_group as (
    select 
    	pid,
    	sid,
    	dense_rank() over(order by least(pid, sid) || greatest(pid, sid)) as group_id
    from
 		base
)
select * from spouse_group;