# 유저 세그먼트별 분석
/* 12. 전체 유저의 Demographic을 알고 싶어요. 성별, 연령별로 유저 숫자를 알려주세요.
어느 세그먼트가 가장 숫자가 많나요? 참고로 기타 성별은 하나로, 연령은 5세 단위로 적당히 묶어주시고 유저 수가 높은 순서대로 보여주세요. */
SELECT 
    CASE
        WHEN LENGTH(gender) < 1 THEN 'Others'
        ELSE gender
    END AS gender,
    CASE
        WHEN age <= 15 THEN '0_15세 이하'
        WHEN age <= 20 THEN '1_16세-20세'
        WHEN age <= 25 THEN '2_21세-25세'
        WHEN age <= 30 THEN '3_26세-30세'
        WHEN age <= 35 THEN '4_31세-35세'
        WHEN age <= 40 THEN '5_36세-40세'
        WHEN age <= 45 THEN '6_41세-45세'
        WHEN age >= 46 THEN '7_46세 이상'
    END AS age,
    COUNT(*)
FROM
    fastcampus.tbl_customer
GROUP BY 1 , 2
ORDER BY 3 DESC;

# 13. 결과의 성, 연령을 "남성(25~29세)"와 같이 통합해주시고, 각 성,연령이 전체 고객에서 얼마나 차지하는지 분포(%)를 알려주세요. 역시 분포가 높은 순서대로 알려주세요.
SELECT concat(
    CASE
        WHEN LENGTH(gender) < 1 THEN '기타'
        when gender = 'Others' then '기타'
        when gender = 'M' then '남성'
        when gender = 'F' then '여성'
        end,
	"(",
    CASE
        WHEN age <= 15 THEN '15세 이하'
        WHEN age <= 20 THEN '16세-20세'
        WHEN age <= 25 THEN '21세-25세'
        WHEN age <= 30 THEN '26세-30세'
        WHEN age <= 35 THEN '31세-35세'
        WHEN age <= 40 THEN '36세-40세'
        WHEN age <= 45 THEN '41세-45세'
        WHEN age >= 46 THEN '46세 이상'
        end,
	")") as segement,
    round(count(*) / (select count(*) from fastcampus.tbl_customer)*100,2) as per
FROM     fastcampus.tbl_customer
GROUP BY 1
ORDER BY 2 DESC;

# 14. 2020년 7월 성별에 따라 총 구매 건수와, 총 Revenue를 구해주세요. 이전처럼 남녀 이외의 성별은 하나로 묶어주세요.
SELECT 
    CASE
        WHEN B.gender = 'M' THEN '남성'
        WHEN B.gender = 'F' THEN '여성'
        WHEN B.gender = 'Others' THEN '기타'
        WHEN LENGTH(B.gender) < 1 THEN '기타'
    END AS gender,
    COUNT(*) AS cnt,
    SUM(price) AS revenue
FROM
    fastcampus.tbl_purchase A
        LEFT JOIN
    fastcampus.tbl_customer B ON A.customer_id = B.customer_id
WHERE
    A.purchased_at >= '2020-07-01'
        AND A.purchased_at < '2020-08-01'
GROUP BY 1;

# 15. 2020년 7월 성별, 연령대에 따라 구매 건수와, 총 Revenue를 구해주세요.
SELECT 
    CASE
        WHEN B.gender = 'M' THEN '남성'
        WHEN B.gender = 'F' THEN '여성'
        WHEN B.gender = 'Others' THEN '기타'
        WHEN LENGTH(B.gender) < 1 THEN '기타'
    END AS gender,
    CASE
        WHEN B.age <= 15 THEN '0_15세 이하'
        WHEN B.age <= 20 THEN '1_16세-20세'
        WHEN B.age <= 25 THEN '2_21세-25세'
        WHEN B.age <= 30 THEN '3_26세-30세'
        WHEN B.age <= 35 THEN '4_31세-35세'
        WHEN B.age <= 40 THEN '5_36세-40세'
        WHEN B.age <= 45 THEN '6_41세-45세'
        WHEN B.age >= 46 THEN '7_46세 이상'
    END AS age_group,
    COUNT(*) AS cnt,
    SUM(price) AS revenue
FROM
    fastcampus.tbl_purchase A
        LEFT JOIN
    fastcampus.tbl_customer B ON A.customer_id = B.customer_id
WHERE
    A.purchased_at >= '2020-07-01'
        AND A.purchased_at < '2020-08-01'
GROUP BY 1 , 2
ORDER BY 4 DESC;

# 16. 2020년 7월 월별 매출의 전일 대비 증감폭, 증감률을 구해주세요.
with tbl_revenue as (
	select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') as d_date,
			sum(price) as revenue
	from fastcampus.tbl_purchase
	where purchased_at >= '2020-07-01'
	and purchased_at < '2020-08-01'
	group by 1)
select *,
	revenue - lag(revenue) over(order by d_date asc) as diff_revenue,
	round((revenue - lag(revenue) over(order by d_date asc))/lag(revenue) over(order by d_date asc)*100,2) as chg_revenue
from tbl_revenue;

# 매출 관련 추가 분석
# 17. 일별로 많이 구매한 고객들한테 소정의 선물을 주려고해요. 7월의 일별 구매 금액을 기준으로 가장 ㅁ낳이 지출한 고객 TOP3를 뽑아주세요.
select *
from(
select date_format(purchased_at - interval 9 hour, '%Y-%m-%d') d_date,
		customer_id,
		sum(price),
		dense_rank() over (partition by date_format(purchased_at - interval 9 hour, '%Y-%m-%d') order by sum(price) desc) as rank_rev
from fastcampus.tbl_purchase
where purchased_at >= '2020-07-01'
and purchased_at < '2020-08-01'
group by 1, 2)foo

where rank_rev < 4;