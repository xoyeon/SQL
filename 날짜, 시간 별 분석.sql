# 6. 2020년 7월의 평균 DAU를 구해주세요. Active User 수가 증가하는 추세인가요?
-- DAU : Dailiy Activation User
select avg(users)
from(
select date_format(visited_at - interval 9 hour, '%Y-%m-%d') as date_at,
		count(distinct customer_id) as users
from fastcampus.tbl_visit
where visited_at >= '2020-07-01'
and visited_at < '2020-08-01'
group by 1
order by 1)foo;

# 7. 2020년 7월의 평균 WAU를 구해주세요. -- weekly activation users
select avg(users)
from(
select date_format(visited_at - interval 9 hour, '%Y-%m-%U') as date_at,
		count(distinct customer_id) as users
from fastcampus.tbl_visit
where visited_at >= '2020-07-05'
and visited_at < '2020-07-26'
group by 1
order by 1) foo;

# 8-1. 2020년 7월의 Daily Revenue는 증가하는 추세인가요? 평균 Daily Revenue도 구해주세요.
select avg(revenue)
from(
select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at,
		sum(price) as revenue
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-05'
and purchased_at < '2020-08-01'
group by 1
order by 1) foo;

# 8-2. 2020년 7월의 평균 Weekly Revenue를 구해주세요.
select avg(revenue)
from(
select date_format(purchased_at - interval 9 hour, '%Y-%m-%U') as date_at,
		sum(price) as revenue
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-05'
and purchased_at < '2020-07-26'
group by 1
order by 1) foo;

# 9. 2020년 7월 요일별 Daily Revenue를 구해줘요. 어느 요일이 Revenue가 가장 높고 낮나요?
select date_format(date_at, '%w') as day_order,
        date_format(date_at, '%W') as day_name,
		avg(revenue)
from(
	select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at,
			sum(price) as revenue
	from fastcampus.tbl_purchase
	where purchased_at >= '2020-07-05'
	and purchased_at < '2020-08-01'
	group by 1) foo
group by 1, 2
order by 1;

# 10. 2020년 7월 시간대별 시간당 총 Revenue를 구해주세요. 어느 시간대가 Revenue가 가장 높고 낮나요?
select hour_at, avg(revenue)
from (
select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at,
		date_format(purchased_at - interval 9 hour, '%H') as hour_at,
		sum(price) as revenue
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-01'
and purchased_at < '2020-08-01'
group by 1,2) foo
group by 1;

# 11. 2020년 7월의 요일 및 시간대별 Revenue를 구해주세요.
select dayofweek_at, hour_at, avg(revenue)
from(
select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as date_at,
		date_format(purchased_at - interval 9 hour, '%W') as dayofweek_at,
        date_format(purchased_at - interval 9 hour, '%H') as hour_at,
		sum(price) as revenue
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-01'
and purchased_at < '2020-08-01'
group by 1,2,3) foo
group by 1,2
order by 3 desc;

# 과제 -- 요일 및 시간대 별 Activate User 수 계산해보기