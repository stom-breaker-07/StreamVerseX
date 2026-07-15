-- ==========================================================
-- MODULE 1 : STREAMING ANALYTICS
-- ==========================================================

-- Q1. Total Streaming Sessions
SELECT COUNT(*) AS total_streaming_sessions
FROM ott.video_streaming_sessions;

-- Q2. Total Unique Users
SELECT COUNT(DISTINCT user_id) AS total_unique_users
FROM ott.video_streaming_sessions;

-- Q3. Total Watch Duration
SELECT SUM(watch_duration) AS total_watch_duration
FROM ott.video_streaming_sessions;

-- Q4. Average Watch Duration
SELECT ROUND(AVG(watch_duration),2) AS avg_watch_duration
FROM ott.video_streaming_sessions;

-- Q5. Peak Streaming Year-Month
SELECT
    EXTRACT(YEAR FROM session_timestamp) AS year,
    EXTRACT(MONTH FROM session_timestamp) AS month,
    COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions
GROUP BY year, month
ORDER BY total_sessions DESC;

-- Q6. Peak Streaming Day
SELECT
    DATE(session_timestamp) AS streaming_date,
    COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions
GROUP BY streaming_date
ORDER BY total_sessions DESC;

-- Q7. Peak Streaming Hour
SELECT
    EXTRACT(HOUR FROM session_timestamp) AS hour,
    COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions
GROUP BY hour
ORDER BY total_sessions DESC;

-- Q8. Device-wise Streaming
SELECT
    device_type,
    COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions
GROUP BY device_type
ORDER BY total_sessions DESC;

-- Q9. Stream Quality Distribution
SELECT
    stream_quality,
    COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions
GROUP BY stream_quality
ORDER BY total_sessions DESC;

-- Q10. Session Status Distribution
SELECT
    session_status,
    COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions
GROUP BY session_status
ORDER BY total_sessions DESC;

-- Q11. Average Buffering Time
SELECT
    ROUND(AVG(buffering_time),2) AS avg_buffering_time
FROM ott.video_streaming_sessions;

-- Q12. Maximum Buffering Time
SELECT
    MAX(buffering_time) AS max_buffering_time
FROM ott.video_streaming_sessions;

-- Q13. Average Watch Duration by Device
SELECT
    device_type,
    ROUND(AVG(watch_duration),2) AS avg_watch_duration
FROM ott.video_streaming_sessions
GROUP BY device_type
ORDER BY avg_watch_duration DESC;

-- Q14. Average Buffering Time by Device
SELECT
    device_type,
    ROUND(AVG(buffering_time),2) AS avg_buffering_time
FROM ott.video_streaming_sessions
GROUP BY device_type
ORDER BY avg_buffering_time DESC;

-- Q15. Streaming Quality vs Average Watch Time
SELECT
    stream_quality,
    ROUND(AVG(watch_duration),2) AS avg_watch_duration
FROM ott.video_streaming_sessions
GROUP BY stream_quality
ORDER BY avg_watch_duration DESC;

-- Q16. Streaming Quality vs Buffering
SELECT
    stream_quality,
    ROUND(AVG(buffering_time),2) AS avg_buffering_time
FROM ott.video_streaming_sessions
GROUP BY stream_quality
ORDER BY avg_buffering_time DESC;

-- Q17. Completed Sessions Percentage
SELECT
ROUND(
100.0 * SUM(CASE WHEN session_status='Completed' THEN 1 ELSE 0 END)/COUNT(*),
2
) AS completed_percentage
FROM ott.video_streaming_sessions;

-- Q18. Dropped Sessions Percentage
SELECT
ROUND(
100.0 * SUM(CASE WHEN session_status='Dropped' THEN 1 ELSE 0 END)/COUNT(*),
2
) AS dropped_percentage
FROM ott.video_streaming_sessions;

-- Q19. Paused Sessions Percentage
SELECT
ROUND(
100.0 * SUM(CASE WHEN session_status='Paused' THEN 1 ELSE 0 END)/COUNT(*),
2
) AS paused_percentage
FROM ott.video_streaming_sessions;

-- Q20. Top 10 Users by Watch Duration
SELECT
    user_id,
    SUM(watch_duration) AS total_watch_duration
FROM ott.video_streaming_sessions
GROUP BY user_id
ORDER BY total_watch_duration DESC
LIMIT 10;

-- Q21. Top 10 Videos by Watch Duration
SELECT
    video_id,
    SUM(watch_duration) AS total_watch_duration
FROM ott.video_streaming_sessions
GROUP BY video_id
ORDER BY total_watch_duration DESC
LIMIT 10;

-- Q22. Top 10 Videos by Sessions
SELECT
    video_id,
    COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions
GROUP BY video_id
ORDER BY total_sessions DESC
LIMIT 10;

-- Q23. Monthly Average Buffering
SELECT
    EXTRACT(MONTH FROM session_timestamp) AS month,
    ROUND(AVG(buffering_time),2) AS avg_buffering
FROM ott.video_streaming_sessions
GROUP BY month
ORDER BY month;

-- Q24. Monthly Average Watch Duration
SELECT
    EXTRACT(MONTH FROM session_timestamp) AS month,
    ROUND(AVG(watch_duration),2) AS avg_watch_duration
FROM ott.video_streaming_sessions
GROUP BY month
ORDER BY month;

-- Q25. Monthly Streaming Trend
SELECT
    DATE_TRUNC('month',session_timestamp) AS month,
    COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions
GROUP BY month
ORDER BY month;

-- Q26. Yearly Streaming Trend
SELECT
    EXTRACT(YEAR FROM session_timestamp) AS year,
    EXTRACT(MONTH FROM session_timestamp) AS month,
    COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions
GROUP BY
    EXTRACT(YEAR FROM session_timestamp),
    EXTRACT(MONTH FROM session_timestamp)
ORDER BY
    year,
    month;