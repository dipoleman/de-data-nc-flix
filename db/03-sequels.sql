\c nc_flix


\echo '\n 1. The store with the highest total of sequels is:'

SELECT city, COUNT(title) 
FROM stock  
JOIN movies USING (movie_id)
JOIN stores USING (store_id)
JOIN movies_genres USING (movie_id)
JOIN genres USING (genre_id)
WHERE title LIKE '%II%' 
OR title LIKE '%IV%' 
OR title LIKE '%IX%'
GROUP BY city
ORDER BY count DESC LIMIT 1;

ALTER TABLE movies 
ADD is_sequel boolean DEFAULT false;


UPDATE movies SET is_sequel = true
WHERE title LIKE '%II%' 
OR title LIKE '%IV%' 
OR title LIKE '%IX%';

SELECT * FROM movies;

SELECT city, COUNT(title) 
FROM stock  
JOIN movies USING (movie_id)
JOIN stores USING (store_id)
JOIN movies_genres USING (movie_id)
JOIN genres USING (genre_id)
WHERE is_sequel = true
GROUP BY city
ORDER BY count DESC LIMIT 1;