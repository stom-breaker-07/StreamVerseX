/*==========================================================
SEARCH & RECOMMENDATION ANALYTICS
==========================================================*/

--1 Total Searches
SELECT COUNT(*) AS total_searches
FROM ott.search_recommendation_logs;

--2 Unique Search Users
SELECT COUNT(DISTINCT user_id) AS unique_users
FROM ott.search_recommendation_logs;

--3 Average Recommendation Score
SELECT ROUND(AVG(recommendation_score),2) AS avg_score
FROM ott.search_recommendation_logs;

--4 Highest Recommendation Score
SELECT *
FROM ott.search_recommendation_logs
ORDER BY recommendation_score DESC
LIMIT 20;

--5 Lowest Recommendation Score
SELECT *
FROM ott.search_recommendation_logs
ORDER BY recommendation_score
LIMIT 20;

--6 Most Popular Search Queries
SELECT
search_query,
COUNT(*) total_searches
FROM ott.search_recommendation_logs
GROUP BY search_query
ORDER BY total_searches DESC
LIMIT 20;

--7 Searches by Month
SELECT
DATE_TRUNC('month',search_timestamp) month,
COUNT(*) total_searches
FROM ott.search_recommendation_logs
GROUP BY month
ORDER BY month;

--8 Searches by Year
SELECT
EXTRACT(YEAR FROM search_timestamp) year,
COUNT(*) total_searches
FROM ott.search_recommendation_logs
GROUP BY year
ORDER BY year;

--9 Average Recommendation Score by Query
SELECT
search_query,
ROUND(AVG(recommendation_score),2)
FROM ott.search_recommendation_logs
GROUP BY search_query
ORDER BY AVG(recommendation_score) DESC;

--10 Top Recommended Content
SELECT
recommended_content,
COUNT(*) recommendations
FROM ott.search_recommendation_logs
GROUP BY recommended_content
ORDER BY recommendations DESC
LIMIT 20;

--11 Top Clicked Content
SELECT
clicked_content,
COUNT(*) clicks
FROM ott.search_recommendation_logs
GROUP BY clicked_content
ORDER BY clicks DESC
LIMIT 20;

--12 Successful Recommendations
SELECT COUNT(*)
FROM ott.search_recommendation_logs
WHERE recommended_content=clicked_content;

--13 Recommendation Success Rate
SELECT
ROUND(
100.0*
COUNT(*) FILTER
(WHERE recommended_content=clicked_content)
/COUNT(*),2
) success_rate
FROM ott.search_recommendation_logs;

--14 Failed Recommendations
SELECT COUNT(*)
FROM ott.search_recommendation_logs
WHERE recommended_content<>clicked_content;

--15 Highest Searching Users
SELECT
user_id,
COUNT(*) searches
FROM ott.search_recommendation_logs
GROUP BY user_id
ORDER BY searches DESC
LIMIT 20;

--16 Search Activity by Hour
SELECT
EXTRACT(HOUR FROM search_timestamp) hour,
COUNT(*) searches
FROM ott.search_recommendation_logs
GROUP BY hour
ORDER BY searches DESC;

--17 Search Activity by Weekday
SELECT
TO_CHAR(search_timestamp,'Day') weekday,
COUNT(*) searches
FROM ott.search_recommendation_logs
GROUP BY weekday
ORDER BY searches DESC;

--18 Average Score by Month
SELECT
DATE_TRUNC('month',search_timestamp) month,
ROUND(AVG(recommendation_score),2)
FROM ott.search_recommendation_logs
GROUP BY month
ORDER BY month;

--19 Queries Above 0.90 Score
SELECT *
FROM ott.search_recommendation_logs
WHERE recommendation_score>=0.90;

--20 Queries Below 0.30 Score
SELECT *
FROM ott.search_recommendation_logs
WHERE recommendation_score<=0.30;

--21 Search Count by User
SELECT
user_id,
COUNT(*) total_searches
FROM ott.search_recommendation_logs
GROUP BY user_id
ORDER BY total_searches DESC;

--22 Recommendation Distribution
SELECT
ROUND(recommendation_score,1) score,
COUNT(*)
FROM ott.search_recommendation_logs
GROUP BY score
ORDER BY score DESC;

--23 Top Recommended Genres
SELECT
c.genre,
COUNT(*) recommendations
FROM ott.search_recommendation_logs s
JOIN ott.content_metadata c
ON s.recommended_content=c.content_id
GROUP BY c.genre
ORDER BY recommendations DESC;

--24 Top Clicked Genres
SELECT
c.genre,
COUNT(*) clicks
FROM ott.search_recommendation_logs s
JOIN ott.content_metadata c
ON s.clicked_content=c.content_id
GROUP BY c.genre
ORDER BY clicks DESC;

--25 Average Recommendation Score by Genre
SELECT
c.genre,
ROUND(AVG(s.recommendation_score),2)
FROM ott.search_recommendation_logs s
JOIN ott.content_metadata c
ON s.recommended_content=c.content_id
GROUP BY c.genre
ORDER BY AVG(s.recommendation_score) DESC;

--26 Top Languages Recommended
SELECT
c.language,
COUNT(*)
FROM ott.search_recommendation_logs s
JOIN ott.content_metadata c
ON s.recommended_content=c.content_id
GROUP BY c.language
ORDER BY COUNT(*) DESC;

--27 Top Languages Clicked
SELECT
c.language,
COUNT(*)
FROM ott.search_recommendation_logs s
JOIN ott.content_metadata c
ON s.clicked_content=c.content_id
GROUP BY c.language
ORDER BY COUNT(*) DESC;

--28 Most Recommended Titles
SELECT
c.title,
COUNT(*) recommendations
FROM ott.search_recommendation_logs s
JOIN ott.content_metadata c
ON s.recommended_content=c.content_id
GROUP BY c.title
ORDER BY recommendations DESC
LIMIT 20;

--29 Most Clicked Titles
SELECT
c.title,
COUNT(*) clicks
FROM ott.search_recommendation_logs s
JOIN ott.content_metadata c
ON s.clicked_content=c.content_id
GROUP BY c.title
ORDER BY clicks DESC
LIMIT 20;

--30 Search Conversion by Query
SELECT
search_query,
COUNT(*) total_searches,
COUNT(*) FILTER
(WHERE recommended_content=clicked_content) successful_clicks
FROM ott.search_recommendation_logs
GROUP BY search_query
ORDER BY total_searches DESC;