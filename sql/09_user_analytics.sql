/*==========================================================
USER ANALYTICS
==========================================================*/

-- 1. Users by Account Status
SELECT
account_status,
COUNT(*) total_users
FROM ott.users
GROUP BY account_status;

-- 2. Users Registered by Year
SELECT
EXTRACT(YEAR FROM account_created_date) year,
COUNT(*) total_users
FROM ott.users
GROUP BY year
ORDER BY year;

-- 3. Users Registered by Month
SELECT
DATE_TRUNC('month',account_created_date) month,
COUNT(*) total_users
FROM ott.users
GROUP BY month
ORDER BY month;

-- 4. Top 20 Most Active Users
SELECT
user_id,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY user_id
ORDER BY total_sessions DESC
LIMIT 20;

-- 5. Top 20 Users by Watch Time
SELECT
user_id,
SUM(watch_duration) total_watch_time
FROM ott.video_streaming_sessions
GROUP BY user_id
ORDER BY total_watch_time DESC
LIMIT 20;

-- 6. Least Active Users
SELECT
user_id,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY user_id
ORDER BY total_sessions
LIMIT 20;

-- 7. Average Sessions Per User
SELECT
ROUND(
COUNT(*)::NUMERIC/
COUNT(DISTINCT user_id),2
)
AS avg_sessions_per_user
FROM ott.video_streaming_sessions;

-- 8. Average Watch Time Per User
SELECT
ROUND(AVG(total_watch),2)
FROM
(
SELECT
user_id,
SUM(watch_duration) total_watch
FROM ott.video_streaming_sessions
GROUP BY user_id
)t;

-- 9. Average Buffering Per User
SELECT
user_id,
ROUND(AVG(buffering_time),2) avg_buffering
FROM ott.video_streaming_sessions
GROUP BY user_id
ORDER BY avg_buffering DESC;

-- 10. Users With Highest Buffering
SELECT
user_id,
SUM(buffering_time) total_buffering
FROM ott.video_streaming_sessions
GROUP BY user_id
ORDER BY total_buffering DESC
LIMIT 20;

-- 11. Device Preference
SELECT
user_id,
device_type,
COUNT(*) sessions
FROM ott.video_streaming_sessions
GROUP BY user_id,device_type
ORDER BY user_id;

-- 12. Preferred Streaming Quality
SELECT
stream_quality,
COUNT(*) total
FROM ott.video_streaming_sessions
GROUP BY stream_quality
ORDER BY total DESC;

-- 13. Users Watching 4K
SELECT
COUNT(DISTINCT user_id)
FROM ott.video_streaming_sessions
WHERE stream_quality='4K';

-- 14. Users Watching on Mobile
SELECT
COUNT(DISTINCT user_id)
FROM ott.video_streaming_sessions
WHERE device_type='Mobile';

-- 15. Average Completion Rate
SELECT
ROUND(AVG(completion_rate),2)
FROM ott.user_watch_history;

-- 16. Highest Completion Users
SELECT
user_id,
ROUND(AVG(completion_rate),2) completion
FROM ott.user_watch_history
GROUP BY user_id
ORDER BY completion DESC
LIMIT 20;

-- 17. Lowest Completion Users
SELECT
user_id,
ROUND(AVG(completion_rate),2) completion
FROM ott.user_watch_history
GROUP BY user_id
ORDER BY completion
LIMIT 20;

-- 18. Average Pause Count
SELECT
ROUND(AVG(pause_count),2)
FROM ott.user_watch_history;

-- 19. Average Skip Count
SELECT
ROUND(AVG(skip_count),2)
FROM ott.user_watch_history;

-- 20. Users With Highest Skip Count
SELECT
user_id,
SUM(skip_count) total_skips
FROM ott.user_watch_history
GROUP BY user_id
ORDER BY total_skips DESC
LIMIT 20;

-- 21. Users By Region
SELECT
region,
COUNT(DISTINCT user_id)
FROM ott.user_watch_history
GROUP BY region
ORDER BY COUNT(*) DESC;

-- 22. Active Users By Region
SELECT
region,
COUNT(DISTINCT user_id)
FROM ott.user_watch_history
GROUP BY region;

-- 23. Average Watch Time By Region
SELECT
region,
ROUND(AVG(watch_time),2)
FROM ott.user_watch_history
GROUP BY region
ORDER BY AVG(watch_time) DESC;

-- 24. Average Completion By Region
SELECT
region,
ROUND(AVG(completion_rate),2)
FROM ott.user_watch_history
GROUP BY region
ORDER BY AVG(completion_rate) DESC;

-- 25. Average Skip By Region
SELECT
region,
ROUND(AVG(skip_count),2)
FROM ott.user_watch_history
GROUP BY region;

-- 26. User Lifetime Sessions
SELECT
user_id,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY user_id
ORDER BY total_sessions DESC;

-- 27. Average Streaming Days
SELECT
user_id,
COUNT(DISTINCT DATE(session_timestamp))
FROM ott.video_streaming_sessions
GROUP BY user_id
ORDER BY COUNT(*) DESC;

-- 28. User First Streaming Date
SELECT
user_id,
MIN(session_timestamp)
FROM ott.video_streaming_sessions
GROUP BY user_id;

-- 29. User Latest Streaming Date
SELECT
user_id,
MAX(session_timestamp)
FROM ott.video_streaming_sessions
GROUP BY user_id;

-- 30. Top Power Users
SELECT
user_id,
COUNT(*) sessions,
SUM(watch_duration) watch_time,
ROUND(AVG(buffering_time),2) buffering
FROM ott.video_streaming_sessions
GROUP BY user_id
ORDER BY watch_time DESC
LIMIT 20;