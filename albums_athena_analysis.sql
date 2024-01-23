SELECT * FROM "spotify_db"."album_data" limit 10;

-- Each album tupe consists of how many songs
SELECT album_type, COUNT(*) AS num_albums
FROM "spotify_db"."album_data"
GROUP BY album_type;

-- Select latest released songs
SELECT * FROM "spotify_db"."album_data"
ORDER BY release_date DESC
limit 10;

-- Each album tupe which has atleast 10 tracks.
SELECT album_type, count(total_tracks) FROM "spotify_db"."album_data"
where total_tracks >= 10
group by album_type;


SELECT *
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (ORDER BY release_date) AS row_num
    FROM "spotify_db"."album_data"
    WHERE total_tracks >= 25
) ranked_albums
WHERE total_tracks >= 1;
