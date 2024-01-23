SELECT * FROM "spotify_db"."artist_data" limit 10;

SELECT artist_name, count(*) FROM "spotify_db"."artist_data" 
group by artist_name;