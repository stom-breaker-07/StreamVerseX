/*==========================================================
CONTENT ANALYTICS
==========================================================*/

--1 Top 20 Most Watched Content
SELECT content_id,SUM(watch_duration) total_watch_time
FROM ott.video_streaming_sessions
GROUP BY content_id
ORDER BY total_watch_time DESC
LIMIT 20;

--2 Top 20 Most Streamed Content
SELECT content_id,COUNT(*) total_sessions
FROM ott.video_streaming_sessions
GROUP BY content_id
ORDER BY total_sessions DESC
LIMIT 20;

--3 Content by Genre
SELECT genre,COUNT(*) total_content
FROM ott.content_metadata
GROUP BY genre
ORDER BY total_content DESC;

--4 Content by Language
SELECT language,COUNT(*) total_content
FROM ott.content_metadata
GROUP BY language
ORDER BY total_content DESC;

--5 Average Rating by Genre
SELECT genre,ROUND(AVG(rating),2) avg_rating
FROM ott.content_metadata
GROUP BY genre
ORDER BY avg_rating DESC;

--6 Average Duration by Genre
SELECT genre,ROUND(AVG(duration_minutes),2) avg_duration
FROM ott.content_metadata
GROUP BY genre
ORDER BY avg_duration DESC;

--7 Top Rated Content
SELECT content_id,title,rating
FROM ott.content_metadata
ORDER BY rating DESC
LIMIT 20;

--8 Lowest Rated Content
SELECT content_id,title,rating
FROM ott.content_metadata
ORDER BY rating
LIMIT 20;

--9 Longest Movies
SELECT content_id,title,duration_minutes
FROM ott.content_metadata
ORDER BY duration_minutes DESC
LIMIT 20;

--10 Shortest Movies
SELECT content_id,title,duration_minutes
FROM ott.content_metadata
ORDER BY duration_minutes
LIMIT 20;

--11 Content Released by Year
SELECT EXTRACT(YEAR FROM release_date) year,
COUNT(*)
FROM ott.content_metadata
GROUP BY year
ORDER BY year;

--12 Average Rating by Language
SELECT language,
ROUND(AVG(rating),2)
FROM ott.content_metadata
GROUP BY language
ORDER BY AVG(rating) DESC;

--13 Watch Time by Genre
SELECT c.genre,
SUM(v.watch_duration)
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
GROUP BY c.genre
ORDER BY SUM(v.watch_duration) DESC;

--14 Sessions by Genre
SELECT c.genre,
COUNT(*)
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
GROUP BY c.genre
ORDER BY COUNT(*) DESC;

--15 Average Buffering by Genre
SELECT c.genre,
ROUND(AVG(v.buffering_time),2)
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
GROUP BY c.genre
ORDER BY AVG(v.buffering_time) DESC;

--16 Sessions by Language
SELECT c.language,
COUNT(*)
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
GROUP BY c.language
ORDER BY COUNT(*) DESC;

--17 Watch Hours by Language
SELECT c.language,
ROUND(SUM(v.watch_duration)/60.0,2)
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
GROUP BY c.language
ORDER BY SUM(v.watch_duration) DESC;

--18 Completed Sessions by Genre
SELECT c.genre,
COUNT(*)
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
WHERE session_status='Completed'
GROUP BY c.genre
ORDER BY COUNT(*) DESC;

--19 Dropped Sessions by Genre
SELECT c.genre,
COUNT(*)
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
WHERE session_status='Dropped'
GROUP BY c.genre
ORDER BY COUNT(*) DESC;

--20 Average Watch Time by Genre
SELECT c.genre,
ROUND(AVG(v.watch_duration),2)
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
GROUP BY c.genre
ORDER BY AVG(v.watch_duration) DESC;

--21 Top Production Studios
SELECT production_studio,
COUNT(*)
FROM ott.content_metadata
GROUP BY production_studio
ORDER BY COUNT(*) DESC
LIMIT 20;

--22 Average Rating by Studio
SELECT production_studio,
ROUND(AVG(rating),2)
FROM ott.content_metadata
GROUP BY production_studio
ORDER BY AVG(rating) DESC;

--23 Total Watch Time by Studio
SELECT c.production_studio,
SUM(v.watch_duration)
FROM ott.video_streaming_sessions v
JOIN ott.content_metadata c
ON v.content_id=c.content_id
GROUP BY c.production_studio
ORDER BY SUM(v.watch_duration) DESC;

--24 Content Above Rating 8
SELECT COUNT(*)
FROM ott.content_metadata
WHERE rating>=8;

--25 Content Below Rating 5
SELECT COUNT(*)
FROM ott.content_metadata
WHERE rating<5;

--26 Genre Distribution %
SELECT genre,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM ott.content_metadata),2)
FROM ott.content_metadata
GROUP BY genre;

--27 Language Distribution %
SELECT language,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM ott.content_metadata),2)
FROM ott.content_metadata
GROUP BY language;

--28 Top 10 Trending Content
SELECT content_id,
COUNT(*) sessions
FROM ott.video_streaming_sessions
GROUP BY content_id
ORDER BY sessions DESC
LIMIT 10;

--29 Average Watch Time per Content
SELECT content_id,
ROUND(AVG(watch_duration),2)
FROM ott.video_streaming_sessions
GROUP BY content_id
ORDER BY AVG(watch_duration) DESC;

--30 Content Never Streamed
SELECT c.content_id,c.title
FROM ott.content_metadata c
LEFT JOIN ott.video_streaming_sessions v
ON c.content_id=v.content_id
WHERE v.content_id IS NULL;