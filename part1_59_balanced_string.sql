with 
base (
    id, 
    string
) as (
    select 1, '()' from dual union all
    select 2, '[]' from dual union all
    select 3, '{}' from dual union all
    select 4, '(({[]}))' from dual union all
    select 5, '()[]' from dual union all
    select 6, '({})' from dual union all
    select 7, '({)}' from dual union all
    select 8, '({)}}}()' from dual union all
    select 9, '}{()][' from dual
),
translated as (
    select
		id, 
    	translate(string, '(){}[]', '112233') as string,
    	string as string_original
    from
    	base
),
with_reverse (
    id,
    string,
    string_original,
    pair_id,
    chr,
    chr_opposite,
    score
) as (
    select 
		a.id,
    	a.string,
    	a.string_original,
    	b.pair_id,
    	b.chr,
    	b.chr_opposite,
    	b.chr - b.chr_opposite
	from
		translated a
    cross apply 
    	(
    		select 
    			level as pair_id,
				substr(c.string, length(c.string)/2 - (level - 1), 1) as chr,
    			substr(c.string, length(c.string)/2 + level, 1) as chr_opposite
    		from
    			( select * from translated d where a.id = d.id ) c
    		connect by 
    			level <= length(c.string) / 2
        ) b
),
solution as (
    select 
        id,
    	string_original,
        case when count(distinct score) = 1 then 'balanced' else 'unbalanced' end as outcome
    from 
    	with_reverse 
    group by 
     	id, string_original
)
select * from solution;
