with 
base(equation) as 
(
    select '123' from dual union all
    select '1+2+3' from dual union all
    select '1+2-3' from dual union all
    select '1+23' from dual union all
    select '1-2+3' from dual union all
    select '1-2-3' from dual union all
    select '1-23' from dual union all
    select '12+3' from dual union all
    select '12-3' from dual 
),  
add_row_no as 
(
    select 
    	row_number() over(order by rownum) as row_no
    	, equation
	from
    	base
),
breakup as 
(
    select 
        a.row_no
    	, a.equation
        , b.*
    from
        add_row_no a 
	    cross apply 
		(
			select 
				level as element_id
				, regexp_substr(equation, '\-?\d+', 1, level) as element
			from
				( select * from add_row_no d where d.row_no = a.row_no ) c
			connect by 
				level <= regexp_count(equation, '\+|\-') + 1
		) b
),
solution as 
(
	select
    	row_no
    	, equation as permutaion
    	, sum(element) as sum
	from 
    	breakup
    group by 
    	row_no, 
    	equation
)
select * from solution order by row_no;
