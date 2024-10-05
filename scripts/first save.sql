-- 1. How many rows are in the data_analyst_jobs table?

-- SELECT COUNT(*)
-- FROM data_analyst_jobs;

-- Answer: 1793

-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

-- SELECT *
-- FROM data_analyst_jobs
-- LIMIT 10;

-- Answer: ExxonMobil

-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

-- SELECT COUNT(*)
-- FROM data_analyst_jobs
-- WHERE location LIKE 'TN';

-- SELECT COUNT(*)
-- FROM data_analyst_jobs
-- WHERE location = 'TN' OR location = 'KY';

-- SELECT COUNT(*)
-- FROM data_analyst_jobs
-- WHERE location IN ('TN','KY');

-- SELECT location
-- FROM data_analyst_jobs
-- WHERE location LIKE 'TN' AND location IS NOT NULL;

-- SELECT COUNT(*) AS jobs_in_TN
-- FROM data_analyst_jobs
-- WHERE location LIKE 'TN' OR location = 'KY';

-- Answer: TN is 21, and TN + KY is 27.

-- 4. How many job postings in Tennessee have a star rating above 4?

-- SELECT title, location, star_rating
-- FROM data_analyst_jobs
-- WHERE (location LIKE 'TN') AND (star_rating > 4);

-- SELECT title, company, location, star_rating
-- FROM data_analyst_jobs
-- WHERE (location LIKE 'TN') AND (star_rating > 4);

-- SELECT COUNT(location)
-- FROM data_analyst_jobs
-- WHERE location = 'TN' AND star_rating > '4'

-- Answer: 3

-- 5. How many postings in the dataset have a review count between 500 and 1000?

-- SELECT COUNT(*)
-- FROM data_analyst_jobs
-- WHERE review_count BETWEEN 500 AND 1000;

-- SELECT *
-- FROM data_analyst_jobs
-- WHERE review_count BETWEEN 500 AND 1000;

-- Answer: 151

-- 6. Show the average star rating for companies in each state. The output should show the state as state and the average rating for state as avg_rating. Which state shows the highest average rating? 

-- SELECT location AS state, ROUND(AVG(star_rating),1) AS avg_rating
-- FROM data_analyst_jobs
-- WHERE star_rating IS NOT NULL
-- GROUP BY location
-- ORDER BY avg_rating DESC;

-- Answer: Nebraska has the highest average rating.

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there? 

-- SELECT COUNT(DISTINCT title)
-- FROM data_analyst_jobs;

-- SELECT DISTINCT(title)
-- FROM data_analyst_jobs
-- WHERE title IS NOT NULL;

-- Answer: 881

-- 8. How many unique job titles are there for California companies?

-- SELECT COUNT (DISTINCT title)
-- FROM data_analyst_jobs
-- WHERE location = 'CA' AND location IS NOT NULL;

-- Answer: There are 230 unique job titles for companies based in CA.

-- 9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more than 5000 reviews across all companies?

-- SELECT company, COUNT(location) AS state, SUM(review_count) AS total_reviews, ROUND(AVG(star_rating),1) as avg_rating
-- FROM data_analyst_jobs
-- WHERE (location IS NOT NULL) AND (review_count IS NOT NULL) AND (review_count >= 5000) AND (star_rating IS NOT NULL) AND (company IS NOT NULL)
-- GROUP BY company
-- ORDER BY total_reviews DESC;

-- SELECT company, AVG(star_rating) AS avg_star_rating
-- FROM data_analyst_jobs
-- WHERE company IS NOT NULL
-- GROUP BY company
-- HAVING MIN(review_count) > 5000

-- Answer: There are 40 companies in this dataset with more than 5000 reviews.

-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating? 

-- SELECT company, COUNT(location) AS state, SUM(review_count) AS total_reviews, ROUND(AVG(star_rating),3) as avg_rating
-- FROM data_analyst_jobs
-- WHERE (location IS NOT NULL) AND (review_count IS NOT NULL) AND (review_count >= 5000) AND (star_rating IS NOT NULL) AND (company IS NOT NULL)
-- GROUP BY company
-- ORDER BY avg_rating DESC, total_reviews DESC;

-- SELECT company, AVG(star_rating) AS avg_star_rating
-- FROM data_analyst_jobs
-- WHERE company IS NOT NULL
-- GROUP BY company
-- HAVING MIN(review_count) > 5000
-- ORDER BY avg_star_rating DESC, company
-- LIMIT 1;

-- Answer: Kaiser Permanente headed the 6-way tie and has the highest star rating with more than 5000 reviews with a 4.2 average rating.

-- 11. Find all the job titles that contain the word 'Analyst'. How many different job titles are there?

-- SELECT DISTINCT title
-- FROM data_analyst_jobs
-- WHERE title LIKE '%Analyst%' AND title IS NOT NULL;

-- SELECT DISTINCT title as job_title
-- FROM data_analyst_jobs
-- WHERE title iLIKE '%analyst%' AND title IS NOT NULL;

-- Answer: There are 754 different titles listed in the data set which include the word "Analyst."

-- 12. How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

-- SELECT title
-- FROM data_analyst_jobs
-- WHERE title NOT ILIKE '%analyst%' AND title NOT ILIKE '%analytics%' AND title IS NOT NULL;

-- SELECT title
-- FROM data_analyst_jobs
-- WHERE title NOT LIKE '%Analyst%' AND title NOT LIKE '%ANALYST%' AND title NOT LIKE '%analyst%' AND title NOT LIKE '%analytics%' AND title NOT LIKE '%ANALYTICS%' AND title NOT LIKE '%Analytics%';

-- SELECT title 
-- FROM data_analyst_jobs
-- WHERE to_tsvector(title) @@ to_tsquery('!anal%:*');

-- SELECT DISTINCT title AS title
-- FROM data_analyst_jobs 
-- WHERE title NOT ILIKE '%analyst%' AND title NOT ILIKE '%ANALYTICS%'

-- Answer: There are 4 different job titles that do not contain the word "Analyst" or "Analytics". The word these positions have in common is "Tableau".

--- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
    -- Disregard any postings where the domain is NULL.
    -- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
    -- Which three industries are in the top 3 on this list? How many jobs have been listed for more than 3 weeks for each of the top 3?

-- Select domain AS industry, COUNT(skill) AS SQL_req_jobs, MAX(days_since_posting) AS post_age
-- FROM data_analyst_jobs
-- WHERE skill ILIKE '%sql%' AND domain IS NOT NULL AND days_since_posting > 21
-- GROUP BY domain
-- ORDER BY SQL_req_jobs DESC, post_age DESC;

-- Select COUNT(*) AS num_jobs, domain AS industry, MAX(days_since_posting) AS post_age
-- FROM data_analyst_jobs
-- WHERE skill ILIKE '%sql%' AND domain IS NOT NULL AND days_since_posting > 21
-- GROUP BY domain
-- ORDER BY num_jobs DESC, post_age DESC;

-- Answer: Internet and Software is #1 industry with 62 jobs at 30 days of post age. Banks and Financial Services is the #2 industry with 61 jobs at 30 days of post age. Consulting and Business Services is #3 industry with 57 jobs at 30 days of post age. 