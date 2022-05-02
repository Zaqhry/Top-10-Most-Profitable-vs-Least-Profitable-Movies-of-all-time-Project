



--Movies Project 

SELECT * 
FROM Movies 

-------------------------------------------------------------------------

CREATE VIEW B AS
(
SELECT TOP 10 Name,
	      Year,
	      Rating,
	      Genre,
	      Budget,
	      Gross,
	      (Gross - Budget) Profit 
FROM Movies 
ORDER BY Profit DESC
)



CREATE VIEW W AS
(
SELECT TOP 10 Name,
	      Year,
	      Rating,
	      Genre,
	      Budget,
	      Gross,
	      (Gross - Budget) Profit 
FROM Movies 
WHERE Gross < Budget
ORDER BY Profit 
)



--Top 10 Most Profitable vs Least Profitable Movies Comparison 

SELECT * 
FROM B 
UNION 
SELECT * 
FROM W



--Score,Budget,Gross,Profit,Runtime Per Movie vs Average Across All Movies 

SELECT Name,
	   Score,
	   (SELECT ROUND(AVG(Score),2) FROM Movies) AvgScore,
	   Budget,
	   (SELECT ROUND(AVG(Budget),2) FROM Movies) AvgBudget,
	   Gross,
	   (SELECT ROUND(AVG(Gross),2) FROM Movies) AvgGross,
	   (Gross - Budget) Profit,
	   (SELECT ROUND(AVG(Gross - Budget),2) FROM Movies) AvgProfit,
	   Runtime,
	   (SELECT ROUND(AVG(Runtime),2) FROM Movies) AvgRuntime
FROM Movies 

---------------------------------------------------------------------------------------------------

--Score,Genre,Rating,Budget,Gross,Profit,Runtime For Top 10 Best Movies vs Average Across All Movies 

SELECT TOP 10 Year,
	      Name,
	      director,
	      writer,
	      Genre,
	      Score,
	      Rating,
	      (SELECT ROUND(AVG(Score),2) FROM Movies) AvgScore,
	      Budget,
	      (SELECT ROUND(AVG(Budget),2) FROM Movies) AvgBudget,
	      Gross,
	      (SELECT ROUND(AVG(Gross),2) FROM Movies) AvgGross,
	      (Gross - Budget) Profit,
	      (SELECT ROUND(AVG(Gross - Budget),2) FROM Movies) AvgProfit,
	      Runtime,
	      (SELECT ROUND(AVG(Runtime),2) FROM Movies) AvgRuntime
FROM Movies 
ORDER BY Profit DESC



--Score,Genre,Rating,Budget,Gross,Profit,Runtime For Top 10 Worst Movies vs Average Across All Movies 

SELECT TOP 10 Year,
	      Name,
              director,
	      writer,
	      Genre,
              Score,
	      Rating,
              (SELECT ROUND(AVG(Score),2) FROM Movies) AvgScore,
              Budget,
              (SELECT ROUND(AVG(Budget),2) FROM Movies) AvgBudget,
              Gross,
              (SELECT ROUND(AVG(Gross),2) FROM Movies) AvgGross,
              (Gross - Budget) Profit,
              (SELECT ROUND(AVG(Gross - Budget),2) FROM Movies) AvgProfit,
              Runtime,
              (SELECT ROUND(AVG(Runtime),2) FROM Movies) AvgRuntime
FROM Movies 
WHERE Gross < Budget
ORDER BY Profit 



---------------------------------------------------------------------------------------------------

--Movies that made a negative profit 

SELECT Name,
       Budget,
       Gross,
       (Gross - Budget) Profit 
FROM Movies 
WHERE Gross < Budget
ORDER BY Profit 



--Profit made for each movie by Writer & Director 

SELECT name,
       writer,
       director,
       SUM(Gross - Budget) Profit 
FROM Movies 
	GROUP BY name,
	         writer,
	         director
	ORDER BY Profit DESC



--How much profit Writers have made with all movies combined 

SELECT writer,
       SUM(Gross - Budget) Profit 
FROM Movies 
	GROUP BY writer
	ORDER BY Profit DESC



--How much profit Directors have made with all movies combined

SELECT director,
       SUM(Gross - Budget) Profit 
FROM Movies 
	GROUP BY director
	ORDER BY Profit DESC



--Number of movies for each writer 

SELECT Writer,
       COUNT(*) Movies
FROM Movies
	GROUP BY Writer
	ORDER BY 2 DESC



--Number of movies for each director 

SELECT Director,
       COUNT(*) Movies
FROM Movies
	GROUP BY Director
	ORDER BY 2 DESC



--Budget for each movie 

SELECT Name,
       Max(Budget) Budget
FROM Movies
WHERE Budget IS NOT NULL
	GROUP BY Name
	ORDER BY Budget DESC



--Budget for each genre

SELECT Genre,
       Max(Budget) Budget
FROM Movies
WHERE Budget IS NOT NULL
	GROUP BY Genre
	ORDER BY Budget DESC



--Profit for each movie 

SELECT Name,  
       (Gross - Budget) Profit
FROM Movies
	ORDER BY Profit DESC



--# of movies made by each company 

SELECT Company,
       COUNT(Name) TotalMovies 
FROM Movies 
	GROUP BY Company
	ORDER BY TotalMovies DESC



--# of movies made per genre 

SELECT Genre,
       COUNT(Name) TotalMovies 
FROM Movies 
	GROUP BY Genre
	ORDER BY TotalMovies DESC



--# of movies made per rating

SELECT Rating, 
       COUNT(Name) TotalMovies 
FROM Movies 
WHERE Rating IS NOT NULL
	GROUP BY Rating
	ORDER BY TotalMovies DESC



--Profit made by each company 
	
SELECT Company,
       COUNT(Name) TotalMovies,SUM(Gross - Budget) TotalProfit 
FROM Movies 
	GROUP BY Company 
	ORDER BY TotalMovies DESC



--Profit Ratio for movies 

SELECT Name, 
       Budget,
       Gross,
       ROUND(MAX(Gross - Budget) / MIN(Budget),2) ProfitRatio 
FROM Movies 
	GROUP BY Name, 
	         Budget,
		 Gross
	ORDER BY ProfitRatio DESC
	


--TOP 5 Movies with lowest budget but highest profit return 

SELECT TOP 5 Name, 
	     Budget,
	     Gross,
	     ROUND(MAX(Gross - Budget) / MIN(Budget),2) ProfitRatio 
FROM Movies 
	GROUP BY Name, 
	         Budget,
		 Gross
	ORDER BY ProfitRatio DESC
	
	

--Number of movies produced by countries 

SELECT Country,
       COUNT(Name) TotalMovies 
FROM Movies 
	GROUP BY Country
	ORDER BY TotalMovies DESC



--Year with the most movies produced

SELECT Year,
       COUNT(Name) TotalMovies
FROM Movies 
	GROUP BY Year 
	ORDER BY TotalMovies DESC



--Rating that most movies are labeled under 

SELECT Rating, 
       COUNT(Rating) TotalRating
FROM Movies 
WHERE Rating IS NOT NULL
	GROUP BY Rating 
	ORDER BY TotalRating DESC



--Runtime For Movies vs Average Runtime For All Movies 

SELECT Name,
       Runtime,
       (SELECT ROUND(AVG(Runtime),2) FROM Movies) Avg_Runtime_For_All_Movies
FROM Movies
	GROUP BY Name,
	         Runtime
	ORDER BY Runtime DESC



--Total & Avg Profit Per Genre (Most profitable genre) 

SELECT Genre,
       SUM(Gross - Budget) TotalProfit,
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
	GROUP BY Genre
	ORDER BY TotalProfit DESC



--Total & Avg Profit Per Rating (Most profitable Rating) 


SELECT Rating, 
       SUM(Gross - Budget) TotalProfit,
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
WHERE Rating IS NOT NULL
	GROUP BY Rating
	ORDER BY TotalProfit DESC



--Total & Avg Profit Per Year (Most profitable Year) 

SELECT Year,
       SUM(Gross - Budget) TotalProfit,
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
	GROUP BY Year
	ORDER BY TotalProfit DESC



--Total & Avg Profit Per Country (Most profitable Country) 

SELECT Country,
       SUM(Gross - Budget) TotalProfit,
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
	GROUP BY Country
	ORDER BY TotalProfit DESC



--Total & Avg Profit Per Movie (Most profitable Movie) 

SELECT Name,
       SUM(Gross - Budget) TotalProfit,
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
	GROUP BY Name
	ORDER BY TotalProfit DESC



--Total & Avg Profit Per Scores (Most Profitable Scores) 

SELECT Score,
       SUM(Gross - Budget) TotalProfit,
       ROUND(AVG(Gross - Budget),2) AvgProfit 
FROM Movies 
	GROUP BY Score
	ORDER BY TotalProfit DESC
	
	
	
