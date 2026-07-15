/*==========================================================
EXECUTIVE DASHBOARD
==========================================================*/

-- 1. Total Users
SELECT COUNT(*) AS total_users
FROM ott.users;

-- 2. Active Users
SELECT COUNT(*) AS active_users
FROM ott.users
WHERE account_status='Active';

-- 3. Inactive Users
SELECT COUNT(*) AS inactive_users
FROM ott.users
WHERE account_status='Inactive';

-- 4. Total Content
SELECT COUNT(*) AS total_content
FROM ott.content_metadata;

-- 5. Total Streaming Sessions
SELECT COUNT(*) AS total_streaming_sessions
FROM ott.video_streaming_sessions;

-- 6. Total Watch Hours
SELECT ROUND(SUM(watch_duration)/60.0,2) AS total_watch_hours
FROM ott.video_streaming_sessions;

-- 7. Average Watch Duration
SELECT ROUND(AVG(watch_duration),2) AS avg_watch_duration
FROM ott.video_streaming_sessions;

-- 8. Average Buffering Time
SELECT ROUND(AVG(buffering_time),2) AS avg_buffering_time
FROM ott.video_streaming_sessions;

-- 9. Total Revenue
SELECT ROUND(SUM(subscription_amount),2) AS total_revenue
FROM ott.subscription_transactions
WHERE payment_status='Success';

-- 10. Average Revenue Per Transaction
SELECT ROUND(AVG(subscription_amount),2) AS avg_transaction
FROM ott.subscription_transactions
WHERE payment_status='Success';

-- 11. Total Successful Payments
SELECT COUNT(*) AS successful_payments
FROM ott.subscription_transactions
WHERE payment_status='Success';

-- 12. Total Failed Payments
SELECT COUNT(*) AS failed_payments
FROM ott.subscription_transactions
WHERE payment_status='Failed';

-- 13. Total Pending Payments
SELECT COUNT(*) AS pending_payments
FROM ott.subscription_transactions
WHERE payment_status='Pending';

-- 14. Payment Success Rate
SELECT
ROUND(
100.0*
COUNT(*) FILTER(WHERE payment_status='Success')/
COUNT(*),2
) AS payment_success_rate
FROM ott.subscription_transactions;

-- 15. Session Completion Rate
SELECT
ROUND(
100.0*
COUNT(*) FILTER(WHERE session_status='Completed')/
COUNT(*),2
) AS completion_rate
FROM ott.video_streaming_sessions;

-- 16. Session Drop Rate
SELECT
ROUND(
100.0*
COUNT(*) FILTER(WHERE session_status='Dropped')/
COUNT(*),2
) AS drop_rate
FROM ott.video_streaming_sessions;

-- 17. Pause Rate
SELECT
ROUND(
100.0*
COUNT(*) FILTER(WHERE session_status='Paused')/
COUNT(*),2
) AS pause_rate
FROM ott.video_streaming_sessions;

-- 18. Total Searches
SELECT COUNT(*) AS total_searches
FROM ott.search_recommendation_logs;

-- 19. Average Recommendation Score
SELECT ROUND(AVG(recommendation_score),2) AS avg_recommendation_score
FROM ott.search_recommendation_logs;

-- 20. Total Click Events
SELECT COUNT(*) AS total_click_events
FROM ott.app_clickstream_events;

-- 21. Crash Percentage
SELECT
ROUND(
100.0*
COUNT(*) FILTER(WHERE crash_flag=TRUE)/
COUNT(*),2
) AS app_crash_percentage
FROM ott.app_clickstream_events;

-- 22. Average CDN Latency
SELECT ROUND(AVG(latency),2) AS avg_latency
FROM ott.cdn_buffering_logs;

-- 23. Average Packet Loss
SELECT ROUND(AVG(packet_loss),2) AS avg_packet_loss
FROM ott.cdn_buffering_logs;

-- 24. Buffering Spike Percentage
SELECT
ROUND(
100.0*
COUNT(*) FILTER(WHERE buffering_spike=TRUE)/
COUNT(*),2
) AS buffering_spike_percentage
FROM ott.cdn_buffering_logs;

-- 25. Total Genres
SELECT COUNT(DISTINCT genre) AS total_genres
FROM ott.content_metadata;