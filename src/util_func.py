from pg8000.native import Connection, identifier
from os import environ
from pprint import pprint
import datetime


def select_movies(sort_key='title', order='ASC', min_rating=0, location=None):
    db_user = environ.get('PGUSER')
    db_database = environ.get('PGDATABASE')

    conn = Connection(db_user, database=db_database)
    table_name = 'movies'

    if location == None:
        query = f'''SELECT movie_id, title, release_date, rating, cost, classification 
                    FROM {identifier(table_name)} 
                    WHERE COALESCE(rating, 0) >= :min_rating
                    ORDER BY {identifier(sort_key)} {identifier(order)}'''
    else:
        query = f'''SELECT movie_id, title, release_date, rating, cost, classification, city 
                    FROM movies
                    JOIN stock USING (movie_id)
                    JOIN stores USING (store_id)
                    WHERE COALESCE(rating, 0) >= :min_rating AND city = :location
                    ORDER BY {identifier(sort_key)} {identifier(order)}
                 '''

    params = {
        'min_rating': min_rating,
        'location': location
    }

    rows = conn.run(query, **params)
    # pprint(rows)

    movies = []

    for movie in rows:
        movie_id = movie[0]
        title = movie[1]
        release_date = movie[2].strftime("%d:%m:%Y")
        rating = movie[3]
        cost = float(movie[4])
        classification = movie[5]

        if location == None:
            movies.append({'movie_id': movie_id,
                           'title': title,
                           'release_date': release_date,
                           'rating': rating,
                           'cost': cost,
                           'classification': classification})
        else:
            location = movie[6]
            movies.append({'movie_id': movie_id,
                           'title': title,
                           'release_date': release_date,
                           'rating': rating,
                           'cost': cost,
                           'classification': classification,
                           'location': location})
    # pprint(movies)
    conn.close()

    return movies


def query_rentals(rental_id):

    db_user = environ.get('PGUSER')
    db_database = environ.get('PGDATABASE')

    conn = Connection(db_user, database=db_database)

    query = f'''
            SELECT rental_id, store_id, city, location, title FROM rentals
            JOIN stock USING (stock_id)
            JOIN customers USING (customer_id)
            JOIN stores USING (store_id)
            JOIN movies USING (movie_id)
            WHERE rental_id = :rental_id;
            '''
    params = {
        'rental_id': rental_id
    }
    rows = conn.run(query, **params)

    query2 = f'''
            SELECT location, COUNT(customer_name) FROM customers
            WHERE location = :store_location
            GROUP BY location;
            '''
    store_location = rows[0][2]
    params2 = {
        'store_location': store_location
    }
    rows2 = conn.run(query2, **params2)

    query3 = f'''
            SELECT store_id, COUNT(stock_id) FROM stock
            WHERE store_id = :store_id
            GROUP BY store_id;
            '''
    store_id = rows[0][1]
    params3 = {
        'store_id':store_id
    }
    rows3 = conn.run(query3, **params3)

    query4 = f''' 
            SELECT number_of_rentals, customer_name
            FROM rentals
            JOIN stock USING (stock_id)
            JOIN customers USING (customer_id)
            JOIN stores USING (store_id)
            JOIN movies USING (movie_id)
            ORDER BY number_of_rentals DESC
    '''
    rows4 = conn.run(query4)

    # pprint(rows4)

    output = f'''The rental details of this movie are:
        => store id: {rows[0][1]}
        => store location: {rows[0][2]}
        => title: {rows[0][4]}
        => number of customers at location: {rows2[0][1]}
        => number of films in store: {rows3[0][1]}
        => most valued customer: {rows4[0][1]} with {rows4[0][0]} rentals'''
    print(output)

    pass


query_rentals(3)
