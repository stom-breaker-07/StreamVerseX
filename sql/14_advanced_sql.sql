/*==========================================================
ADVANCED SQL
==========================================================*/

----------------------------------------------------------
-- 1 ROW_NUMBER()
----------------------------------------------------------

SELECT
user_id,
SUM(watch_duration) total_watch_time,
ROW_NUMBER() OVER(ORDER BY SUM(watch_duration) DESC) rn
FROM ott.video_streaming_sessions
GROUP BY user_id;

----------------------------------------------------------
-- 2 RANK()
----------------------------------------------------------

SELECT
user_id,
SUM(watch_duration) total_watch_time,
RANK() OVER(ORDER BY SUM(watch_duration) DESC) rnk
FROM ott.video_streaming_sessions
GROUP BY user_id;

----------------------------------------------------------
-- 3 DENSE_RANK()
----------------------------------------------------------

SELECT
user_id,
SUM(watch_duration) total_watch_time,
DENSE_RANK() OVER(ORDER BY SUM(watch_duration) DESC) drnk
FROM ott.video_streaming_sessions
GROUP BY user_id;

----------------------------------------------------------
-- 4 NTILE()
----------------------------------------------------------

SELECT
user_id,
SUM(watch_duration) total_watch,
NTILE(4) OVER(ORDER BY SUM(watch_duration) DESC) quartile
FROM ott.video_streaming_sessions
GROUP BY user_id;

----------------------------------------------------------
-- 5 LAG()
----------------------------------------------------------

SELECT
DATE(transaction_timestamp),
SUM(subscription_amount),
LAG(SUM(subscription_amount))
OVER(ORDER BY DATE(transaction_timestamp))
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY DATE(transaction_timestamp);

----------------------------------------------------------
-- 6 LEAD()
----------------------------------------------------------

SELECT
DATE(transaction_timestamp),
SUM(subscription_amount),
LEAD(SUM(subscription_amount))
OVER(ORDER BY DATE(transaction_timestamp))
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY DATE(transaction_timestamp);

----------------------------------------------------------
-- 7 Running Revenue
----------------------------------------------------------

SELECT
DATE(transaction_timestamp),
SUM(subscription_amount) revenue,
SUM(SUM(subscription_amount))
OVER(ORDER BY DATE(transaction_timestamp))
running_total
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY DATE(transaction_timestamp);

----------------------------------------------------------
-- 8 Moving Average
----------------------------------------------------------

SELECT
DATE(transaction_timestamp),
SUM(subscription_amount),
AVG(SUM(subscription_amount))
OVER(
ORDER BY DATE(transaction_timestamp)
ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
)
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY DATE(transaction_timestamp);

----------------------------------------------------------
-- 9 Top User Per Device
----------------------------------------------------------

SELECT *
FROM
(
SELECT
device_type,
user_id,
SUM(watch_duration) total_watch,
ROW_NUMBER() OVER
(PARTITION BY device_type
ORDER BY SUM(watch_duration) DESC) rn
FROM ott.video_streaming_sessions
GROUP BY device_type,user_id
)t
WHERE rn=1;

----------------------------------------------------------
--10 Highest Rated Content Per Genre
----------------------------------------------------------

SELECT *
FROM
(
SELECT
genre,
title,
rating,
ROW_NUMBER() OVER
(PARTITION BY genre
ORDER BY rating DESC) rn
FROM ott.content_metadata
)t
WHERE rn=1;

----------------------------------------------------------
--11 Revenue Rank
----------------------------------------------------------

SELECT
user_id,
SUM(subscription_amount),
RANK() OVER
(ORDER BY SUM(subscription_amount) DESC)
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY user_id;

----------------------------------------------------------
--12 Most Active User Per Month
----------------------------------------------------------

SELECT *
FROM
(
SELECT
DATE_TRUNC('month',session_timestamp) month,
user_id,
COUNT(*) sessions,
ROW_NUMBER() OVER(
PARTITION BY DATE_TRUNC('month',session_timestamp)
ORDER BY COUNT(*) DESC
) rn
FROM ott.video_streaming_sessions
GROUP BY month,user_id
)t
WHERE rn=1;

----------------------------------------------------------
--13 JOIN
----------------------------------------------------------

SELECT
u.user_id,
u.account_status,
COUNT(v.session_id)
FROM ott.users u
JOIN ott.video_streaming_sessions v
ON u.user_id=v.user_id
GROUP BY u.user_id,u.account_status;

----------------------------------------------------------
--14 LEFT JOIN
----------------------------------------------------------

SELECT
c.content_id,
c.title,
COUNT(v.session_id)
FROM ott.content_metadata c
LEFT JOIN ott.video_streaming_sessions v
ON c.content_id=v.content_id
GROUP BY c.content_id,c.title;

----------------------------------------------------------
--15 RIGHT JOIN
----------------------------------------------------------

SELECT
u.user_id,
v.session_id
FROM ott.users u
RIGHT JOIN ott.video_streaming_sessions v
ON u.user_id=v.user_id;

----------------------------------------------------------
--16 FULL JOIN
----------------------------------------------------------

SELECT
u.user_id,
v.session_id
FROM ott.users u
FULL JOIN ott.video_streaming_sessions v
ON u.user_id=v.user_id;

----------------------------------------------------------
--17 Users Above Average Watch Time
----------------------------------------------------------

SELECT user_id,
SUM(watch_duration)
FROM ott.video_streaming_sessions
GROUP BY user_id
HAVING SUM(watch_duration)>
(
SELECT AVG(total_watch)
FROM
(
SELECT SUM(watch_duration) total_watch
FROM ott.video_streaming_sessions
GROUP BY user_id
)x
);

----------------------------------------------------------
--18 Top 10 Revenue Users
----------------------------------------------------------

SELECT
user_id,
SUM(subscription_amount)
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY user_id
ORDER BY SUM(subscription_amount) DESC
LIMIT 10;

----------------------------------------------------------
--19 CTE
----------------------------------------------------------

WITH revenue AS
(
SELECT
user_id,
SUM(subscription_amount) total_revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY user_id
)
SELECT *
FROM revenue
ORDER BY total_revenue DESC;

----------------------------------------------------------
--20 Multiple CTE
----------------------------------------------------------

WITH sessions AS
(
SELECT
user_id,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY user_id
),
revenue AS
(
SELECT
user_id,
SUM(subscription_amount) revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY user_id
)
SELECT
s.user_id,
total_sessions,
revenue
FROM sessions s
LEFT JOIN revenue r
ON s.user_id=r.user_id;

----------------------------------------------------------
--21 CASE
----------------------------------------------------------

SELECT
user_id,
CASE
WHEN SUM(watch_duration)>1000 THEN 'Heavy'
WHEN SUM(watch_duration)>500 THEN 'Medium'
ELSE 'Light'
END
FROM ott.video_streaming_sessions
GROUP BY user_id;

----------------------------------------------------------
--22 Correlated Subquery
----------------------------------------------------------

SELECT *
FROM ott.content_metadata c
WHERE rating>
(
SELECT AVG(rating)
FROM ott.content_metadata
WHERE genre=c.genre
);

----------------------------------------------------------
--23 EXISTS
----------------------------------------------------------

SELECT *
FROM ott.users u
WHERE EXISTS
(
SELECT 1
FROM ott.subscription_transactions s
WHERE s.user_id=u.user_id
);

----------------------------------------------------------
--24 NOT EXISTS
----------------------------------------------------------

SELECT *
FROM ott.users u
WHERE NOT EXISTS
(
SELECT 1
FROM ott.subscription_transactions s
WHERE s.user_id=u.user_id
);

----------------------------------------------------------
--25 INTERVIEW QUERY
Highest Revenue Genre
----------------------------------------------------------

SELECT
c.genre,
SUM(s.subscription_amount)
FROM ott.subscription_transactions s
JOIN ott.video_streaming_sessions v
ON s.user_id=v.user_id
JOIN ott.content_metadata c
ON c.content_id=v.content_id
WHERE payment_status='Success'
GROUP BY c.genre
ORDER BY SUM(subscription_amount) DESC;