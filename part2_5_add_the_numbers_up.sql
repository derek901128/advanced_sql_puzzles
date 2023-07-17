with 
para(n) as (
    select 3 from dual
),
base(num) as (
    select level from dual connect by level <= ( select n from para )
),
factors(factor) as(
    select 1 from dual union all
    select -1 from dual
),
combination(
    base_set,
    num
) as (
    select 
    	distinct
    	( select listagg(num) within group (order by num) from base ),
    	substr(
    		( select listagg(num) within group (order by num) from base ),
    		a.num,
    		b.num
        ) * f.factor
    from 
    	base a 
    cross join 
    	base b
    cross join 
    	factors f
),
formula(
    lvl, 
    base_set,
    cur_num,
	permutation,
    sum
) as (
    select 
    	1,
    	base_set,
    	num,
    	to_char(num),
    	num
    from
    	combination
    where
    	to_char(num) like '1%'
    union all 
    select 
		a.lvl + 1,
    	a.base_set,
    	b.num,
    	case 
    		when b.num < 0 
    		then a.permutation || to_char(b.num)
    		else a.permutation || '+' || to_char(b.num)
    	end,
    	b.num + a.sum
    from
    	formula a, combination b
    where
    	to_number(substr(to_char(abs(b.num)), 1, 1)) - to_number(substr(a.permutation, length(a.permutation), 1)) = 1
    and 
    	a.lvl < ( select n from para )
),
solution as (
	select 
    	permutation,
    	sum
    from 
    	formula 
    where 
    	regexp_count(permutation, '\d') = 3    
)
select * from solution;