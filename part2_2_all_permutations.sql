with 
param(dim) as 
(
	select 3 from dual
),
base(num) as 
(
    select 1 from dual 
    union all 
    select num + 1 from base 
    where num < ( select dim from param )
),
combinations 
(
    lvl,
    permutations
) as 
(
    select
		1,
    	to_char(num)
    from
    	base
    union all
    select 
		c.lvl + 1,
    	c.permutations || ',' || to_char(b.num) 
    from 
    	combinations c, base b
    where
    	c.lvl < ( select dim from param )
    	and c.permutations not like '%' ||  to_char(b.num) || '%'
)
select * from combinations where lvl = ( select dim from param ) ;
