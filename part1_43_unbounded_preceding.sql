with 
base 
(
    oid, 
    cid,
    qty
) as 
(
    select 1, 1001, 5 from dual union all
    select 2, 1001, 8 from dual union all
    select 3, 1001, 3 from dual union all
    select 4, 1001, 7 from dual union all
    select 1, 2002, 4 from dual union all
    select 2, 2002, 9 from dual 
)
select 
	oid,
	cid,
	qty,
	min(qty) over(partition by cid order by rownum rows between unbounded preceding and current row) as min_value
from
	base
;
