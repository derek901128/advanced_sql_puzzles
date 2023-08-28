with 
base
(
    order_id,
    line_item,
    cost
) as 
(
    select 1, 1, 9 from dual union all
    select 1, 2, 15 from dual union all
    select 1, 3, 7 from dual union all
    select 1, 4, 3 from dual union all
    select 1, 5, 1 from dual union all
    select 1, 6, 1 from dual union all
    select 2, 1, 10 from dual union all
    select 2, 2, 10 from dual union all
    select 2, 3, 11 from dual union all
    select 3, 1, 3 from dual union all
    select 3, 2, 4 from dual
),
combinations 
(
    lvl,
    order_id,
    permutation,
    total
) as 
(
    select 
    	1, 
    	order_id, 
    	to_char(line_item), 
    	cost 
    from 
    	base
    where
    	cost < 10
    union all
    select
		c.lvl + 1,
    	c.order_id,
		c.permutation || ',' || to_char(b.line_item),
    	c.total + b.cost
    from
    	combinations c
	    join ( select * from base where cost < 10 ) b
		    on c.order_id = b.order_id
		    and to_char(b.line_item) > c.permutation
		    and to_char(b.line_item) > c.permutation
		    and b.cost + c.total >= 10
    where
    	c.lvl < 2
),
combinations_all as 
(
	select order_id, permutation, total from combinations where total >= 10
    union all
    select order_id, to_char(line_item), cost from base where cost >= 10
),
non_overlapping_sets 
(
    lvl,
    order_id,
	permutation,
    set_combinations
) as 
(
 	select 1, order_id, permutation, '(' || permutation || ')' from combinations_all
    union all
    select 
		a.lvl + 1,
    	a.order_id,
    	b.permutation,
    	a.set_combinations || ',(' || b.permutation || ')'
    from 
    	non_overlapping_sets a 
	    join combinations_all b
		    on a.order_id = b.order_id 
		    and regexp_substr(b.permutation, '\d', 1, 1) > regexp_substr(a.permutation, '\d', 1, 1)
		    and a.set_combinations not like '%' || nvl(regexp_substr(b.permutation, '\d', 1, 2), regexp_substr(b.permutation, '\d', 1, 1)) || '%'
		    and a.set_combinations not like '%' || regexp_substr(b.permutation, '\d', 1, 1) || '%'
    where
    	a.lvl < 3
),
solution as 
(
	select 
    	a.order_id,
    	regexp_count(b.set_combinations, '\(\d,?\d?\)') as set_count,
    	b.set_combinations
    from 
    	( select distinct order_id from base ) a  
	    left join 
			( 
				select 
					* 
				from 
					non_overlapping_sets 
				where r
					egexp_count(set_combinations, '\(\d,?\d?\)') = 3 
			) b
	    	on a.order_id = b.order_id
)
select * from solution
;
