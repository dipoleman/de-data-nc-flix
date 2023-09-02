\c nc_flix

\echo '\n 1. Here are all the movie titles which were released in the 21st century:'
SELECT * FROM movies 
WHERE release_date >= '2000-01-01';


\echo '\n 2. This is our oldest customer:'
SELECT * FROM customers;

SELECT * FROM customers 
ORDER BY date_of_birth LIMIT 1;


\echo '\n 3. Customers beginning with D (youngest to oldest):'
SELECT * FROM customers 
WHERE customer_name LIKE 'D%' 
ORDER BY date_of_birth DESC;


\echo '\n 4. This is the average rating of the all the movies made in the 80s:'
SELECT * FROM movies;

SELECT ROUND(AVG(rating),2) AS average_rating_of_80s_movies 
FROM movies 
WHERE release_date >= '1980-01-01' AND release_date < '1990-01-01';



\echo '\n 5. These are the locations our customers live in, along with the total, and average number of loyalty points in that area.'


SELECT location,
    SUM(COALESCE(loyalty_points, 0)) AS total_loyalty_points, 
    ROUND(AVG(COALESCE(loyalty_points, 0)),2) AS average_loyalty_points
FROM customers GROUP BY location;

\echo '\n 6. After decreasing the price of the movie rentals, the movie table now looks like:'
UPDATE movies SET cost = ROUND(cost*0.95,2);
SELECT * FROM movies;





