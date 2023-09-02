from src.util_func import select_movies


def test_each_movie_is_a_dictionary():
    result = select_movies()
    assert type(result[0]) is dict


def test_movies_default_sort_by_title():
    expected1 = {'classification': None,
                 'cost': 1.43,
                 'movie_id': 24,
                 'rating': 7,
                 'release_date': '07:07:1988',
                 'title': 'A Fish Called Wanda'}
    expected2 = {'classification': '15',
                 'cost': 1.9,
                 'movie_id': 6,
                 'rating': None,
                 'release_date': '21:10:1982',
                 'title': 'Tron'}
    result1 = select_movies()[0]
    result2 = select_movies()[-1]
    assert expected1 == result1
    assert expected2 == result2


def test_sorted_by_rating():
    expected1 = {'classification': 'U',
                 'cost': 1.43,
                 'movie_id': 4,
                 'rating': 1,
                 'release_date': '26:10:1998',
                 'title': "The Lion King II: Simba's Pride"}
    expected2 = {'classification': None,
                 'cost': 0.95,
                 'movie_id': 11,
                 'rating': None,
                 'release_date': '16:11:2018',
                 'title': 'The Princess Switch'}
    result1 = select_movies('rating')[0]
    result2 = select_movies('rating')[-1]
    assert expected1 == result1
    assert expected2 == result2


def test_should_order_in_descending_when_passed_DESC_in_args():
    expected1 = {'classification': 'U',
                 'cost': 1.43,
                 'movie_id': 4,
                 'rating': 1,
                 'release_date': '26:10:1998',
                 'title': "The Lion King II: Simba's Pride"}
    expected2 = {'classification': None,
                 'cost': 0.95,
                 'movie_id': 11,
                 'rating': None,
                 'release_date': '16:11:2018',
                 'title': 'The Princess Switch'}
    result1 = select_movies('rating', 'DESC')[-1]
    result2 = select_movies('rating', 'DESC')[0]
    assert expected1 == result1
    assert expected2 == result2


def test_should_have_a_min_rating_arg():
    expected = {'classification': '12',
                'cost': 1.19,
                'movie_id': 3,
                'rating': 5,
                'release_date': '15:08:2015',
                'title': 'Todo Sobre Mi Madre'}
    result = select_movies('rating', min_rating=5)[0]
    assert expected == result


def test_should_have_a_key_location_equal_to_value_location_passed_as_arg():
    movies = select_movies(location='Manchester')
    for i in range(len(movies)):
        expected = 'Manchester'
        result = movies[i]['location']
        assert result == expected
