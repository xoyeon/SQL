SELECT 
    AVG(users)
FROM
    (SELECT 
        DATE_FORMAT(visited_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
		COUNT(DISTINCT customer_id) AS users
    FROM
        fastcampus.tbl_visit
    WHERE
        visited_at >= '2020-07-01'
            AND visited_at < '2020-08-01'
    GROUP BY 1
    ORDER BY 1) fooctivation users
select avg(users)
from(
select date_format(visited_at - interval 9 hour, '%Y-%m-%U') as date_at,
       count(distinct customer_id) as users
from fastcampus.tbl_visit
where visited_at >= '2020-07-05'
and visited_at < '2020-07-26'
group by 1
order by 1) foo;

SELECT 
    AVG(revenue)
FROM
    (SELECT 
        DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
		SUM(price) AS revenue
    FROM
        fastcampus.tbl_purchase
    WHERE
        purchased_at >= '2020-07-05'
            AND purchased_at < '2020-08-01'
    GROUP BY 1
    ORDER BY 1) foo세요.
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
SELECT 
    DATE_FORMAT(date_at, '%w') AS day_order,
    DATE_FORMAT(date_at, '%W') AS day_name,
    AVG(revenue)
FROM
    (SELECT 
        DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
		SUM(price) AS revenue
    FROM
        fastcampus.tbl_purchase
    WHERE
        purchased_at >= '2020-07-05'
            AND purchased_at < '2020-08-01'
    GROUP BY 1) foo
GROUP BY 1 , 2
ORDER BY 1;

# 10. 2020년 7월 시간대별 시간당 총 Revenue를 구해주세요. 어느 시간대가 Revenue가 가장 높고 낮나요?
SELECT 
    hour_at, AVG(revenue)
FROM
    (SELECT 
        DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
		DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%H') AS hour_at,
		SUM(price) AS revenue
    FROM
        fastcampus.tbl_purchase
    WHERE
        purchased_at >= '2020-07-01'
            AND purchased_at < '2020-08-01'
    GROUP BY 1 , 2) foo
GROUP BY 1;

# 11. 2020년 7월의 요일 및 시간대별 Revenue를 구해주세요.
SELECT 
    dayofweek_at, hour_at, AVG(revenue)
FROM
    (SELECT 
        DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%Y-%m-%d') AS date_at,
        DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%W') AS dayofweek_at,
        DATE_FORMAT(purchased_at - INTERVAL 9 HOUR, '%H') AS hour_at,
        SUM(price) AS revenue
    FROM
        fastcampus.tbl_purchase
    WHERE
        purchased_at >= '2020-07-01'
            AND purchased_at < '2020-08-01'
    GROUP BY 1 , 2 , 3) foo
GROUP BY 1 , 2
ORDER BY 3 DESC;

# 과제 -- 요일 및 시간대 별 Activate User 수 계산해보기