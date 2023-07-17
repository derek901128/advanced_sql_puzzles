with 
factorials (
    cur_num,
    factorial
) as (
    select 
        1, 
        1 * 1
    from
        dual 
    union all
    select 
        cur_num + 1,
        (cur_num + 1) * factorial
    from 
        factorials
    where
        cur_num < 10
)
select * from factorials;