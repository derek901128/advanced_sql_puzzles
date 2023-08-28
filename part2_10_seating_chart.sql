with 
seating_chart(seat_number) as 
(
    select 7 from dual union all
    select 13 from dual union all
    select 14 from dual union all
    select 15 from dual union all
    select 27 from dual union all
    select 28 from dual union all
    select 29 from dual union all
    select 30 from dual union all
    select 31 from dual union all
    select 32 from dual union all
    select 33 from dual union all
    select 34 from dual union all
    select 35 from dual union all
    select 52 from dual union all
    select 53 from dual union all
    select 54 from dual
),
anchor(num) as 
(
    select 1 from dual
    union all
    select num + 1 from anchor where num < ( select max(seat_number) from seating_chart )
),
combined as 
(
    select 
		a.num,
    	sc.seat_number,
    	case 
    		when lag(sc.seat_number)over(order by num) is null and seat_number is not null
    		then nvl(lag(sc.seat_number)over(order by seat_number asc nulls first) + 1, 1)
    	end as gap_start,
    	case 
    		when lag(sc.seat_number)over(order by num) is null
    		then nvl2(seat_number, max(num) over(order by num rows between unbounded preceding and 1 preceding), null)
		end as gap_end,
    	sum(case when sc.seat_number is null then 1 else 0 end) over() as missing_numbers,
    	sum(case when mod(sc.seat_number, 2) = 0 then 1 else 0 end) over() as even_count,
    	sum(case when mod(sc.seat_number, 2) <> 0 then 1 else 0 end) over() as odd_count
    from
    	anchor a
	    left join seating_chart sc
	    	on a.num = sc.seat_number
)
select * from combined order by num;
