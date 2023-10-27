# 프로덕트 분석 심화
# 18. 2020년 7월에 우리 신규유저가 하루 안에 결제로 넘어가는 비율이 어떻게 되나요? 그 비율이 어떤지 알고싶고, 결제까지 몇 분 정도가 소요되는지 알고싶어요.
-- 신규유저의 가입일, 최초 구매일
with rt_tbl as (
select A.customer_id, B.customer_id as paying_user,
time_to_sec(timediff(B.purchased_at, A.created_at)) / 3600 as diff_hour
from fastcampus.tbl_customer A

left join(
select customer_id,
min(purchased_at) as purchased_at
from fastcampus.tbl_purchase
group by 1) B

on A.customer_id = B.customer_id
and B.purchased_at < A.created_at + interval 1 day
where A.created_at >= '2020-07-01' and A.created_at < '2020-08-01')

select round(count(paying_user) / count(customer_id) * 100,2)
from rt_tbl

union all
select avg(diff_hour)
from rt_tbl;

# 19. 우리 서비스는 유저의 재방문율이 높은 서비스인가요? 이를 파악하기 위해 7월 기준 Day1 Retention이 어떤지 구해주시고 추세를 보기 위해 Daily로 추출해주세요.
-- Retention: 시간이 지날수록 얼마나 많은 유저가 제품이나 서비스로 다시 돌아오는지
-- N-day Retention: n = 1,2,3,4,...30..
SELECT 
    DATE_FORMAT(A.visited_at - INTERVAL 9 HOUR,
            '%Y-%m-%d') AS d_date,
    COUNT(DISTINCT A.customer_id) AS active_user,
    COUNT(DISTINCT B.customer_id) AS retained_user,
    COUNT(DISTINCT B.customer_id) / COUNT(DISTINCT A.customer_id) AS retention
FROM
    fastcampus.tbl_visit A
        LEFT JOIN
    fastcampus.tbl_visit B ON A.customer_id = B.customer_id
        AND DATE_FORMAT(A.visited_at - INTERVAL 9 HOUR,
            '%Y-%m-%d') = DATE_FORMAT(B.visited_at - INTERVAL 9 HOUR - INTERVAL 1 DAY,
            '%Y-%m-%d')
WHERE
    A.visited_at >= '2020-07-01'
        AND A.visited_at < '2020-08-01'
GROUP BY 1;

# 20. 2020년 7월 우리 서비스는 신규유저가 많나요? 기존유저가 많나요? 가입 기간별로 고객 분포가 어떤지 알려주세요. DAU 기준으로 부탁합니다.
-- tbl_visit 일자별로 고객의 last_visit created_at = service age
with tbl_visit_by_joined as(
select date_format(A.visited_At - interval 9 hour,  '%Y-%m-%d') as d_date,
A.customer_id, B.created_at as d_joined, max(A.visited_at) as last_visit,
datediff(max(A.visited_at), B.created_at) as date_diff
from fastcampus.tbl_visit A
left join fastcampus.tbl_customer B
on A.customer_id = B.customer_id
where A.visited_at >= '2020-07-01' and A.visited_at < '2020-08-01'
group by 1,2,3)

select A.d_date,
case when A.date_diff >= 730 then '2년 이상'
when A.date_diff >= 365 then '1년 이상'
when A.date_diff >= 183 then '6개월 이상'
when A.date_diff >= 91 then '3개월 이상'
when A.date_diff >= 30 then '1개월 이상'
else '1개월 미만'
end as segment,
B.all_users,
count(A.customer_id) as users,
round(count(A.customer_id)/B.all_users*100,2) as per

from tbl_visit_by_joined A
left join (select d_date, count(customer_id) as all_users
from tbl_visit_by_joined
group by 1) B
on A.d_date = B.d_date

group by 1,2,3
order by 1,2;