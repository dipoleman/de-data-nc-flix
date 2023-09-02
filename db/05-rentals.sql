\c nc_flix

CREATE TABLE rentals (
    rental_id SERIAL PRIMARY KEY,
    stock_id INT REFERENCES stock(stock_id),
    rental_start DATE,
    rental_end DATE,
    customer_id INT REFERENCES customers(customer_id)
);

INSERT INTO rentals
    (stock_id, rental_start, rental_end, customer_id)
VALUES 
    (1, '2022-01-01', '2022-01-03', 5),
    (2, '2022-01-02', '2022-01-04', 3),
    (3, '2022-01-03', '2022-01-05', 2),
    (4, '2022-01-04', '2022-01-06', 4),
    (5, '2022-01-05', '2022-01-07', 1);
    


ALTER TABLE stock
ADD number_of_rentals INT;

UPDATE stock 
SET number_of_rentals = FLOOR(RANDOM()*11);



SELECT 
    DISTINCT title,
    city,
    CASE
        WHEN classification = 'U' THEN 'yes'
        ELSE 'no'
    END age_appropriate,
    CASE
        WHEN city = 'Birmingham' THEN 'yes'
        ELSE 'no'
    END in_stock_nearby,
    
    CASE
        WHEN AVG(number_of_rentals) OVER (PARTITION BY title)<= 5 THEN 'yes'
        ELSE 'no'
    END not_too_mainstream
FROM stock
JOIN stores USING (store_id)
JOIN movies USING (movie_id)
ORDER BY city;

-- SELECT rental_id, store_id, city, location, title FROM rentals
--             JOIN stock USING (stock_id)
--             JOIN customers USING (customer_id)
--             JOIN stores USING (store_id)
--             JOIN movies USING (movie_id)
SELECT * FROM customers;

SELECT * FROM rentals
            JOIN stock USING (stock_id)
            JOIN customers USING (customer_id)
            JOIN stores USING (store_id)
            JOIN movies USING (movie_id);
SELECT * FROM rentals;

SELECT * FROM stock