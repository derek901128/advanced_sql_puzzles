with 
cart_one(item) as 
(
    select 'sugar' from dual union all
    select 'bread' from dual union all
    select 'juice' from dual union all
    select 'soda' from dual union all
    select 'flour' from dual
),
cart_two(item) as 
(
    select 'bread' from dual union all
    select 'sugar' from dual union all
    select 'butter' from dual union all
    select 'cheese' from dual union all
    select 'fruit' from dual
),
solution
(
    item_cart_one
    , item_cart_two
) as 
(
    select 
        a.item
        , b.item
    from 
        cart_one a
        full outer join cart_two b
            on a.item = b.item 
)
select * from solution
;
