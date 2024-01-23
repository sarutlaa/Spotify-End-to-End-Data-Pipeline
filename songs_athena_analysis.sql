SELECT * FROM "spotify_db"."songs_data" limit 10;

-- Average Popularity for each album_id
SELECT album_id, AVG(popularity) AS avg_popularity
FROM "spotify_db"."songs_data"
GROUP BY album_id;

SELECT MAX(duration_ms) as max, MIN(duration_ms) as min
FROM "spotify_db"."songs_data";

-- Average Popularity greater than or = 90 for an artist.
SELECT artist_id, round(avg(popularity),2) as avgerage_popularity
FROM "spotify_db"."songs_data"
group by artist_id
having avg(popularity) >= 90;

-- Album with the Longest Total Duration of Songs
SELECT album_id, SUM(duration_ms) AS total_duration
FROM "spotify_db"."songs_data"
GROUP BY album_id
ORDER BY total_duration DESC
LIMIT 1;

-- Album with the Highest Average Popularity
SELECT album_id, AVG(popularity) AS avg_popularity
FROM "spotify_db"."songs_data"
GROUP BY album_id
ORDER BY avg_popularity DESC
LIMIT 1;
