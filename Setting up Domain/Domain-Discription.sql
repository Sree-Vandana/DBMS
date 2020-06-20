The Movie Database


Introduction:

The movie database TMDB, which is biggest source of metadata is a community-built movie and
tv show database created to answer many questions related to movie industry.

In our movie database domain, we have taken subset of this huge metadata (around 5000 movies)
which contains information about Movie Names, Lead Actors Names, Genre, Budget of that
Movie, Revenue, Release date, Rating given to that movie, Run Time of the movie etc.

For our project we are considering dataset from www.kaggles.com, the link to dataset that we are
using is https://www.kaggle.com/tmdb/tmdb-movie-metadata
Relational Schema:
Using the “tmdb-movie-metadata” data source, we are able to generate 8 relational database tables containing different datatypes, attributes, relations and cardinalities. The relational schema is described below.

i.	Movies (movie_id, title, release_date, year, run_time, votes)
Movies.title has UNIQUE constraint on it

ii.	Genre (genre_id, genre_name)

iii.	Movie_Genre (movie_id, genre_id)
movie_id is a foreign key referring to Movies.movie_id
genre_id is a foreign key referring to Genre.genre_id

iv.	Budget_Revenue (movie_id, m_budget, m_revenue)
movie_id is a foreign key referring to Movies.movie_id

v.	Profit (movie_id, profit)
movie_id is a foreign key referring to Movies.movie_id
(Here movie_id is both primary key and a foreign key; Profit entity has one-to-one relation with Movies entity)

vi.	Gender(gender_id, gender) 

vii.	Actors (actor_id, actor_name, gender_id)
gender_id is a foreign key references to Gender.gender_id

viii.	Movie_Actors (movie_id, actor_id)
movie_id is a foreign key references to Movies.movie_id
actor_id is a foreign key references to Actors.actor_id
