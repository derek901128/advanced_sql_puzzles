with 
param(lvl) as (
    select 4 from dual
),
base(num) as (
    select level from dual connect by level <= ( select lvl from param )
),
non_adjacent(
    lvl,
    cur_num,
    permutaion
) as (
    select 
    	1,
    	num,
		to_char(num)
	from
    	base 
    union all
    select 
    	a.lvl + 1,
    	b.num,
    	a.permutaion || ',' || to_char(b.num) 
    from
		non_adjacent a, base b
    where
    	a.permutaion not like '%' || to_char(b.num) || '%'
    and 
    	a.lvl < ( select lvl from param )
    and 
		abs(b.num - a.cur_num) > 1 
),
solution as (
	select 
    	permutaion 
    from 
    	non_adjacent 
	where 
    	lvl = ( select lvl from param )    
)
select * from solution;
