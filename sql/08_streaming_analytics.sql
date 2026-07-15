/*==========================================================
STREAMING ANALYTICS
==========================================================*/

-- 1. Sessions by Month
SELECT
DATE_TRUNC('month',session_timestamp) AS month,
COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions
GROUP BY month
ORDER BY month;

-- 2. Sessions by Year
SELECT
EXTRACT(YEAR FROM session_timestamp) AS year,
COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions
GROUP BY year
ORDER BY year;

-- 3. Sessions by Device
SELECT
device_type,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY device_type
ORDER BY total_sessions DESC;

-- 4. Sessions by Stream Quality
SELECT
stream_quality,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY stream_quality
ORDER BY total_sessions DESC;

-- 5. Sessions by Status
SELECT
session_status,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY session_status
ORDER BY total_sessions DESC;

-- 6. Average Watch Duration by Device
SELECT
device_type,
ROUND(AVG(watch_duration),2) avg_watch_duration
FROM ott.video_streaming_sessions
GROUP BY device_type
ORDER BY avg_watch_duration DESC;

-- 7. Average Buffering by Device
SELECT
device_type,
ROUND(AVG(buffering_time),2) avg_buffering
FROM ott.video_streaming_sessions
GROUP BY device_type
ORDER BY avg_buffering DESC;

-- 8. Average Watch Duration by Quality
SELECT
stream_quality,
ROUND(AVG(watch_duration),2) avg_watch_duration
FROM ott.video_streaming_sessions
GROUP BY stream_quality
ORDER BY avg_watch_duration DESC;

-- 9. Average Buffering by Quality
SELECT
stream_quality,
ROUND(AVG(buffering_time),2) avg_buffering
FROM ott.video_streaming_sessions
GROUP BY stream_quality
ORDER BY avg_buffering DESC;

-- 10. Top 10 Most Watched Content
SELECT
content_id,
SUM(watch_duration) total_watch_duration
FROM ott.video_streaming_sessions
GROUP BY content_id
ORDER BY total_watch_duration DESC
LIMIT 10;

-- 11. Top 10 Most Streamed Content
SELECT
content_id,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY content_id
ORDER BY total_sessions DESC
LIMIT 10;

-- 12. Top 10 Users by Watch Time
SELECT
user_id,
SUM(watch_duration) total_watch_duration
FROM ott.video_streaming_sessions
GROUP BY user_id
ORDER BY total_watch_duration DESC
LIMIT 10;

-- 13. Peak Streaming Hour
SELECT
EXTRACT(HOUR FROM session_timestamp) hour,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY hour
ORDER BY total_sessions DESC;

-- 14. Peak Streaming Day
SELECT
TO_CHAR(session_timestamp,'Day') weekday,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY weekday
ORDER BY total_sessions DESC;

-- 15. Average Watch Time by Status
SELECT
session_status,
ROUND(AVG(watch_duration),2) avg_watch_duration
FROM ott.video_streaming_sessions
GROUP BY session_status;

-- 16. Average Buffering by Status
SELECT
session_status,
ROUND(AVG(buffering_time),2) avg_buffering
FROM ott.video_streaming_sessions
GROUP BY session_status;

-- 17. Maximum Watch Duration
SELECT MAX(watch_duration)
FROM ott.video_streaming_sessions;

-- 18. Minimum Watch Duration
SELECT MIN(watch_duration)
FROM ott.video_streaming_sessions;

-- 19. Maximum Buffering
SELECT MAX(buffering_time)
FROM ott.video_streaming_sessions;

-- 20. Minimum Buffering
SELECT MIN(buffering_time)
FROM ott.video_streaming_sessions;

-- 21. Average Daily Sessions
SELECT
DATE(session_timestamp) session_date,
COUNT(*) sessions
FROM ott.video_streaming_sessions
GROUP BY session_date
ORDER BY session_date;

-- 22. Monthly Watch Hours
SELECT
DATE_TRUNC('month',session_timestamp) month,
ROUND(SUM(watch_duration)/60.0,2) watch_hours
FROM ott.video_streaming_sessions
GROUP BY month
ORDER BY month;

-- 23. Monthly Buffering
SELECT
DATE_TRUNC('month',session_timestamp) month,
ROUND(AVG(buffering_time),2) avg_buffering
FROM ott.video_streaming_sessions
GROUP BY month
ORDER BY month;

-- 24. Device vs Quality
SELECT
device_type,
stream_quality,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY device_type,stream_quality
ORDER BY device_type;

-- 25. Device vs Status
SELECT
device_type,
session_status,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY device_type,session_status
ORDER BY device_type;

-- 26. Quality vs Status
SELECT
stream_quality,
session_status,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY stream_quality,session_status
ORDER BY stream_quality;

-- 27. Buffering Above 60 Seconds
SELECT COUNT(*)
FROM ott.video_streaming_sessions
WHERE buffering_time>60;

-- 28. Watch Duration Above 2 Hours
SELECT COUNT(*)
FROM ott.video_streaming_sessions
WHERE watch_duration>120;

-- 29. Completed Sessions Above 2 Hours
SELECT COUNT(*)
FROM ott.video_streaming_sessions
WHERE session_status='Completed'
AND watch_duration>120;

-- 30. Average Sessions Per User
SELECT
ROUND(
COUNT(*)::NUMERIC/
COUNT(DISTINCT user_id),
2
) avg_sessions_per_user
FROM ott.video_streaming_sessions;