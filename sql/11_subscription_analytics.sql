/*==========================================================
SUBSCRIPTION ANALYTICS
==========================================================*/

--1 Total Revenue
SELECT ROUND(SUM(subscription_amount),2) AS total_revenue
FROM ott.subscription_transactions
WHERE payment_status='Success';

--2 Revenue by Plan
SELECT
plan_type,
ROUND(SUM(subscription_amount),2) revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY plan_type
ORDER BY revenue DESC;

--3 Revenue by Payment Mode
SELECT
payment_mode,
ROUND(SUM(subscription_amount),2) revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY payment_mode
ORDER BY revenue DESC;

--4 Transactions by Plan
SELECT
plan_type,
COUNT(*) total_transactions
FROM ott.subscription_transactions
GROUP BY plan_type
ORDER BY total_transactions DESC;

--5 Transactions by Payment Status
SELECT
payment_status,
COUNT(*) total_transactions
FROM ott.subscription_transactions
GROUP BY payment_status
ORDER BY total_transactions DESC;

--6 Transactions by Renewal Status
SELECT
renewal_status,
COUNT(*) total_transactions
FROM ott.subscription_transactions
GROUP BY renewal_status
ORDER BY total_transactions DESC;

--7 Average Subscription Amount
SELECT
ROUND(AVG(subscription_amount),2) avg_subscription
FROM ott.subscription_transactions;

--8 Average Amount by Plan
SELECT
plan_type,
ROUND(AVG(subscription_amount),2)
FROM ott.subscription_transactions
GROUP BY plan_type
ORDER BY AVG(subscription_amount) DESC;

--9 Highest Subscription Amount
SELECT *
FROM ott.subscription_transactions
ORDER BY subscription_amount DESC
LIMIT 20;

--10 Lowest Subscription Amount
SELECT *
FROM ott.subscription_transactions
ORDER BY subscription_amount
LIMIT 20;

--11 Monthly Revenue
SELECT
DATE_TRUNC('month',transaction_timestamp) month,
ROUND(SUM(subscription_amount),2) revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY month
ORDER BY month;

--12 Yearly Revenue
SELECT
EXTRACT(YEAR FROM transaction_timestamp) year,
ROUND(SUM(subscription_amount),2) revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY year
ORDER BY year;

--13 Daily Revenue
SELECT
DATE(transaction_timestamp) day,
ROUND(SUM(subscription_amount),2) revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY day
ORDER BY day;

--14 Payment Success Rate
SELECT
ROUND(
100.0*
COUNT(*) FILTER (WHERE payment_status='Success')/
COUNT(*),2
) success_rate
FROM ott.subscription_transactions;

--15 Failed Payment Rate
SELECT
ROUND(
100.0*
COUNT(*) FILTER (WHERE payment_status='Failed')/
COUNT(*),2
) failed_rate
FROM ott.subscription_transactions;

--16 Pending Payment Rate
SELECT
ROUND(
100.0*
COUNT(*) FILTER (WHERE payment_status='Pending')/
COUNT(*),2
) pending_rate
FROM ott.subscription_transactions;

--17 Revenue by Renewal Status
SELECT
renewal_status,
ROUND(SUM(subscription_amount),2)
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY renewal_status
ORDER BY SUM(subscription_amount) DESC;

--18 Users with Multiple Transactions
SELECT
user_id,
COUNT(*) total_transactions
FROM ott.subscription_transactions
GROUP BY user_id
HAVING COUNT(*)>1
ORDER BY total_transactions DESC;

--19 Top Paying Users
SELECT
user_id,
ROUND(SUM(subscription_amount),2) total_paid
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY user_id
ORDER BY total_paid DESC
LIMIT 20;

--20 Revenue by Month and Plan
SELECT
DATE_TRUNC('month',transaction_timestamp) month,
plan_type,
ROUND(SUM(subscription_amount),2)
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY month,plan_type
ORDER BY month;

--21 Transactions by Payment Mode
SELECT
payment_mode,
COUNT(*)
FROM ott.subscription_transactions
GROUP BY payment_mode
ORDER BY COUNT(*) DESC;

--22 Revenue by Payment Mode and Plan
SELECT
payment_mode,
plan_type,
ROUND(SUM(subscription_amount),2)
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY payment_mode,plan_type
ORDER BY SUM(subscription_amount) DESC;

--23 Premium Revenue
SELECT
ROUND(SUM(subscription_amount),2)
FROM ott.subscription_transactions
WHERE plan_type='Premium'
AND payment_status='Success';

--24 Family Revenue
SELECT
ROUND(SUM(subscription_amount),2)
FROM ott.subscription_transactions
WHERE plan_type='Family'
AND payment_status='Success';

--25 Sports Revenue
SELECT
ROUND(SUM(subscription_amount),2)
FROM ott.subscription_transactions
WHERE plan_type='Sports'
AND payment_status='Success';

--26 Basic Revenue
SELECT
ROUND(SUM(subscription_amount),2)
FROM ott.subscription_transactions
WHERE plan_type='Basic'
AND payment_status='Success';

--27 Average Revenue Per User
SELECT
ROUND(
SUM(subscription_amount)/
COUNT(DISTINCT user_id),2
)
FROM ott.subscription_transactions
WHERE payment_status='Success';

--28 Highest Monthly Revenue
SELECT
DATE_TRUNC('month',transaction_timestamp) as month,
ROUND(SUM(subscription_amount),2) revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY month
ORDER BY revenue DESC
LIMIT 1;

--29 Lowest Monthly Revenue
SELECT
DATE_TRUNC('month',transaction_timestamp) as month,
ROUND(SUM(subscription_amount),2) revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY month
ORDER BY revenue
LIMIT 1;

--30 Top Revenue Days
SELECT
DATE(transaction_timestamp) day,
ROUND(SUM(subscription_amount),2) revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY day
ORDER BY revenue DESC
LIMIT 20;