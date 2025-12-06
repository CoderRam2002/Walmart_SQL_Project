/*Added a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
Added a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.
Added a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.*/
/* =========================================================
   WALMART SALES DATA ANALYSIS TEMPLATE
   TABLE NAME : sales
   DATABASE   : PostgreSQL
   ========================================================= */

/* ===============================
   PRODUCT ANALYSIS
   =============================== */

-- How many unique product lines does the data have?
SELECT COUNT(DISTINCT product_line) AS unique_product_lines
FROM sales;

-- What is the most selling product line?
SELECT product_line,
       SUM(quantity) AS total_quantity_sold
FROM sales
GROUP BY product_line
ORDER BY total_quantity_sold DESC
LIMIT 1;

-- What product line had the largest revenue?
SELECT product_line,
       SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC
LIMIT 1;

-- What product line had the largest VAT?
SELECT product_line,
       SUM(VAT) AS total_vat
FROM sales
GROUP BY product_line
ORDER BY total_vat DESC
LIMIT 1;

-- Fetch each product line and mark Good or Bad based on average sales
WITH product_sales AS (
    SELECT product_line,
           SUM(total) AS total_sales
    FROM sales
    GROUP BY product_line
),
avg_sales AS (
    SELECT AVG(total_sales) AS avg_total_sales
    FROM product_sales
)
SELECT ps.product_line,
       ps.total_sales,
       CASE
           WHEN ps.total_sales > a.avg_total_sales THEN 'Good'
           ELSE 'Bad'
       END AS sales_flag
FROM product_sales ps
CROSS JOIN avg_sales a
ORDER BY ps.total_sales DESC;

-- What is the most common product line by gender?
WITH pl_gender AS (
    SELECT gender,
           product_line,
           COUNT(*) AS cnt,
           ROW_NUMBER() OVER (PARTITION BY gender ORDER BY COUNT(*) DESC) AS rn
    FROM sales
    GROUP BY gender, product_line
)
SELECT gender, product_line, cnt
FROM pl_gender
WHERE rn = 1;

-- What is the average rating of each product line?
SELECT product_line,
       AVG(rating) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;


/* ===============================
   CUSTOMER ANALYSIS
   =============================== */

-- How many unique customer types does the data have?
SELECT COUNT(DISTINCT customer_type) AS unique_customer_types
FROM sales;

-- How many unique payment methods does the data have?
SELECT COUNT(DISTINCT payment_method) AS unique_payment_methods
FROM sales;

-- What is the most common customer type?
SELECT customer_type,
       COUNT(*) AS customer_count
FROM sales
GROUP BY customer_type
ORDER BY customer_count DESC
LIMIT 1;

-- Which customer type buys the most?
SELECT customer_type,
       SUM(quantity) AS total_quantity
FROM sales
GROUP BY customer_type
ORDER BY total_quantity DESC
LIMIT 1;

-- Which customer type brings the most revenue?
SELECT customer_type,
       SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC
LIMIT 1;

-- Which customer type pays the most VAT?
SELECT customer_type,
       SUM(VAT) AS total_vat
FROM sales
GROUP BY customer_type
ORDER BY total_vat DESC
LIMIT 1;

-- What is the gender of most of the customers?
SELECT gender,
       COUNT(*) AS customer_count
FROM sales
GROUP BY gender
ORDER BY customer_count DESC
LIMIT 1;

-- What is the gender distribution per branch?
SELECT branch,
       gender,
       COUNT(*) AS customer_count
FROM sales
GROUP BY branch, gender
ORDER BY branch, gender;


/* ===============================
   SALES ANALYSIS
   =============================== */

-- What is the total revenue by month?
SELECT TO_CHAR(date, 'YYYY-MM') AS year_month,
       SUM(total) AS total_revenue
FROM sales
GROUP BY year_month
ORDER BY year_month;

-- What month had the largest COGS?
SELECT TO_CHAR(date, 'YYYY-MM') AS year_month,
       SUM(cogs) AS total_cogs
FROM sales
GROUP BY year_month
ORDER BY total_cogs DESC
LIMIT 1;

-- Which city has the largest revenue?
SELECT city,
       SUM(total) AS total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 1;

-- Which city has the largest VAT?
SELECT city,
       AVG(VAT) AS avg_vat
FROM sales
GROUP BY city
ORDER BY avg_vat DESC
LIMIT 1;

-- Which branch sold more products than average?
WITH branch_sales AS (
    SELECT branch,
           SUM(quantity) AS total_quantity
    FROM sales
    GROUP BY branch
),
avg_branch AS (
    SELECT AVG(total_quantity) AS avg_quantity
    FROM branch_sales
)
SELECT b.branch,
       b.total_quantity
FROM branch_sales b
CROSS JOIN avg_branch a
WHERE b.total_quantity > a.avg_quantity;

-- Number of sales made in each time of the day per weekday
SELECT 
    TRIM(TO_CHAR(date, 'Day')) AS day_name,
    CASE
        WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day,
    COUNT(*) AS total_sales
FROM sales
GROUP BY day_name, time_of_day
ORDER BY day_name, time_of_day;

-- Which time of the day do customers give most ratings?
SELECT 
    CASE
        WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day,
    COUNT(rating) AS rating_count
FROM sales
GROUP BY time_of_day
ORDER BY rating_count DESC;

-- Which time of the day do customers give most ratings per branch?
SELECT 
    branch,
    CASE
        WHEN time BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day,
    COUNT(rating) AS rating_count
FROM sales
GROUP BY branch, time_of_day
ORDER BY branch, rating_count DESC;

-- Which day of the week has the best average ratings?
SELECT 
    TRIM(TO_CHAR(date, 'Day')) AS day_name,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC
LIMIT 1;

-- Which day of the week has the best average ratings per branch?
SELECT 
    branch,
    TRIM(TO_CHAR(date, 'Day')) AS day_name,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY branch, day_name
ORDER BY branch, avg_rating DESC;

	

