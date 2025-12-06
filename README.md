🛒 Walmart Sales Data Analysis Project
📌 Project Overview

This project focuses on performing end-to-end data analysis on Walmart sales data using PostgreSQL. The goal of the project is to clean raw transactional data and extract meaningful business insights related to products, sales performance, and customer behavior. The results can support data-driven decision making in retail operations.

🧹 Data Cleaning & Preparation

Raw CSV data was cleaned and transformed to make it analysis-ready. The following steps were performed:

Converted date and time formats to PostgreSQL compatible DATE and TIME

Standardized numeric columns using DECIMAL/NUMERIC for financial accuracy

Handled data type mismatches and formatting issues during CSV import

Created additional derived columns such as month_name and day_name

Verified missing values, duplicates, and invalid records

Ensured overall data consistency and reliability for analysis

📦 Product Analysis

Key insights related to product performance were derived, including:

Total number of unique product lines

Most selling product line by quantity

Highest revenue-generating product line

Product line with highest VAT contribution

Good vs Bad product classification based on average sales

Most common product line by gender

Average rating per product line

This analysis helps in understanding product demand, profitability, and customer preferences.

📊 Sales Analysis

Sales performance was analyzed across multiple time and location dimensions:

Total revenue by month

Month with the highest COGS

City and branch level revenue performance

Branch performance vs average sales

Number of sales by time of day and weekday

VAT contribution by city

Time of day with highest customer ratings

Best weekday based on average ratings

These insights support seasonal planning, branch optimization, and operational strategy.

👥 Customer Analysis

Customer behavior and segmentation were analyzed using:

Number of unique customer types and payment methods

Most common customer type

Customer type with highest purchases and revenue

Customer type with highest VAT contribution

Gender distribution overall and by branch

Identification of dominant customer segments

This analysis provides valuable insights into customer purchasing patterns and demographics.

🛠️ Tools & Technologies Used

PostgreSQL – Data storage, cleaning, and analysis

SQL (Advanced Queries) – Aggregation, CTEs, Window Functions

CSV Data Source – Walmart Sales Dataset

pgAdmin – Database management
📈 Project Results & Key Findings

After performing detailed data cleaning and analysis, the following key business insights were derived from the Walmart sales dataset:

Customer Type Performance:
The Member customer segment generated higher overall revenue compared to Normal customers, indicating strong loyalty-driven sales impact.

Top Performing Product Line:
The Electronic Accessories product line emerged as the highest revenue and highest selling category, showing strong customer demand.

Revenue Trends:
Sales showed noticeable variation by month, with clear peak revenue during high-demand seasonal periods, supporting the importance of seasonal stock planning.

Cost & Profitability Insights:
The month with the highest COGS also aligned with peak sales periods, indicating balanced operational scaling during high-volume months.

Branch & City Performance:
Among all locations, one city consistently generated the highest revenue, showing strong regional market dominance.

Payment Behavior:
E-wallet and Cash were the most preferred payment modes, highlighting the significance of digital payments in retail transactions.

Customer Purchasing Patterns:
Female customers contributed slightly more towards overall sales and transactions compared to male customers.

Time-Based Sales Insights:
The afternoon and evening time slots recorded the highest number of transactions and customer ratings.

Product Quality & Satisfaction:
Product lines with higher average sales also showed better customer ratings, reflecting a positive relationship between demand and satisfaction.

VAT Contribution Analysis:
Certain product lines and customer types contributed significantly higher VAT, helping identify key tax-contributing segments.
