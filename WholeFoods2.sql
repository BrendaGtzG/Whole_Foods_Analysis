USE fmban_sql_analysis;

SELECT category, sub.diet, ROUND(AVG(sub.cost_per_serving),2) AS avg_price, COUNT(*)
FROM (SELECT category, 
		(ROUND((CASE WHEN id BETWEEN 1 AND 226 THEN (price/100)
		ELSE price END) 
        / totalsize 
        / servingsize, 2)) AS cost_per_serving,
CASE WHEN lowsodium = 1 OR sugarconscious = 1 OR lowfat = 1 THEN 'Healthy' ELSE 'Unhealthy' END AS diet
FROM fmban_data) AS sub
GROUP BY category, diet
ORDER BY category;

/** I used OR in the CASE statement, however, I changed it to AND in order to see the differences between the prices
and make recommendations based on the inclusion and exclusion of products. **/

SELECT sub.diet, ROUND(AVG(sub.cost_per_serving),2) AS avg_price, COUNT(*)
FROM (SELECT 
		(ROUND((CASE WHEN id BETWEEN 1 AND 226 THEN (price/100)
		ELSE price END) 
        / totalsize 
        / servingsize, 2)) AS cost_per_serving,
CASE WHEN lowsodium = 1 AND sugarconscious = 1 AND lowfat = 1 THEN 'Healthy' ELSE 'Unhealthy' END AS diet
FROM fmban_data) AS sub
GROUP BY diet;

/** I used this code to see an overall average of the prices according to the classification **/