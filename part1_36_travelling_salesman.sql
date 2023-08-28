with 
base 
(
    rid,
    dc,
    ac,
    cost
) as (
    select 1, 'austin', 'dallas', 100 from dual union all
    select 1, 'dallas', 'austin', 100 from dual union all
    select 2, 'dallas', 'memphis', 200 from dual union all
    select 2, 'memphis', 'dallas', 200 from dual union all
    select 3, 'memphis', 'des moines', 300 from dual union all
    select 3, 'des moines', 'memphis', 300 from dual union all
    select 4, 'dallas', 'des moines', 400 from dual union all
    select 4, 'des moines', 'dallas', 400 from dual
),
routes
(
    lvl,
    cdc,
    cac,
    p,
    tc
) as 
(
    select 
    	1, dc, ac, dc || '->' || ac, cost
    from 
    	base
    where 
    	dc = 'austin'
    	and ac <> 'des moines'
    union all
    select 
		a.lvl + 1,
    	a.cac,
    	b.ac,
    	a.p || '->' || b.ac,
    	a.tc + b.cost
    from 
    	routes a 
   	 	join base b
	    	on a.cac = b.dc
	    	and a.p not like '%' || b.ac || '%'
)
select p, tc from routes where cac = 'des moines';
