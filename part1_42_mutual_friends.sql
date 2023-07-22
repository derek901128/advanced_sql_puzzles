with 
base(
    friend_1,
    friend_2
) as (
    select 'jason', 'mary' from dual union all
    select 'mike', 'mary' from dual union all
    select 'mike', 'jason' from dual union all
    select 'susan', 'jason' from dual union all
    select 'john', 'mary' from dual union all
    select 'susan', 'mary' from dual
),
add_rn as (
    select 
    	row_number()over(order by 1) as rn,
    	base.*
    from
    	base
),
mutual as (
    select 	
    	a.rn,
    	a.friend_1,
    	a.friend_2,
    	b.friend_2 as a,
    	c.friend_1 as b,
    	d.friend_1 as c,
    	e.friend_2 as d
    from
    	add_rn a
    left join
    	add_rn b 
    on
    	a.friend_1 = b.friend_1
    and 
    	a.friend_2 <> b.friend_2
    left join
    	add_rn c
    on
    	a.friend_1 = c.friend_2
    left join
    	add_rn d
    on
    	a.friend_2 = d.friend_2
    and 
    	a.friend_1 <> d.friend_1
    left join
    	add_rn e
    on
    	a.friend_2 = e.friend_1
)
select 
	rn,
    friend_1,
    friend_2,
    sum(
    	case 
    		when a = c or a = d or b = c or b = d 
    		then 1 
    		else 0 
    	end
    ) as mutual_friends
from 
    mutual 
group by 
	rn, friend_1, friend_2
order by 
    rn
;
