with
param(len) as (
    select 4 from dual
),
base(n) as (
    select 0 from dual union all
    select 1 from dual 
),
combination(
    lvl,
    cur_num,
    permutation
) as (
    select 1, n, to_char(n) from base 
    union all
    select 
		a.lvl + 1,
   		b.n,
    	a.permutation || to_char(n)
    from
    	combination a, base b
    where
    	a.lvl < ( select len from param )
),
solution as (
	select permutation from combination where lvl = ( select len from param )
)
select * from solution;