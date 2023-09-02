\c nc_flix

\echo '\n 1. Here are the number of films in stock for each genre:'

SELECT genres.genre_name, COUNT(movies.title) AS stock
FROM movies_genres
JOIN genres USING (genre_id)
JOIN movies USING (movie_id)
GROUP BY genres.genre_name
ORDER BY genres.genre_name;

\echo '\n 1b. Here are the number of films in stock for each genre:\n'
SELECT genres.genre_name, COUNT(movies.title) AS stock
FROM stock
JOIN stores USING (store_id)
JOIN movies USING (movie_id)
JOIN movies_genres USING (movie_id)
JOIN genres USING (genre_id)
GROUP BY genres.genre_name
ORDER BY genres.genre_name;

\echo '\n 2. Here is the average rating for films in stock in Newcastle:'

SELECT ROUND(AVG(rating), 2) AS Average FROM stock
JOIN movies USING (movie_id)
JOIN stores USING (store_id)
WHERE city = 'Newcastle';

\echo '\n 3. Here are all the films made in 90s with above average rating:'

SELECT * FROM movies WHERE rating > (
SELECT AVG(rating) 
FROM movies 
) 
AND release_date >= '1990-01-01' 
AND release_date < '2000-01-01';


\echo '\n 4. Here is the number of copies of the top rated film of the 5 most recently released films we have in stock:'


WITH ordered_films AS (SELECT DISTINCT title,release_date,rating,
COUNT(title) OVER (PARTITION BY title) AS number_of_films
FROM stock
JOIN movies USING (movie_id)
JOIN stores USING (store_id)
ORDER BY release_date DESC LIMIT 5)
SELECT * FROM ordered_films
ORDER BY rating DESC
LIMIT 1;



\echo '\n 5. These are the locations where our customers live which dont have stores:'

SELECT location FROM customers
EXCEPT SELECT city FROM stores;


\echo '\n 6. These are all the locations which our business has influence over'

SELECT location FROM customers 
UNION SELECT city FROM stores;

\echo '\n 7a. This store has the highest quantity of stock:'

SELECT city, COUNT(title)
FROM stock
JOIN movies USING (movie_id)
JOIN stores USING (store_id)
GROUP BY city
ORDER BY count DESC
LIMIT 1;

\echo '\n 7b. ...and this is the most abundant genre in that store:'


SELECT genre_name, COUNT(title) 
FROM stock
JOIN movies USING (movie_id)
JOIN stores USING (store_id)
JOIN movies_genres USING (movie_id)
JOIN genres USING (genre_id)
WHERE city = (
    WITH most_stock AS (SELECT city, COUNT(title)
                        FROM stock
                        JOIN movies USING (movie_id)
                        JOIN stores USING (store_id)
                        GROUP BY city
                        ORDER BY count DESC
                        LIMIT 1)
    SELECT city FROM most_stock)
GROUP BY genre_name
ORDER BY count DESC
LIMIT 1;
