/*==========================================================
PLATFORM ANALYTICS
==========================================================*/

--1 Total Click Events
SELECT COUNT(*) AS total_clicks
FROM ott.app_clickstream_events;

--2 Unique Active Users
SELECT COUNT(DISTINCT user_id) AS active_users
FROM ott.app_clickstream_events;

--3 Total App Crashes
SELECT COUNT(*) AS total_crashes
FROM ott.app_clickstream_events
WHERE crash_flag=TRUE;

--4 Crash Percentage
SELECT
ROUND(
100.0*
COUNT(*) FILTER(WHERE crash_flag=TRUE)/
COUNT(*),2
) AS crash_percentage
FROM ott.app_clickstream_events;

--5 Click Events by Screen
SELECT
screen_name,
COUNT(*) total_clicks
FROM ott.app_clickstream_events
GROUP BY screen_name
ORDER BY total_clicks DESC;

--6 Click Events by Action
SELECT
click_action,
COUNT(*) total_actions
FROM ott.app_clickstream_events
GROUP BY click_action
ORDER BY total_actions DESC;

--7 Average Session Duration
SELECT
ROUND(AVG(session_duration),2)
FROM ott.app_clickstream_events;

--8 Average Session Duration by Screen
SELECT
screen_name,
ROUND(AVG(session_duration),2)
FROM ott.app_clickstream_events
GROUP BY screen_name
ORDER BY AVG(session_duration) DESC;

--9 Crash by Screen
SELECT
screen_name,
COUNT(*) crashes
FROM ott.app_clickstream_events
WHERE crash_flag=TRUE
GROUP BY screen_name
ORDER BY crashes DESC;

--10 Crash by Action
SELECT
click_action,
COUNT(*) crashes
FROM ott.app_clickstream_events
WHERE crash_flag=TRUE
GROUP BY click_action
ORDER BY crashes DESC;

--11 Most Active Users
SELECT
user_id,
COUNT(*) total_events
FROM ott.app_clickstream_events
GROUP BY user_id
ORDER BY total_events DESC
LIMIT 20;

--12 Events by Month
SELECT
DATE_TRUNC('month',event_timestamp) month,
COUNT(*) events
FROM ott.app_clickstream_events
GROUP BY month
ORDER BY month;

--13 Events by Hour
SELECT
EXTRACT(HOUR FROM event_timestamp) hour,
COUNT(*) events
FROM ott.app_clickstream_events
GROUP BY hour
ORDER BY events DESC;

--14 Screen Usage %
SELECT
screen_name,
ROUND(COUNT(*)*100.0/
(SELECT COUNT(*) FROM ott.app_clickstream_events),2)
AS usage_percent
FROM ott.app_clickstream_events
GROUP BY screen_name
ORDER BY usage_percent DESC;

--15 Action Usage %
SELECT
click_action,
ROUND(COUNT(*)*100.0/
(SELECT COUNT(*) FROM ott.app_clickstream_events),2)
AS usage_percent
FROM ott.app_clickstream_events
GROUP BY click_action
ORDER BY usage_percent DESC;

--16 Average Events Per User
SELECT
ROUND(
COUNT(*)::NUMERIC/
COUNT(DISTINCT user_id),2)
FROM ott.app_clickstream_events;

--------------------------------------------------------
-- CDN ANALYTICS
--------------------------------------------------------

--17 Total CDN Events
SELECT COUNT(*)
FROM ott.cdn_buffering_logs;

--18 Average Latency
SELECT ROUND(AVG(latency),2)
FROM ott.cdn_buffering_logs;

--19 Maximum Latency
SELECT MAX(latency)
FROM ott.cdn_buffering_logs;

--20 Minimum Latency
SELECT MIN(latency)
FROM ott.cdn_buffering_logs;

--21 Average Packet Loss
SELECT ROUND(AVG(packet_loss),2)
FROM ott.cdn_buffering_logs;

--22 Maximum Packet Loss
SELECT MAX(packet_loss)
FROM ott.cdn_buffering_logs;

--23 CDN Events by Region
SELECT
server_region,
COUNT(*) events
FROM ott.cdn_buffering_logs
GROUP BY server_region
ORDER BY events DESC;

--24 Average Latency by Region
SELECT
server_region,
ROUND(AVG(latency),2)
FROM ott.cdn_buffering_logs
GROUP BY server_region
ORDER BY AVG(latency) DESC;

--25 Average Packet Loss by Region
SELECT
server_region,
ROUND(AVG(packet_loss),2)
FROM ott.cdn_buffering_logs
GROUP BY server_region
ORDER BY AVG(packet_loss) DESC;

--26 Buffering Spike %
SELECT
ROUND(
100.0*
COUNT(*) FILTER(WHERE buffering_spike=TRUE)/
COUNT(*),2)
FROM ott.cdn_buffering_logs;

--27 Buffering Spikes by Region
SELECT
server_region,
COUNT(*) spikes
FROM ott.cdn_buffering_logs
WHERE buffering_spike=TRUE
GROUP BY server_region
ORDER BY spikes DESC;

--28 Failure Codes
SELECT
failure_code,
COUNT(*) total
FROM ott.cdn_buffering_logs
GROUP BY failure_code
ORDER BY total DESC;

--29 Failure Code by Region
SELECT
server_region,
failure_code,
COUNT(*) total
FROM ott.cdn_buffering_logs
GROUP BY server_region,failure_code
ORDER BY server_region;

--30 Monthly CDN Events
SELECT
DATE_TRUNC('month',event_timestamp) month,
COUNT(*) events
FROM ott.cdn_buffering_logs
GROUP BY month
ORDER BY month;