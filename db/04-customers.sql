\c nc_flix


\echo '\n 1. Here is the information about the customers and their loyalty status:'

SELECT customer_name,location,
    CASE
        WHEN COALESCE(loyalty_points, 0)  = 0 THEN 'doesn''t even go here'
        WHEN loyalty_points < 10 THEN 'bronze status'
        WHEN loyalty_points <= 100 THEN 'silver status'
        ELSE 'gold status'
    END membership_status

FROM customers;  


\echo '\n 2. Here is a comprehensive output of the customers ordered by loyalty points, and grouped by area:'
-- -   name
-- -   age
-- -   location
-- -   loyalty points

SELECT customer_name,
location,
COALESCE(loyalty_points, 0) AS loyalty_points, 
DATE_PART('year', AGE(date_of_birth)) AS age,
RANK() OVER(PARTITION BY location ORDER BY COALESCE(loyalty_points, 0) DESC)
FROM customers;

SELECT customer_name,
location,
COALESCE(loyalty_points, 0) AS loyalty_points, 
DATE_PART('year', AGE(date_of_birth)) AS age
FROM customers
ORDER BY location,loyalty_points DESC;


\echo '\n Just me messing around, joining all the data\n'

SELECT * FROM stock
JOIN stores USING (store_id)
JOIN movies USING (movie_id)
JOIN movies_genres USING (movie_id)
JOIN genres USING (genre_id)
ORDER BY movie_id;

\echo '\n Just me messing around, joining all the data, but accounting for the different genres\n'
SELECT 
    stock_id,
    movie_id,
    release_date,
    store_id,
    city,
    rating,
    title, 
    STRING_AGG(genre_name, ',') AS genres,
    release_date,
    is_sequel,
    cost
    
FROM stock
JOIN movies USING (movie_id)
JOIN stores USING (store_id)
JOIN movies_genres USING (movie_id)
JOIN genres USING (genre_id)
GROUP BY stock_id,title,release_date,is_sequel,cost,city,rating;

