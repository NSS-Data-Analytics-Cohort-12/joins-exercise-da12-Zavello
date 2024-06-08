-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

-- Select specs.film_title, specs.release_year, revenue.worldwide_gross
-- From specs
-- Inner Join revenue
-- 	On specs.movie_id = revenue.movie_id
-- Order By revenue.worldwide_gross;

-- Semi-Tough released in 1977 grossed at $37,187,139

-- 2. What year has the highest average imdb rating?

-- Select specs.release_year, Round(Avg(rating.imdb_rating),2) As avg_imdb_rating
-- From specs
-- Inner Join rating
-- 	On specs.movie_id = rating.movie_id
-- Group By specs.release_year
-- Order By avg_imdb_rating DESC;

-- The year 1991 has the highest average imdb rating

-- 3. What is the highest grossing G-rated movie? Which company distributed it?

-- Select distributors.company_name, specs.film_title, revenue.worldwide_gross
-- From distributors
-- Inner Join specs 
-- 	On distributor_id = specs.domestic_distributor_id
-- Inner Join revenue
-- 	On specs.movie_id = revenue.movie_id
-- Where specs.mpaa_rating = 'G'
-- Order By revenue.worldwide_gross DESC;

-- Toy Story 4 distributed by Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

-- Select distributors.company_name, count(specs.film_title)
-- From distributors
-- Left Join specs
-- 	On distributors.distributor_id = specs.domestic_distributor_id
-- Group By distributors.company_name;

-- 5. Write a query that returns the five distributors with the highest average movie budget.

-- Select distributors.company_name, Round(Avg(film_budget),2) As avg_budget
-- From distributors
-- Inner Join specs
-- 	On distributors.distributor_id = specs.domestic_distributor_id
-- Inner Join revenue
-- 	On specs.movie_id = revenue.movie_id
-- Group By distributors.company_name
-- Order By avg_budget DESC
-- Limit (5);

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

-- Select distributors.company_name, count(specs.film_title) As num_of_movies
-- From distributors
-- Inner Join specs
-- 	On distributors.distributor_id = specs.domestic_distributor_id
-- Where headquarters Not Like '%CA'
-- Group By distributors.company_name;

-- 2 movies are distributed by companies not in California

-- Select distributors.company_name, specs.film_title, rating.imdb_rating
-- From distributors
-- Inner Join specs
-- 	On distributors.distributor_id = specs.domestic_distributor_id
-- Inner Join rating
-- 	On specs.movie_id = rating.movie_id
-- Where headquarters Not Like '%CA'
-- Order By rating.imdb_rating DESC;

-- Dirty Dancing has the highest IMDB ratings of movies distributed by a company outside of California.
	
-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

-- Select specs.length_in_film, Count(specs.film_title) As movies, Avg(rating.imdb_rating) As avg_rating, 
-- From specs
-- Left Join rating
-- 	On specs.movie_id = rating.movie_id
-- Group By specs.length_in_film > 120
-- Order By avg_rating;

-- Union All
	
-- Select Count(specs.film_title) As movies, Avg(rating.imdb_rating) As avg_rating
-- From specs
-- Left Join rating
-- 	On specs.movie_id = rating.movie_id
-- Where specs.length_in_min < 120
-- Order By avg_rating;

-- Movies over 2 hours have a higher rating

Select 
		Count(specs.film_title) As movies, 
		Avg(rating.imdb_rating) As avg_rating
From specs
Left Join rating
	On specs.movie_id = rating.movie_id
Where specs.length_in_min > 120

	
Union All
	
Select 
		Count(specs.film_title) As movies, 
	    Avg(rating.imdb_rating) As avg_rating
From specs
Left Join rating
	On specs.movie_id = rating.movie_id
Where specs.length_in_min < 120
Order By avg_rating;
