with
base(
    product,
    product_id
) as (
    select 'alpha', '01' from dual union all
    select 'alpha', '02' from dual union all
    select 'bravo', '03' from dual union all
    select 'bravo', '04' from dual union all
    select 'charlie', '02' from dual union all
    select 'delta', '01' from dual union all
    select 'echo', 'EE' from dual union all
    select 'foxtrot', 'EE' from dual union all
    select 'gulf', 'GG' from dual
),
count_product as (
    select 
        product,
        count(*) over(partition by product) as product_count, 
        product_id
    from 
        base
),
solution as (
    select
    	product_id,
        max(product_count) as max_product_count
    from
    	count_product
    group by 
    	product_id
    having 
    	max(product_count) = 1
)
select * from max_product_count;
