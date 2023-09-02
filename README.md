# NC-flix

Video streaming services are all well and good, but they lack a certain physical quality. Not to miss out on a questionable business venture, Northcoders is bringing back the **video rental store**!

Business is somewhat slow at the moment (surprisingly!) so we've been tasked to work on the database. At the moment we have the following five data tables (and a junction table):

-   stores

-   customers

-   movies

-   stock

-   genres

An Entity Relationship Diagram (ERD) is a good way to visualise the structure of a database and it's relationships. Follow this link to see how the [NC-Flix database](https://dbdiagram.io/d/63f8ab04296d97641d837f2b) is structured.

# Section One

## Task 1

1. Query the database to retrieve all of the movie titles that were released in the 21st century.

2. Query the database to find the oldest customer.

3. Query the database to find the customers who's name begins with the letter _D_. Organise the results by age, youngest to oldest.

4. Query the database to find the average rating of the movies released in the 1980s.

5. Query the database to list the locations of our customers, the total and average number of loyalty points for all customers. You can assume that if the loyalty points row is empty, they are new customer and so should have a the value set to zero.

6. The rise in living costs is affecting rentals, drop the cost of all rentals by 5% and display the updated table. **As this is a monetary value make sure it is rounded to 2 decimal places**

> _**If you want to run the updates multiple times without going bankrupt, the data will need to be reset. We've added a bash script that will run all of the *.sql files in the ./db folder. Try running the command `./run-all.sh` from your terminal in the root of this repository. This will save the output of each *.sql file in the ./db directory to a \*.txt file of the same name.**_

## Task 2

1. Query the database to find the number of films in stock for each genre.

2. Query the database to find the average rating for films in stock in Newcastle.

3. Query the database to retrieve all the films released in the 90s which have a rating greater than the total average.

4. Query the database to find the total number of copies that are in stock for the top rated film from a pool of the five most recently released films.

5. Query the database to find a list of all the locations customers live in which **don't** contain a store.

6. Query the database to find a list of all the locations we have influence over (locations of stores and/or customers), **there should be no repeated data**.

7. From a list of our stores which have customers living in the same location, calculate which store has the largest catalogue of stock. What is the most abundant genre in that store?

## Task 3

1. Query the database to find the store the highest total number of copies of sequels.

    > _Note: For now let's assume you can tell if a film is a sequel if the title contains something like 'II' or 'VI'._

2. This is likely not a good way to identify sequels going forward. Alter the movies table to track this information better and then update previous query to make use of this new structure.

## Task 4

1. Create an output to display the information on our customers. It should include:

-   name
-   location
-   loyalty membership status (see below)

```
# Loyalty membership tiers

- 'doesn't even go here' - 0 points
- 'bronze status' - < 10 points
- 'silver status' - 10 - 100 points
- 'gold status' - > 100 points
```

_We can assume if the customer has no point information, they have yet to receive any loyalty points._

2. We want more information on our customers:

-   name
-   age
-   location
-   loyalty points

**... however(!) we would like to also like to order them by location and within their location groups, number of loyalty points, high to low.**

## Task 5

1. Design a way of storing information on rentals. A rental should track the following information:

    - rental_id
    - stock_id
    - rental_start
    - rental_end
    - customer_id

    Add some rental rows we can query later.

2. Finally, we have a customer in one of our stores! They wish to rent a film but have some requirements:

-   The film must be age appropriate (classification of U)
-   The film must be available in Birmingham.
-   The film must not have been rented more than 5 times already

Instead of creating a list of only the films that match this criteria, create an output which marks `yes` or `no` in a column that represents the requirement. An example has been given below:

| title   | age_appropriate | in_stock_nearby | not_too_mainstream |
| ------- | --------------- | --------------- | ------------------ |
| x-men 2 | no              | yes             | yes                |

# Section Two

Using the `pg8000` library you can integrate your SQL querying skills with Python. You should build up each function feature by feature using TDD. You can consider your locally hosted database as a test database so we don't need to mock the connection. Any other helper functions should be tested individually.

The happy and sad path should be considered. An error should be raised in the event an invalid query parameter has been passed.

1. Create the function `select_movies`. It should return a list of movie dictionaries. From your locally hosted movies table.
   Each movie should contain the following keys:

-   movie_id
-   title
-   release_date
-   rating
-   classification

The default order of the movies should be alphabetically by title.

2. It should have an optional `sort_by` argument which allows it to be sorted by:

-   release_date
-   rating
-   cost

3. It should accept an optional `order` argument which allows the sort order to be flipped.

4. It should accept an optional `min_rating` argument which filters the list of movies to only contains movies with ratings greater than the passed value.

5. It should accept an optional `location` argument which filters the list of movies to only return the movie titles available in that location.

6. Query the Rental Information table you made in Task 5. Create a single output with the following information:

-   store_id, location, number of customers in the same location
-   number of films available in store
-   most valued customer (customer with the most rentals)
-   most popular film (film with most rentals)
-   average rating of each store (calculated as average of all films in store) rounded to **1 decimal place**

_hint: it might be helpful to build up the query bullet point by bullet point_

7. a) We are refining the quality of the films we currently have in our database by removing the lowest rated. Management has asked you to create an output with information about the lowest rated film of each genre:

-   Genre name
-   Film title
-   Rating

b) Management is now trying to refine the quality of stock in the **Manchester** store particularly. Create an output that that shows:

-   Genre name
-   Film title
-   Rating

**_If the store doesn't stock any films of a certain genre then do not include that genre in the output table._**
