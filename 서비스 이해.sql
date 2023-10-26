# 1. 2020년 7월의 Revenue를 구해주세요.
select sum(price)
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-01'
	and purchased_at < '2020-08-01';
    
# 2. 2020년 7월의 MAU(월 활성 유저)를 구해주세요.
select count(distinct customer_id)
from fastcampus.tbl_visit
where visited_at >= '2020-07-01'
	and visited_at < '2020-08-01';
    
# 3. 2020년 7월에 우리 Active 유저의 구매율(Paying Rate)은 어떻게 되나요?
-- 구매유저 수(10333) / 전체 활성유저(13853)
select count(distinct customer_id)
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-01'
	and purchased_at < '2020-08-01';
    
select count(distinct customer_id)
from fastcampus.tbl_visit
where visited_at >= '2020-07-01'
	and visited_at < '2020-08-01';
    
select round(10333 / 13853*100,2);

# 4. 2020년 7월에 구매 유저의 월 평균 구매액은 어떻게 되나요?
-- ARPPU = Average Revenue per Paying User
select customer_id, sum(price)
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-01'
	and purchased_at < '2020-08-01'
group by customer_id;

select avg(revenue)
from(select customer_id, sum(price) as revenue
	from fastcampus.tbl_purchase
	where purchased_at >= '2020-07-01'
	and purchased_at < '2020-08-01'
	group by customer_id) foo; -- ARPPU = avg(revenue)
    
# 5. 2020년 7월에 가장 많이 구매한 Top3 고객과 Top10 ~ 15 고객을 뽑아주세요.
select customer_id, sum(price) as revenue
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-01'
	and purchased_at < '2020-08-01'
group by customer_id
order by 2 desc
limit 3 offset 10