CREATE DATABASE blinkit;
SELECT * FROM blinkit_data;
SELECT COUNT(*) FROM blinkit_data;

SET SQL_SAFE_UPDATES = 0;

# Cleaning the data
UPDATE blinkit_data 
SET `Item Fat Content` = 
CASE 
WHEN `Item Fat Content` IN ('LF', 'low fat') THEN 'Low Fat'
WHEN `Item Fat Content` = 'reg' THEN 'Regular'
ELSE `Item Fat Content`
END;

SELECT DISTINCT(`Item Fat Content`) FROM blinkit_data;

# KPI for total sales in millions(M)
SELECT CONCAT(CAST(SUM(Sales) / 1000000 AS DECIMAL(10,2)), ' Million') AS Total_Sales_Millions 
FROM blinkit_data;

# KPI for average sales 
SELECT CAST(AVG(Sales) AS DECIMAL(10,2)) AS Average_Sales
FROM blinkit_data;

# KPI for total number of items
SELECT COUNT(*) AS No_of_Items FROM blinkit_data ;

# KPI for average rating
SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) AS Average_Rating FROM blinkit_data;

# Granular Requirement

# Data  by fat content 
SELECT `Item Fat Content`, 
	CONCAT(CAST(SUM(Sales)/1000 AS DECIMAL(10,2)), " K") AS Total_Sales_Thousands, 
	CAST(AVG(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    COUNT(*) AS No_of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,1)) AS Average_Rating
FROM blinkit_data 
GROUP BY `Item Fat Content`
ORDER BY Total_Sales_Thousands DESC;

# Data by Item Type
SELECT `Item Type`, 
	CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales, 
	CAST(AVG(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    COUNT(*) AS No_of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,1)) AS Average_Rating
FROM blinkit_data 
GROUP BY `Item Type`
ORDER BY Total_Sales DESC;

# Fat Content by Outlet for Total Sales
SELECT  `Item Fat Content`, `Outlet Location Type` ,
	CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales, 
	CAST(AVG(Sales) AS DECIMAL(10,2)) AS Average_Sales,
    COUNT(*) AS No_of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,1)) AS Average_Rating
FROM blinkit_data 
GROUP BY `Item Fat Content`, `Outlet Location Type` ;

# Total Sales by Outlet Estblishment
SELECT `Outlet Establishment Year`, CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY `Outlet Establishment Year`
ORDER BY `Outlet Establishment Year`;

# Percentage of Sales by Outlet Size
SELECT 
    `Outlet Size`, 
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CONCAT(CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)), " %") AS Sales_Percentage
FROM blinkit_data
GROUP BY `Outlet Size`
ORDER BY Total_Sales DESC;

# Sales by Outlet Location
SELECT `Outlet Location Type`, CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY `Outlet Location Type`
ORDER BY Total_Sales DESC;


# All Metrics by Outlet Type
SELECT `Outlet Type`, 
	CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CONCAT(CAST((SUM(Sales) * 100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)), " %") AS Sales_Percentage,
	CAST(AVG(Sales) AS DECIMAL(10,0)) AS Avg_Sales,
	COUNT(*) AS No_Of_Items,
	CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
	CAST(AVG(`Item Visibility`) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY `Outlet Type`
ORDER BY Total_Sales DESC;


