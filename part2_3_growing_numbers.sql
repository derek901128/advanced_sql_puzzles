with 
growing_numbers
(
    n,
    p
) as 
(
    select 1, '1' from dual
    union all
    select 
        n + 1,
        p || to_char(n + 1)
    from
        growing_numbers
    where
        n < 5
)
select * from growing_numbers;
