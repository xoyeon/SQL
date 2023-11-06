/* 1) 고객의 등급 구분 :
고객의 서비스 이용 데이터(총 구매횟수, 총 구매금액, 평균 구매금액)중 하나를 기준으로 고객을 5등급으로 구분하고,
그중 1등급에 해당하는 고객의 랭킹, 고객아이디, 이름, 성별, 나이, 주소, 서비스 이용데이터(총 구매횟수, 총 구매금액, 평균 구매금액)를 출력하세요.

2) KPI 지표 : 
고객 및 상품 주문 데이터에서 서비스를 평가할수 있고 그에 따른 인사이트를 얻을 수 있는 결과를 출력하세요. */

select customer_rank, customer_id, customer_name, gender, age, home_address,
sum(payment) as total_payment,
case when sum(payment) 
from fastcampus.orders A;

WITH CustomerRank AS (
    SELECT
        customer_id,
        name,
        gender,
        age,
        address,
        total_purchase_count,
        total_purchase_amount,
        avg_purchase_amount,
        NTILE(5) OVER (ORDER BY total_purchase_amount DESC) AS customer_grade
    FROM customers
)
SELECT
    RANK() OVER (ORDER BY total_purchase_amount DESC) AS ranking,
    customer_id,
    name,
    gender,
    age,
    address,
    total_purchase_count,
    total_purchase_amount,
    avg_purchase_amount
FROM CustomerRank
WHERE customer_grade = 1;