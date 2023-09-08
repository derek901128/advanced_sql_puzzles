with
base
(
    sid
    , jd
    , cnt
) as 
(
    select 1001, 'astrogator', 6 from dual union all
    select 2002, 'astrogator', 12 from dual union all
    select 3003, 'astrogator', 17 from dual union all
    select 4004, 'geologist', 21 from dual union all
    select 5005, 'geologist', 9 from dual union all
    select 6006, 'geologist', 8 from dual union all
    select 7007, 'technician', 13 from dual union all
    select 8008, 'technician', 2 from dual union all
    select 9009, 'technician', 7 from dual
),
first_and_last as 
(
    select 
    	jd
    	, min(cnt) as least_exp
    	, max(cnt) as most_exp
    from
    	base
    group by 
    	jd
)
select 
	a.jd
	, b.sid as least_exp
	, c.sid as most_exp
from 
    first_and_last a
	join base b
		on a.jd = b.jd
		and a.least_exp = b.cnt 
	join base c
		on a.jd = c.jd
		and a.most_exp = c.cnt
;
