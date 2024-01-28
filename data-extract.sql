-- decided to analyze average monthly departure delays across the three New York airports (EWR, JFK, LGA)
SELECT year, month, origin, AVG(dep_delay) AS average_departure_delay
FROM flights
WHERE year = 2013 AND origin IN ('EWR', 'JFK', 'LGA')
GROUP BY year, month, origin
ORDER BY month, origin;
