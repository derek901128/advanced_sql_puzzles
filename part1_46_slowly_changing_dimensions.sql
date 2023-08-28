with
base
(
    id,
    sd,
    ed,
    amt
) as (
    select 1001, '2021-10-11', '9999-12-31', 54.32 from dual union all
    select 1001, '2021-10-10', '2021-10-10', 17.65 from dual union all
    select 1001, '2021-9-18', '2021-10-12', 65.56 from dual union all
    select 2002, '2021-9-12', '2021-9-17', 56.23 from dual union all
    select 2002, '2021-9-1', '2021-9-17', 42.12 from dual union all
    select 2002, '2021-8-15', '2021-8-31', 16.32 from dual
),
add_row_no as 
(
	select 
    	row_number()over(order by 1) as n,
		base.*
    from
    	base 
),
overlap as 
(
	select 
		a.id,
    	a.sd,
    	a.ed,
    	a.amt
    from 
    	add_row_no a
	    join add_row_no b
		    on a.n <> b.n
		    and a.id = b.id
		    and to_date(a.sd, 'yyyy-mm-dd') <= to_date(b.sd, 'yyyy-mm-dd')
		    and to_date(a.ed, 'yyyy-mm-dd') >= to_date(b.ed, 'yyyy-mm-dd')
)
select * from overlap;
