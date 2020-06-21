--1. movies released on same date as the movie “Harry Potter and the Goblet of Fire”

select m1.movie_id, m1.title, m1.release_date, m1.year from movies m1, movies m2
where m2.title = 'Harry Potter and the Goblet of Fire' and
m1.release_date = m2.release_date;


--2. movies which have low budget but high revenue? 

select m.movie_id, m.title, br.m_budget, br.m_revenue from budget_revenue br, movies m
where m.movie_id = br.movie_id and 
br.m_budget < m_revenue;


--3. List the name and id of all movies that has a budget over 150000000, with female actors

select m.movie_id, m.title, a.actor_name, br.m_budget from movies m, actors a, budget_revenue br, gender g, movie_actors ma
where m.movie_id = br.movie_id and 
br.m_budget > 150000000 and
ma.movie_id = br.movie_id and
ma.actor_id = a.actor_id and 
a.gender_id = g.gender_id and
g.gender = 'Female';


--4.	Which actor has appeared in most movies and what is that count?

select a.actor_id, a.actor_name, count(ma.actor_id) as max_movies_acted from movie_actors ma, actors a
where a.actor_id = ma.actor_id 
group by (a.actor_id, a.actor_name)
having count(ma.actor_id) IN (select max(ma_count) from
			     (select count(actor_id) as ma_count from movie_actors
			      group by (actor_id)) as max_ma_count);
            
            
--5. What is the highest budgeted movie per year?

select m.movie_id, m.title, m.year, br.m_budget as max_budget from movies m, budget_revenue br,
(select m.year as movie_year, max(br.m_budget) as max_budget from budget_revenue br, movies m
where m.movie_id = br.movie_id
group by(m.year)) as max_budget_year

where m.movie_id = br.movie_id and
m.year = max_budget_year.movie_year and
br.m_budget = max_budget_year.max_budget

order by m.year DESC;


--6.	list the name of the movies and its genre which has the highest votes

select m.title, g.genre_name, m.votes from movies m, genre g, movie_genre mg
where m.movie_id = mg.movie_id and
mg.genre_id = g.genre_id and
m.votes = (select max(m.votes) from movies m);


--7.	find the actor who has the most movies under the genre "Action"

select a.actor_name, count(ma.actor_id) as max_action_movies from genre g, movie_genre mg, movie_actors ma, actors a

where ma.movie_id = mg.movie_id and
mg.genre_id = g.genre_id and
a.actor_id = ma.actor_id and
g.genre_name = 'Action'

GROUP BY (a.actor_name)
HAVING count(ma.actor_id) = (

select max(action_count)from
(select count(ma.actor_id) as action_count from genre g, movie_genre mg, movie_actors ma, actors a
where ma.movie_id = mg.movie_id and
mg.genre_id = g.genre_id and
a.actor_id = ma.actor_id and
g.genre_name = 'Action'
GROUP BY (a.actor_name)) as max_action_movies
);


--8.	find the Names of the male and female actors who has a total revenue over 1000000000

select DISTINCT a.actor_name, g.gender from budget_revenue br, movie_actors ma, gender g, actors a
where br.movie_id = ma.movie_id and
ma.actor_id = a.actor_id and
a.gender_id = g.gender_id and
br.m_revenue > 1000000000
ORDER BY (a.actor_name);


--9.	how many Number of movies were acted by each actor.

select a.actor_id, a.actor_name, count(ma.movie_id) as number_of_movies_acted 
from actors a, movie_actors ma
where a.actor_id = ma.actor_id
GROUP BY (a.actor_id, a.actor_name)
ORDER BY (a.actor_id, a.actor_name);


--10.  find the names of the actor who had no releases in the year 2008

select a.actor_name from actors a
where a.actor_name NOT IN ( 
select a.actor_name from actors a, movie_actors ma, movies m1, movies m2
where a.actor_id = ma.actor_id and 
ma.movie_id = m1.movie_id and
m1.year = 2008 and
m1.year = m2.year
)
ORDER BY (a.actor_name)


--11. find the movies with votes > 8 and budget less than 105000000 and had revenue greater than 105000000

select m.title from movies m, budget_revenue br
where m.votes > 8 and 
br.m_budget < 105000000 and 
br.m_revenue > 105000000


--12. What is the budget spent on each genre?

select g.genre_name, SUM(br.m_budget) as budget_on_genre 
from genre g, movie_genre mg, budget_revenue br
where br.movie_id = mg.movie_id and
mg.genre_id = g.genre_id
GROUP BY (g.genre_name)
ORDER BY (g.genre_name);


--13. find the total revenue made by "James Bond" each year. (the database does not have data related to “James Bond” (among the rows we populated), so changing the actor name) 

--13. find the total revenue made by "James McAvoy" each year.
		
select m.year, SUM(br.m_revenue) as James_McAvoy_revenue
from movies m, budget_revenue br, movie_actors ma, actors a
where br.movie_id = m.movie_id and
ma.movie_id = br.movie_id and
a.actor_id = ma.actor_id and
a.actor_name = 'James McAvoy'
GROUP BY (m.year)
ORDER BY (m.year);


-- 14. What are the number of movies made per each genre?

select g.genre_name, count(mg.movie_id) as number_of_movies 
from genre g, movie_genre mg
where mg.genre_id = g.genre_id
GROUP BY (g.genre_name)
ORDER BY (g.genre_name);


--15. find which genre of movie is most popular(highest votes)

select m.title, g.genre_name, m.votes as Heighest_Votes 
from movies m, genre g, movie_genre mg 
where m.movie_id = mg.movie_id and
g.genre_id = mg.genre_id and
m.votes = (select max(m.votes) from movies m);


--16. Which year saw the most releases?

select m.year, count(m.movie_id) from movies m
GROUP BY (m.year)
HAVING count(m.movie_id) = (select max(m_count) from
			   		(select m.year, count(m.movie_id) as m_count 
                            			from movies m
			    		GROUP BY (m.year)) as m_count_value);
              
              
--17. How many Number of movies were released in each year?

select m.year, count(m.movie_id) from movies m
GROUP BY (m.year)
ORDER BY (m.year) DESC;


--18. find the genre’s released in the year 2009

select DISTINCT g.genre_name as genres_released_in_2009 
from movies m, genre g, movie_genre mg
where m.year = 2009 and
m.movie_id = mg.movie_id and
mg.genre_id = g.genre_id;


--19. list the highest budgeted movie in each year	
select m.year, MAX(br.m_budget) as max_budget 
from movies m, budget_revenue br
where m.movie_id = br.movie_id
GROUP BY (m.year)
ORDER BY (m.year) DESC;


--20. find the name of the actors who has worked in more than 2 genres

select a.actor_name, COUNT(mg.genre_id) as number_of_genres 
from actors a, movie_actors ma, movie_genre mg
where mg.movie_id = ma.movie_id and
ma.actor_id = a.actor_id
GROUP BY (a.actor_name)
HAVING COUNT(mg.genre_id) > 2
ORDER BY (a.actor_name);


