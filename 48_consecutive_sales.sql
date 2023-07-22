with
base(
    id,
    y
) as (
    select 1001, 2018 from dual union all
	select 1001, 2019 from dual union all
    select 1001, 2020 from dual union all
    select 2002, 2020 from dual union all
    select 2002, 2021 from dual union all
    select 3003, 2018 from dual union all
    select 3003, 2020 from dual union all
    select 3003, 2021 from dual union all
    select 4004, 2019 from dual union all
    select 4004, 2020 from dual union all
    select 4004, 2021 from dual 
),
consecutive_sales as (
    select 
    	base.*,
    	case lag(y, 2) over(partition by id order by y asc ) when 2021 - 2 then 'Y' else 'N' end as prev_2 ,
    	case lag(y) over(partition by id order by y asc ) when 2021 - 1 then 'Y' else 'N' end as prev_1 
    from
    	base
)
select id from consecutive_sales where y = 2021 and prev_2 = 'Y' and prev_2 = 'Y';