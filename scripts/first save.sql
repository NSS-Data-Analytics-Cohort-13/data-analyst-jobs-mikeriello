-- 1. How many rows are in the data_analyst_jobs table?

-- SELECT COUNT(*)
-- FROM data_analyst_jobs;

-- Answer: 1793

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

-- SELECT *
-- FROM data_analyst_jobs;

-- Answer: ExxonMobil

-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

-- SELECT COUNT(*)
-- FROM data_analyst_jobs
-- WHERE location LIKE 'TN';

-- SELECT COUNT(*)
-- FROM data_analyst_jobs
-- WHERE location = 'TN';

-- SELECT COUNT(*) AS jobs_in_TN
-- FROM data_analyst_jobs
-- WHERE location LIKE 'TN';

-- SELECT location
-- FROM data_analyst_jobs
-- WHERE location LIKE 'TN' AND location IS NOT NULL;

-- Answer: 21

-- 4. How many job postings in Tennessee have a star rating above 4?

-- SELECT title, location, star_rating
-- FROM data_analyst_jobs
-- WHERE (location LIKE 'TN') AND (star_rating >= 4);

-- SELECT title, company, location, star_rating
-- FROM data_analyst_jobs
-- WHERE (location LIKE 'TN') AND (star_rating >= 4);

-- SELECT ROUND(star_rating) AS rounded_ratings
-- FROM data_analyst_jobs
-- WHERE star_rating IS NOT NULL

-- Answer: 4

-- 5. How many postings in the dataset have a review count between 500 and 1000?

-- SELECT COUNT(*)
-- FROM data_analyst_jobs
-- WHERE review_count BETWEEN 500 AND 1000;

-- Answer: 151

-- 6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for state as avg_rating. Which state shows the highest average rating? 

SELECT *
FROM data_analyst_jobs

SELECT company, location AS state, star_rating AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
ORDER BY state;

SELECT company, location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY company, location, star_rating
ORDER BY state;

SELECT company, location AS state, ROUND(AVG(star_rating),1) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY company, location, star_rating
ORDER BY state, star_rating DESC;

-- YAY