CREATE DATABASE VideoGames;

USE VideoGames;

SELECT * FROM Games;

/* Video games analysis using Microsoft SQL server
	1. What are the top 5 best-selling games globally?
	2. How do the global sales compare across genres?
	3. Which platform has the highest sales in North America?
	4. What are the top 3 genres in Europe based on sales?
	5. Are there any noticeable differences in genre popularity between Japan and other regions?
	6. Which platform has shown the highest average global sales?
	7. How does the total sales for older platforms (e.g., PS2, NES) compare to newer ones (e.g., PS4, XOne)?
	8. What is the most popular genre in terms of global sales?
	9. Are there any genres that are consistently underperforming in all regions?
	10. How have global sales trended over the years?
	11. Are there any notable years with a significant increase or decrease in sales?
*/

--- Solution 
-- Question 1
SELECT TOP 5 [Name], ROUND(SUM(Global_Sales),1) AS 'Total Sales' FROM Games
GROUP BY [Name]
ORDER BY 'Total Sales' DESC;

-- Question 2
SELECT Genre, ROUND(SUM(Global_Sales),1) AS 'Total Sales' FROM Games
GROUP BY Genre
ORDER BY 'Total Sales' DESC;

-- Question 3
SELECT TOP 1 Platform, ROUND(SUM(NA_Sales),1) 'Total Sales' FROM Games
GROUP BY Platform
ORDER BY 'Total Sales' DESC;

-- Question 4
SELECT Genre, ROUND(SUM(EU_Sales),1) AS 'Total Sales' FROM Games
GROUP BY Genre
ORDER BY 'Total Sales' DESC;

-- Question 5
SELECT Genre, ROUND(SUM(JP_Sales),1) AS 'Total Sales' FROM Games
GROUP BY Genre
ORDER BY 'Total Sales' DESC;

-- After analysis, role-playing games are the most popular genre in Japan, while shooter games are the least popular.

-- Europe
SELECT Genre, ROUND(SUM(EU_Sales),1) AS 'Total Sales' FROM Games
GROUP BY Genre
ORDER BY 'Total Sales' DESC;

-- After analysis, action games are the most popular genre in Japan, while strategy games are the least popular.

-- North America
SELECT Genre, ROUND(SUM(NA_Sales),1) AS 'Total Sales' FROM Games
GROUP BY Genre
ORDER BY 'Total Sales' DESC;

-- Similar to Europe, action games are the most popular in North america, while strategy games are the least popular

--Question 6
SELECT Platform, ROUND(AVG(Global_Sales),1) 'Average Sales' FROM Games
GROUP BY Platform
ORDER BY 'Average Sales' DESC;

-- Based on the analysis, the GB and NES platforms had the highest average sales.

-- Question 7
WITH PlatformGroups AS (
    SELECT Platform,
           CASE WHEN MIN(Year) < 2005 THEN 'Older'
                ELSE 'Newer'
           END AS PlatformGroup
    FROM Games
    GROUP BY Platform
)
SELECT PlatformGroup, SUM(Global_Sales) AS TotalSales
FROM Games
JOIN PlatformGroups ON Games.Platform = PlatformGroups.Platform
GROUP BY PlatformGroup;
