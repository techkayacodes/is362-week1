-- #1 Query to find the number of airplanes with listed speeds, and the minimum and maximum speeds:

SELECT COUNT(*) AS total_planes_with_speed,
       MIN(speed) AS min_speed,
       MAX(speed) AS max_speed
FROM planes
WHERE speed IS NOT NULL;

-- Airplanes with Listed Speeds & Their Min/Max Speeds:

-- Number of Airplanes with Listed Speeds: 23
-- Minimum Listed Speed: 90.0 (assumed units are knots or mph)
-- Maximum Listed Speed: 432.0 (assumed units are knots or mph)



-- #2 Query to find the total distance flown by all planes in January 2013, and with missing tail numbers:

-- Total distance for January 2013
SELECT SUM(distance) AS total_distance_jan_2013
FROM flights
WHERE year = 2013 AND month = 1;

-- Total distance for January 2013 with missing tail numbers
SELECT SUM(distance) AS total_distance_jan_2013_no_tailnum
FROM flights
WHERE year = 2013 AND month = 1 AND tailnum IS NULL;

-- Total Distance Flown in January 2013:

-- Total Distance Flown by All Planes in January 2013: 27,188,805 (assumed units are miles)
-- Total Distance Flown by All Planes in January 2013 with Missing Tailnum: 0 (This indicates there were no flights recorded without a tail number in January 2013)


-- #3 Queries to find the total distance flown on July 5, 2013, grouped by aircraft manufacturer using INNER JOIN and LEFT OUTER JOIN:

-- Using INNER JOIN
SELECT p.manufacturer, SUM(f.distance) AS total_distance
FROM flights f
INNER JOIN planes p ON f.tailnum = p.tailnum
WHERE f.year = 2013 AND f.month = 7 AND f.day = 5
GROUP BY p.manufacturer;

-- Using LEFT OUTER JOIN
SELECT p.manufacturer, SUM(f.distance) AS total_distance
FROM flights f
LEFT JOIN planes p ON f.tailnum = p.tailnum
WHERE f.year = 2013 AND f.month = 7 AND f.day = 5
GROUP BY p.manufacturer;

-- Total Distance Flown on July 5, 2013, Grouped by Aircraft Manufacturer:

-- The results are the same for both INNER JOIN and LEFT OUTER JOIN, indicating that there were no flights on July 5, 2013, with tail numbers that did not match any record in the planes database.
-- Total Distance Flown, Grouped by Manufacturer:
-- AIRBUS: 195,089
-- AIRBUS INDUSTRIE: 78,786
-- AMERICAN AIRCRAFT INC: 2,199
-- ... [and others]


-- #4 Custom query to find the top 5 airports in terms of the number of departing flights in 2013, and the most common aircraft models used for these departures:

-- Identifying the top 5 airports
SELECT origin, COUNT(*) AS num_departures
FROM flights
WHERE year = 2013
GROUP BY origin
ORDER BY num_departures DESC
LIMIT 5;

-- Finding the most common aircraft models for these top airports (will require further processing to get the top model for each airport)
SELECT f.origin, p.model, COUNT(*) AS model_count
FROM flights f
JOIN planes p ON f.tailnum = p.tailnum
WHERE f.year = 2013 AND f.origin IN (SELECT origin FROM flights WHERE year = 2013 GROUP BY origin ORDER BY COUNT(*) DESC LIMIT 5)
GROUP BY f.origin, p.model
ORDER BY f.origin, model_count DESC;

-- Top 5 Airports by Number of Departing Flights in 2013:

-- EWR (Newark Liberty International Airport): 120,835 flights
-- JFK (John F. Kennedy International Airport): 111,279 flights
-- LGA (LaGuardia Airport): 104,662 flights
-- Note: Only three airports are listed, which suggests that the dataset may be limited to a specific region or set of airports.

-- Most Common Aircraft Models Used for Departures from These Airports:

-- For EWR: The most common aircraft model was the EMB-145LR with 27,675 departures.
-- For JFK: The most common aircraft model was the A320-232 with 24,464 departures.
-- For LGA: The most common aircraft model was the A320-232 with 7,913 departures.