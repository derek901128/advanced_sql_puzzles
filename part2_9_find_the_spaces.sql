with
base(statement) as 
(
    select 'select empid from emps;' from dual union all
    select 'select * from trans;' from dual
),
with_id as
(
    select rownum as id, statement from base
),
summary
(
    row_no,
    id,
    statement,
    strt,
    position,
    word,
    total_spaces
) as 
(
    select 
		1,
    	id,
    	statement,
    	1,
    	regexp_instr(statement, '\s', 1, 1),
    	regexp_substr(statement, '\S+', 1, 1),
    	regexp_count(statement, '\s')
    from
 		with_id 
    union all
    select 
		s.row_no + 1,
    	s.id,
    	s.statement,
    	s.position + 1,
    	regexp_instr(s.statement, '\s', s.position + 1, 1),
    	regexp_substr(s.statement, '\S+', 1, s.row_no + 1),
    	regexp_count(s.statement, '\s')
    from
		summary s
    where
    	s.row_no < regexp_count(s.statement, '\s') + 1
)
select * from summary order by id, row_no;
