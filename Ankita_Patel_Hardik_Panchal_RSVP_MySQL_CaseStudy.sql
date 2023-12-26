USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/

-- Segment 1:

-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:
-- *********************************************************************************************************************
-- Counting rows from Movie Table
-- Used a union function to form a table of number of rows for all the tables of the schema

SELECT 
	'role_mapping' 		AS Table_Name, count(*) No_Of_Rows
FROM 
	role_mapping
UNION
SELECT 
	'movie' 			AS Table_Name, count(*) No_Of_Rows 
FROM 
	movie
UNION
SELECT 
	'genre' 			AS Table_Name, count(*) No_Of_Rows
FROM 
	genre
UNION
SELECT 
	'director_mapping' 	AS Table_Name, count(*) No_Of_Rows
FROM 
	director_mapping
UNION
SELECT 
	'names' 		   	AS Table_Name, count(*) No_Of_Rows 
FROM 
	names
UNION
SELECT 
	'Ratings' 		   	AS Table_Name, count(*) No_Of_Rows 
FROM 
	ratings;

    
/* 	Answer to 1st Question:

	Total Rows in Movie Table are = 7997
	Total Rows in Role_Mapping Table are = 15615
	Total Rows in Genre Table are = 14662
	Total Rows in Ratings Table are = 7997
	Total Rows in Director_Mapping Table are = 3867
	Total Rows in Names Table are = 25737
    
*/
-- *********************************************************************************************************************
-- Q2. Which columns in the movie table have null values?
-- Type your code below:
-- *********************************************************************************************************************
-- Here We need to find NUll values from each column of Movie table
-- So using CASE function to display NULL count of each column

SELECT
	SUM(
	CASE 
		WHEN id IS NULL THEN 1
		ELSE 0
	END) AS Id_Null_Count,
	
    SUM(
	CASE 
		WHEN title IS NULL THEN 1
		ELSE 0
	END) AS Title_Null_Count,
    
	SUM(
	CASE 
		WHEN year IS NULL THEN 1
		ELSE 0
	END) AS Year_Null_Count,
    
	SUM(
	CASE 
		WHEN date_published IS NULL THEN 1
		ELSE 0
	END) AS Date_Published_Null_Count,
    
    SUM(
	CASE 
		WHEN duration IS NULL THEN 1
		ELSE 0
	END) AS Duration_Null_Count,
    
    SUM(
	CASE 
		WHEN country IS NULL THEN 1
		ELSE 0
	END) AS Country_Null_Count,
    
    SUM(
	CASE 
		WHEN worlwide_gross_income IS NULL THEN 1
		ELSE 0
	END) AS Worlwide_Gross_Income_Null_Count,
    
    SUM(
	CASE 
		WHEN languages IS NULL THEN 1
		ELSE 0
	END) AS Languages_Null_Count,
    
    SUM(
	CASE 
		WHEN production_company IS NULL THEN 1
		ELSE 0
	END) AS Production_Company_Null_Count
    
From movie;

/* 	Answer to 2nd Question:
	
    Below Columns have NULL values in Movie Table:
		1) country 						- 20 	Null Values
        2) worlwide_gross_income 		- 3724 	Null Values
        3) languages 					- 194	Null Values
        4) production_company 			- 528 	Null Values
*/
-- *********************************************************************************************************************
-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- *********************************************************************************************************************
-- 1. Query to Find Number of movies released in each year (Part-1 of Question)
SELECT
	year 		 AS Year,
	COUNT(title) AS Number_Of_Movies  
FROM
	movie
GROUP BY
	year
ORDER BY
	year;

-- 2. Query to Find Number of movies released month wise (Part-2 of Question)    
SELECT
	MONTH(date_published) AS Month_Number,
	COUNT(title)		  AS Number_Of_Movies  
FROM
	movie
GROUP BY
	Month_Number
ORDER BY
	Month_Number;
    
/* Answer to 3rd question:
	
    Query is written in two parts:
		1) Query to know Number of movies released in each year
        2) Query to know Number of movies released month wise
        
	Additional Information:
		In year 2017, highest number of movies 3052 released
        In month 3 (March month) highest number of movies 824 released
*/
-- *********************************************************************************************************************
/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:
-- *********************************************************************************************************************

-- Query to check how many movies produced in USA and India in year 2019.
-- In country column, there are multiple countries also present so movies published in multiple countries.
-- So while writing query 'LIKE' keyword used so specified country can be counted.
SELECT
	COUNT(id) as Number_Of_Movies
FROM
	movie
WHERE 
	(country LIKE '%USA%' OR country LIKE '%India%')
		AND
    year = 2019;

/* Answer to 4th Question:

	Total 1059 movies released in USA or India in the year 2019.

*/

-- *********************************************************************************************************************
/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:
-- *********************************************************************************************************************

-- Here question is to find unique genre category from dataset so DISTINCT keyword should be used.

SELECT
	DISTINCT genre AS Genre_Type
FROM
	genre;

/* Answer to 5th Question:
	
    - With above query we get to know different types of Genre present in Genre table
    - With Below query we know that there are 13 different types of Genre present in table.
			SELECT
				COUNT(DISTINCT genre) AS Genre_Type
			FROM
				genre;
*/
-- *********************************************************************************************************************	

/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:
-- *********************************************************************************************************************
-- Question is to check which genre movie are produced highest overall
-- Here we need to join Movie and Genre tables to get required info, so will use Inner Join
-- In a details of question there is line to see which genre movies produced highest in last year (2019)

SELECT
	genre 		AS Genre,
    COUNT(m.id) AS Number_Of_Movies
FROM
	genre 		AS g
	INNER JOIN 
	movie 		AS m
    ON g.movie_id = m.id
GROUP BY 
	genre
ORDER BY
	Number_Of_Movies desc
LIMIT 1;

/* Answer to 6th Question:

	- Drama genre movies are produced highest(4285) overall.
	- Additionally Drama genre movies are produced highest(1078) in year 2019.
*/

-- *********************************************************************************************************************
/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:
-- *********************************************************************************************************************
-- Here we need to use Common Table Expression to deal with this problem.
-- First we need to filter movies with only 1 genre and then counting total movies which represents only 1 Genre

WITH Single_Genre_Movies	AS
	(
		SELECT 
			movie_id 		AS Movie_id,
			COUNT(genre) 	AS Num_Genre
		FROM 
			Genre
		GROUP BY
			movie_id
		HAVING
			Num_Genre = 1
	)
SELECT
	COUNT(movie_id) AS Total_Movies_Single_Genre
FROM 
	Single_Genre_Movies;
            
/* Answer to 7th Question:
	
	There are total 3289 movies belongs to only 1 Genre.
    
*/

-- *********************************************************************************************************************
/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)

/* Output format:
+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- *********************************************************************************************************************
-- Here we need to join Genre and Movie table and calculate average duration by Genre type.
-- Here we are rounding off the average duration with 2 decimal points.

SELECT 
	genre					AS Genre,
    ROUND(AVG(duration),2)	AS Avg_Duration
FROM
	genre 					AS g
	LEFT JOIN
	movie 					AS m
    ON g.movie_id = m.id
GROUP BY genre
ORDER BY Avg_Duration DESC;

/* Answer to 8th Question:

	- with above query it fiters Average duration of movies for each Genre type.
	- By this Action movies have highest average duration 112.88
    - And Horror movies have lowest average duration 92.72
	- Drama movies have average duration of 106.77
    
*/
-- *********************************************************************************************************************

/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)

/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- *********************************************************************************************************************
-- To deal with this question we need to use Common Table expression to filter movies count genre wise rank
-- Then with CTE, we can see movie count and rank for Thriller genre movies

WITH Movie_Count_per_Genre 					AS
	(
		SELECT
			genre 							AS Genre,
			COUNT(m.id) 					AS Count_Movies,
			RANK() OVER 
				(ORDER BY COUNT(m.id) DESC) AS Rank_Count_Movies
		FROM
			genre 							AS g
			INNER JOIN 
			movie 							AS m
			ON g.movie_id = m.id
		GROUP BY 
			genre
	)
SELECT
	*
FROM
	Movie_Count_per_Genre
WHERE Genre = 'Thriller';
        
/* Answer to 9th Question:
	 
     - Genre Thriller is ranked at 3 in terms of movies produced overall
*/
-- *********************************************************************************************************************

/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/

-- Segment 2:

-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:
-- *********************************************************************************************************************
-- Here we can use directly min(), max() functions to get this information for each column.
SELECT
	MIN(avg_rating) 	AS Min_Avg_Rating,
    MAX(avg_rating) 	AS Max_Avg_Rating,
    MIN(total_votes) 	AS Min_Total_Votes,
    MAX(total_votes) 	AS Max_Total_Votes,
    MIN(median_rating) 	AS Min_Median_Rating,
    MAX(median_rating) 	AS Max_Median_Rating
FROM
	ratings;

/* Answer to 10th Question:
	Min_Avg_Rating 		= 1.0
    Max_Avg_Rating 		= 10.0
	Min_Total_Votes 	= 100
    Max_Total_Votes 	= 725138
    Min_Median_Rating 	= 1
    Max_Median_Rating 	= 10
	
    All values are in correct range for each column.

*/
-- *********************************************************************************************************************

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too
-- *********************************************************************************************************************

SELECT
	*
FROM
	(

		SELECT
			m.title 						AS Title,
			r.avg_rating 					AS Avg_Rating,
			RANK() OVER 
				(ORDER BY Avg_Rating DESC) 	AS Movie_Rank
		FROM
			ratings 						AS r
			INNER JOIN
			movie 							AS m
			ON r.movie_id = m.id
	) 
											AS A
WHERE 
	Movie_Rank <= 10;
    
/* Answer to 11th Question:

	There are 14 movies which have top 10 ranked.
*/
-- *********************************************************************************************************************

/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have
-- *********************************************************************************************************************

SELECT
	median_rating 	AS Median_Rating,
    COUNT(movie_id) AS Movie_Count
FROM
	ratings
GROUP BY
	Median_Rating
ORDER BY 
	Median_Rating;
    
/* Answer to 12th Question:
	
     - With above query movie count displayed for each Median rating from 1 to 10
	 - Median rating 7 has highest number of movies 2257 and 1 has lowest number of movies 94.

*/
-- *********************************************************************************************************************

/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:
-- *********************************************************************************************************************

WITH Top_Prod_Company AS
	(
	SELECT
		production_company 					 AS Production_Company,
		COUNT(m.id) 						 AS Movie_Count,
		RANK() 
			OVER (ORDER BY COUNT(m.id) DESC) AS Prod_Company_RANK
	FROM
		movie 								 AS m
		INNER JOIN
		ratings 							 AS r
		ON r.movie_id = m.id
	WHERE r.avg_rating > 8
		AND production_company 				 IS NOT NULL
	GROUP BY 
		Production_Company
	)
SELECT *
FROM
	Top_Prod_Company
WHERE Prod_Company_RANK = 1;

/* Answer to 13th Question:

	- Production house which has produced most movies which got avg_rating greater than 8 are below
		1) Dream Warrior Pictures - 3 Movies
        2) National Theatre Live - 3 Movies
        
*/
-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both
-- ********************************************************************************************************************* 
 
-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- *********************************************************************************************************************  
-- To solve this we need to join 3 different tables - movie, genre and ratings
-- And need to use 3 condition for year 2017, month March and total Votes more than 1000 and produced in USA

SELECT
	genre 		AS Genre,
    COUNT(m.id) AS Movie_Count
FROM
	genre 		AS g
    INNER JOIN
    movie 		AS m
    ON g.movie_id = m.id
    INNER JOIN
    ratings 	AS r
    ON m.id = r.movie_id
WHERE
	year = 2017
		AND
    country LIKE '%USA%'
		AND
    total_votes > 1000
		AND
    MONTH(date_published) = 3
GROUP BY
	Genre
ORDER BY
	Movie_Count DESC;
    
/* Answer to 14th question:

	- There are 24 Drama genre movies from USA which released in March 2017
	  and has more than 1000 total votes
	- There is 1 Family genre movies released in USA which released in March 2017
	  and has more than 1000 total votes
      
*/

-- ********************************************************************************************************************* 

-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- ********************************************************************************************************************* 
-- Here we need to find movies with 'The' & average rating above 8.
-- We used Genre, Movie and Ratings table combine for above 2 conditions

SELECT
	title 		AS Title,
	avg_rating 	AS Avg_Rating,
    genre		AS Genre
FROM
	genre 		AS g
    INNER JOIN
    movie 		AS m
    ON g.movie_id = m.id
    INNER JOIN
    ratings 	AS r
    ON m.id = r.movie_id
WHERE
	title LIKE 'The%'
		  AND
	avg_rating > 8
GROUP BY
	Title
ORDER BY
	Avg_Rating DESC;

/* Answer to 15th question:

	- There are 8 movies which starts with word "The" and have Avg_Rating more than 8
	- The "The Brighton Miracle" has highest rating 9.5 and "The King and I" has 8.2 Avg_Rating
      
*/

-- ********************************************************************************************************************* 

-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:
-- ********************************************************************************************************************* 

SELECT
	median_rating 	AS Median_Rating,
    COUNT(m.id)		AS Movie_Count
FROM
    movie 			AS m
    INNER JOIN
    ratings 		AS r
    ON m.id = r.movie_id
WHERE
	median_rating = 8
		AND
	date_published BETWEEN '2018-04-01' AND '2019-04-01'
GROUP BY
	Median_Rating;

/* Answer to 16th question:

	- There are 361 movies with Median rating 8 which are released between 1 April 2018 and 1 April 2019
      
*/

-- ********************************************************************************************************************* 

-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:
-- ********************************************************************************************************************* 
-- Here we are filtering German language and Italian seperately and using UNION to combine to check total votes

SELECT 
	languages,
	Sum(total_votes) 		AS votes
FROM   
	movie 					AS m
    INNER JOIN ratings 		AS r
    ON r.movie_id = m.id
WHERE  
	languages LIKE '%Italian%'
UNION
SELECT 
	languages,
	Sum(total_votes) 		AS votes
FROM   
	movie 					AS m
    INNER JOIN ratings 		AS r
    ON r.movie_id = m.id
WHERE
	languages LIKE '%German%'
ORDER BY 
	votes DESC;
    
/* Answer to 17th question:

    - German language movies get more votes than Italian language movies.
    
	- There are 4421525 total_votes for German Language movies
    - There are 2559540 total_votes for Italian language movis

*/

-- ********************************************************************************************************************* 

-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/

-- Segment 3:

-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:
-- ********************************************************************************************************************* 
-- Here we will follow provided sample output format and to do that we can use CASE function to get output.

SELECT

    SUM(
	CASE 
		WHEN name IS NULL THEN 1
		ELSE 0
	END) 	AS Name_Null_Count,
        
	SUM(
	CASE 
		WHEN height IS NULL THEN 1
		ELSE 0
	END) 	AS Height_Null_Count,
    
    SUM(
	CASE 
		WHEN date_of_birth IS NULL THEN 1
		ELSE 0
	END) 	AS Date_of_Birth_Null_Count,
    
    SUM(
	CASE 
		WHEN known_for_movies IS NULL THEN 1
		ELSE 0
	END) 	AS Known_For_Movies_Null_Count
    
From 
	names;

/* Answer to 18th question:

    - Below are the columns for which Null values are present
		- Names 			= 0 Nulls
        - Height 			= 17335 Nulls
        - Date_of_birth 	= 13431 Nulls
        - Known_for_movies 	= 15226 Nulls

*/

-- ********************************************************************************************************************* 

/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- ********************************************************************************************************************* 

-- Here we need to use CTE, first need to find top 3 genre by combining movie, genre and ratings tables
-- Then we need to write different query for combining director_mapping, genre, names, ratings and earlier topr genre tables
-- And the find directors name with movie count where ratings is higher than 8

WITH Top_3_Genre 						AS
	(
		
		SELECT
			genre 						AS Genre,
			COUNT(m.id) 				AS Movie_Count
		FROM
			movie 						AS m
			INNER JOIN
			genre 						AS g
			ON m.id = g.movie_id
			INNER JOIN
			ratings 					AS r
			ON m.id = r.movie_id
		WHERE
			avg_rating > 8
		GROUP BY
			Genre
		ORDER BY
			Movie_Count DESC
		LIMIT 3
	)
SELECT
	n.name 								AS Name,
    COUNT(d.movie_id) 					AS Movie_Count
FROM
	director_mapping 					AS d
    INNER JOIN
    genre 								AS g
    USING (movie_id)
    INNER JOIN
    names 								AS n
    ON n.id	= d.name_id
    INNER JOIN
    ratings 							AS r
    ON r.movie_id = g.movie_id
    INNER JOIN
    Top_3_Genre 						AS t
    ON t.Genre = g.genre
WHERE
	avg_rating > 8
GROUP BY
	name
ORDER BY 
    Movie_Count DESC
LIMIT 3;
 
/* Answer to 19th question:

    - In above question with the help of first half of query we filtered top 3 genre with movie count and rating above 8
    - These genres are Drama, Action and Comedy
	- For these 3 genres 3 directors whose movies have higher than 8 ratings and these directors are
		- James Mangold, Anthony Russo, Soubin Shahir. Joe Russo has also same movie count as 3 with higher than 8 rating

*/

-- ********************************************************************************************************************* 

/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- ********************************************************************************************************************* 
-- Here to find answer we need to join movie, role_maping, name and ratings table to get required info
-- Then need to group by actor_name where median rating is 8 and above AND catefory actor

SELECT
	n.name 			AS Actor_Name,
    COUNT(m.id) 	AS Movie_Count
FROM
	role_mapping 	AS ro
    INNER JOIN
    movie 			AS m
    ON ro.movie_id = m.id
    INNER JOIN
    names 			AS n
    ON ro.name_id = n.id
    INNER JOIN
    ratings 		AS r
    ON r.movie_id = m.id
WHERE
	median_rating >=8
		AND
	category = 'actor'
GROUP BY
	Actor_Name
ORDER BY
	Movie_Count DESC
LIMIT 2;

/* Answer to 20th question:

    - Top 2 actors with median rating 8 and above with movie count are below
		1) Mammootty
        2) Mohanlal

*/

-- ********************************************************************************************************************* 

/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:
-- ********************************************************************************************************************* 
-- Here we need to find top 3 production house with received total votes for their movies 
-- So need to combine movie and ratings column would help to find it, 

SELECT
	production_company AS Production_Company,
    SUM(total_votes) AS Vote_Count,
    RANK() OVER
		(ORDER BY SUM(total_votes) DESC) AS Prod_Comp_Rank
FROM
	movie AS m
    INNER JOIN
    ratings AS r
    ON m.id = r.movie_id
GROUP BY
	Production_Company
LIMIT 3;

/* Answer to 21th question:

    - Top 3 production house accordign to total votes for their movies are
		1) Marvel Studios
        2) Twentieth Century Fox
        3) Warner Bros.

*/

-- ********************************************************************************************************************* 

/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
-- ********************************************************************************************************************* 
-- Here we need to display Actors who worked in Indian movies with their weighted average based on votes.

WITH Actor_Details 													AS
	(
		SELECT
			n.name 													AS Actor_Name,
			SUM(total_votes) 										AS Total_Vote,
			COUNT(m.id) 											AS Movie_Count,
			ROUND(SUM(avg_rating * total_votes)/SUM(total_votes),2) AS Actor_Avg_Rating
		FROM
			movie 													AS m
			INNER JOIN
			ratings 												AS r
			ON m.id = r.movie_id
			INNER JOIN
			role_mapping 											AS ro
			ON m.id = ro.movie_id
			INNER JOIN
			names 													AS n
			ON n.id = ro.name_id
		WHERE
			category = 'Actor'
				AND
			country LIKE '%India%'
		GROUP BY
			Actor_Name
		HAVING
			Movie_Count >= 5
	)
SELECT *,
    RANK() OVER
		(ORDER BY Actor_Avg_Rating DESC) 							AS Actors_Rank
FROM
	Actor_Details;

/* Answer to 22th question:

    - Vijay Sethupathi tops the list in weighted average based on votes and did 5 or more movies

*/

-- ********************************************************************************************************************* 

-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
-- ********************************************************************************************************************* 

WITH Actress_Details 												AS
	(
		SELECT
			n.name 													AS Actress_Name,
			SUM(total_votes) 										AS Total_Vote,
			COUNT(m.id) 											AS Movie_Count,
			ROUND(SUM(avg_rating * total_votes)/SUM(total_votes),2) AS Actress_Avg_Rating
		FROM
			movie 													AS m
			INNER JOIN
			ratings 												AS r
			ON m.id = r.movie_id
			INNER JOIN
			role_mapping 											AS ro
			ON m.id = ro.movie_id
			INNER JOIN
			names 													AS n
			ON n.id = ro.name_id
		WHERE
			category = 'actress'
				AND
			country LIKE '%India%'
				AND
			languages LIKE '%Hindi%'
		GROUP BY
			Actress_Name
		HAVING
			Movie_Count >= 3
	)
SELECT
	*,
    RANK() OVER
		(ORDER BY Actress_Avg_Rating DESC) 							AS Actors_Rank
FROM
	Actress_Details
LIMIT 5;

/* Answer to 23th question:

    - Top 5 actress in terms of weighted average rating who worked in Hindi movies in India are below.
			1) Taapsee Pannu
            2) Kriti Sanon
            3) Divya Dutta
            4) Shraddha Kapoor
            5) Kriti Kharbanda
	- Taapsee Pannu tops the list with 7.74 Actress_Avg_Rating.

*/

-- ********************************************************************************************************************* 

/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:
-- ********************************************************************************************************************* 

SELECT
	DISTINCT m.title 											AS Title,
    r.avg_rating 												AS Avg_Rating,
	CASE 
		WHEN avg_rating > 8 			THEN 'Superhit'
		WHEN avg_rating BETWEEN 7 AND 8 THEN 'HIT'
		WHEN avg_rating BETWEEN 5 AND 7 THEN 'One-Time-Watch'
		ELSE 'Flop'
	END 														AS Rating_Category
FROM
	movie 														AS m
    INNER JOIN
    genre 														AS g
    ON m.id = g.movie_id
    INNER JOIN
    ratings 													AS r
    ON m.id = r.movie_id
WHERE
	genre LIKE '%Thriller%'
ORDER BY
	Avg_Rating DESC;
    
/* Answer to 24th question:

    - Above query displayed all Thriller movies in category according to their Avg_Ratings

*/

-- ********************************************************************************************************************* 

/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:
-- ********************************************************************************************************************* 
-- Here we are using Running Total Duration and Moving Average duration for each Genre

SELECT
	genre 										  AS Genre,
    ROUND(AVG(duration),2) 						  AS Avg_Duration,
    SUM(ROUND(AVG(duration),2)) OVER 
		(ORDER BY genre ROWS UNBOUNDED PRECEDING) AS Running_Total_Duration,
    AVG(ROUND(AVG(duration),2)) OVER 
		(ORDER BY genre ROWS UNBOUNDED PRECEDING) AS Moving_Avg_Duration
FROM
	genre 										  AS g
    INNER JOIN
    movie 										  AS m
    ON m.id = g.movie_id
GROUP BY
	Genre
ORDER BY
	Genre;

/* Answer to 25th question:

    - Above query shows running total duration and moving average duration for each genre.
    
*/

-- ********************************************************************************************************************* 

-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies
-- ********************************************************************************************************************* 
-- First need to find top 3 genres as per most number of movies
-- Then need to rank the movies as per gross income year wise
-- In worldwide_gross_income column need to take care of null values and strings like "INR" and "$"
-- Replaced such strings from that columns and used 0 for null values and used in quesries
-- We need to use 2 CTE to derive this information, 1st for top genres and 2nd for top movies in terms of gross income
-- used top 3 genres details to filter our desired result

WITH Top_3_Genre 							AS
	(
		SELECT
			genre 							AS Genre,
			COUNT(m.id) 					AS Movie_Count,
			RANK() OVER 
				(ORDER BY COUNT(m.id) DESC) AS Rank_Genre
		FROM
			movie 							AS m
			INNER JOIN
			genre 							AS g
			ON m.id = g.movie_id
        GROUP BY
			Genre
		LIMIT 3
	),
Movie_Summary 								AS
	(
		SELECT
			genre AS Genre,
            year AS Year,
            title AS Movie_Name,
            CAST(REPLACE(REPLACE(IFNULL(worlwide_gross_income,0),'INR',''),'$','') AS DECIMAL(10))
											AS	Worldwide_Gross_Income,
			DENSE_RANK() OVER (
				PARTITION BY year ORDER BY 
					CAST(REPLACE(REPLACE(IFNULL(worlwide_gross_income,0),'INR',''),'$','') AS DECIMAL(10)) DESC
							  )				AS Movie_Rank
		FROM
			movie 							AS m
            INNER JOIN
            genre 							AS g
            ON m.id = g.movie_id
		WHERE
			genre IN (
						SELECT Genre
                        FROM Top_3_Genre
					 )
		GROUP BY
			Movie_Name
	)
SELECT *
FROM
	Movie_Summary
WHERE
	Movie_Rank <= 5
ORDER BY
	Year;

/* Answer to 26th question:

    - Above query gives result of top 5 gross movies in each year in terms of Gross income for top 3 genres
    
*/

-- ********************************************************************************************************************* 

-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:
-- ********************************************************************************************************************* 
-- Here we need to join ratings and movie table to get production company 
-- Need to keep in mind NULL values of Production company so filter out where value is NOT NULL
-- And using POSITION(',' IN languages) > 0 command as suggested which is useful here to filter multilingual movie

SELECT
	production_company 						AS Prod_Company,
    COUNT(m.id) 							AS Movie_Count,
    RANK() OVER (ORDER BY COUNT(m.id) DESC) AS Movie_Rank
FROM
	movie 									AS m
    INNER JOIN
    ratings 								AS r
    ON m.id = r.movie_id
WHERE
	median_rating >= 8
		AND
	production_company IS NOT NULL
		AND
	POSITION(',' IN languages) > 0
GROUP BY
	Prod_Company
LIMIT 2;

/* Answer to 27th question:

    - Above query gives result of top 2 production comapnies which produced more movies with more than 8 avg ratings
	  for multilingual movies
			1) Star Cinema
            2) Twentieth Century Fox
    
*/

-- ********************************************************************************************************************* 

-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language

-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
-- ********************************************************************************************************************* 
-- Here we need to join movie, genre, ratings, role_mapping and names table
-- Need to filter out actress name where avg_rating is greater than 8 in drama movies 
-- Provided rank based on number of movies as per above criteria

SELECT
	n.name 									AS Actress_Name,
    SUM(total_votes) 						AS Total_Votes,
    COUNT(m.id) 							AS Movie_Count,
    ROUND(AVG(avg_rating),2) 				AS Actress_Avg_Rating,
    RANK() OVER (ORDER BY COUNT(m.id) DESC) AS Rank_Actress
FROM
	movie 									AS m
    INNER JOIN
    genre 									AS g
    ON m.id = g.movie_id
    INNER JOIN
    ratings 								AS r
    ON m.id = r.movie_id
    INNER JOIN
    role_mapping 							AS ro
    ON m.id = ro.movie_id
    INNER JOIN
    names 									AS n
    ON ro.name_id = n.id
WHERE
	avg_rating > 8
		AND
	genre = 'Drama'
		AND
	category = 'actress'
GROUP BY
	Actress_Name
LIMIT 3;

/* Answer to 28th question:

    - Above query gives result of top 3 actress as per number of movies in drama genre where avg_ratings is greater than 8
			1) Parvathy Thiruvothu
            2) Susan Brown
            3) Amanda Lawrence
    
*/

-- ********************************************************************************************************************* 

/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:
-- Here we need to create 1 more column for date difference of their movies release for each director
-- So here created date difference with LEAD command and created 1 column along with each required column after
-- combining movie, role_mapping, ratings, name, director_mapping tables
-- The using that new created table manipulation performed based on each director and we arrived with result.

WITH Date_Difference_Summary 		AS
	(
		SELECT
			d.name_id,
            n.name,
			d.movie_id,
            duration,
            r.avg_rating,
            total_votes,
            m.date_published,
            DATEDIFF
			(Lead(date_published,1) OVER(partition BY d.name_id ORDER BY date_published, movie_id) , date_published)
									AS Date_Difference
		FROM
			movie 					AS m
			INNER JOIN
			director_mapping 		AS d
			ON m.id = d.movie_id
			INNER JOIN
			names 					AS n
			ON d.name_id = n.id
            INNER JOIN
            ratings 				AS r
            ON r.movie_id = m.id
	)
SELECT
	name_id 						AS Director_Id,
    name 							AS Director_Name,
    COUNT(movie_id) 				AS Number_Of_Movies,
    ROUND(AVG(Date_Difference),2) 	AS Avg_Inter_Movie_Days,
    ROUND(AVG(avg_rating),2) 		AS Avg_Rating,
    SUM(total_Votes) 				AS Total_Votes,
    MIN(avg_rating) 				AS Min_Avg_Rating,
    MAX(avg_rating) 				AS Max_Avg_Rating,
    SUM(duration) 					AS Total_Duration
FROM
	Date_Difference_Summary
GROUP BY
	Director_Id
ORDER BY
	Number_Of_Movies DESC
LIMIT 9;

/* Answer to 29th question:

    - Above query gives result of top 9 directors for their number of movies and other details for the same.
			1) Andrew Jones
            2) A.L. Vijay
            3) Sion Sono
            4) Chris Stokes
            5) Sam Liu
            6) Steven Soderbergh
            7) Jesse V. Johnson
            8) Justin Price
            9) Özgür Bakar
            
*/

-- ********************************************************************************************************************* 

