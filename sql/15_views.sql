/*====================================================
EXECUTIVE DASHBOARD VIEWS
====================================================*/

-- Total Users
CREATE OR REPLACE VIEW ott.vw_total_users AS
SELECT COUNT(*) AS total_users
FROM ott.users;

-- Active Users
CREATE OR REPLACE VIEW ott.vw_active_users AS
SELECT COUNT(*) AS active_users
FROM ott.users
WHERE account_status='Active';

-- Total Revenue
CREATE OR REPLACE VIEW ott.vw_total_revenue AS
SELECT
ROUND(SUM(subscription_amount),2) AS total_revenue
FROM ott.subscription_transactions
WHERE payment_status='Success';

-- Total Streaming Sessions
CREATE OR REPLACE VIEW ott.vw_total_sessions AS
SELECT COUNT(*) AS total_sessions
FROM ott.video_streaming_sessions;

-- Total Watch Hours
CREATE OR REPLACE VIEW ott.vw_total_watch_hours AS
SELECT
ROUND(SUM(watch_duration)/60.0,2) AS watch_hours
FROM ott.video_streaming_sessions;

-- Average Buffering
CREATE OR REPLACE VIEW ott.vw_average_buffering AS
SELECT
ROUND(AVG(buffering_time),2) AS average_buffering
FROM ott.video_streaming_sessions;