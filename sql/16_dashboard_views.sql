/*==========================================================
POWER BI DASHBOARD VIEWS
==========================================================*/

------------------------------------------------------------
-- 1 Monthly Revenue
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_monthly_revenue AS
SELECT
DATE_TRUNC('month',transaction_timestamp)::DATE AS month,
ROUND(SUM(subscription_amount),2) AS revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY month
ORDER BY month;

------------------------------------------------------------
-- 2 Revenue by Plan
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_plan_revenue AS
SELECT
plan_type,
ROUND(SUM(subscription_amount),2) revenue
FROM ott.subscription_transactions
WHERE payment_status='Success'
GROUP BY plan_type
ORDER BY revenue DESC;

------------------------------------------------------------
-- 3 Device Usage
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_device_usage AS
SELECT
device_type,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY device_type
ORDER BY total_sessions DESC;

------------------------------------------------------------
-- 4 Stream Quality
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_stream_quality AS
SELECT
stream_quality,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY stream_quality
ORDER BY total_sessions DESC;

------------------------------------------------------------
-- 5 Session Status
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_session_status AS
SELECT
session_status,
COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY session_status;

------------------------------------------------------------
-- 6 Top 20 Content
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_top_content AS
SELECT
c.content_id,
c.title,
SUM(v.watch_duration) total_watch_time
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
GROUP BY c.content_id,c.title
ORDER BY total_watch_time DESC
LIMIT 20;

------------------------------------------------------------
-- 7 Genre Performance
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_genre_performance AS
SELECT
c.genre,
COUNT(v.session_id) total_sessions,
ROUND(SUM(v.watch_duration)/60.0,2) watch_hours
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
GROUP BY c.genre;

------------------------------------------------------------
-- 8 Language Performance
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_language_performance AS
SELECT
c.language,
COUNT(*) sessions,
ROUND(AVG(c.rating),2) avg_rating
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
GROUP BY c.language;

------------------------------------------------------------
-- 9 Search Analytics
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_search_queries AS
SELECT
search_query,
COUNT(*) searches
FROM ott.search_recommendation_logs
GROUP BY search_query
ORDER BY searches DESC;

------------------------------------------------------------
-- 10 Recommendation Performance
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_recommendation_performance AS
SELECT
ROUND(AVG(recommendation_score),2) avg_score,
COUNT(*) total_searches,
COUNT(*) FILTER
(
WHERE recommended_content=clicked_content
) successful_recommendations
FROM ott.search_recommendation_logs;

------------------------------------------------------------
-- 11 User Region
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_region_users AS
SELECT
region,
COUNT(DISTINCT user_id) total_users
FROM ott.user_watch_history
GROUP BY region;

------------------------------------------------------------
--12 CDN Performance
------------------------------------------------------------
CREATE OR REPLACE VIEW ott.vw_cdn_performance AS
SELECT
server_region,
ROUND(AVG(latency),2) avg_latency,
ROUND(AVG(packet_loss),2) avg_packet_loss,
COUNT(*) FILTER
(
WHERE buffering_spike=TRUE
) buffering_spikes
FROM ott.cdn_buffering_logs
GROUP BY server_region;