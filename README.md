# Zepto-Inventory-and-Product-Analysis-on-SQL

📖 Introduction
This project provides an in-depth analysis of a Zepto product dataset using SQL. The entire workflow, from initial table creation and data cleaning to complex business queries, is performed within a SQL environment. The primary goal is to transform raw product data into actionable insights that can inform decisions related to inventory management, pricing strategy, and revenue forecasting.

🚀 Project Workflow
The analysis is structured into four sequential phases:

Table Creation: A table named zepto is created with a well-defined schema to store the product data efficiently.
Data Exploration: Initial queries are run to understand the dataset's basic characteristics, such as size, structure, and content distribution.
Data Cleaning: The dataset is cleansed to ensure accuracy and consistency. This involved removing invalid records (e.g., products with zero price) and standardizing data formats (e.g., converting prices from paise to rupees).
Business Analysis: Advanced SQL queries are executed to answer specific business questions and uncover key insights.

🎯 Business Questions Addressed

This analysis uses SQL to answer a variety of critical business questions:

🏷️ Pricing & Discounts:

What are the top 10 best-value products based on discount percentage?
Which are the top 5 product categories that offer the highest average discounts?
What are the expensive products (MRP > ₹500) with minimal discounts (<10%)?

📦 Inventory & Stock Management:

Which high-MRP products are currently out of stock and should be prioritized for restocking?
How do in-stock vs. out-of-stock product counts compare?
What is the total inventory weight for each product category?

💰 Revenue & Value Analysis:

What is the estimated potential revenue for each product category?
Which products offer the best value for money based on price per gram?

🚚 Logistics & Operations:

How can products be segmented by weight (Low, Medium, Bulk) to optimize packaging and delivery?

🔍 Example Queries
Here are a couple of examples of the SQL queries used for the analysis.

Query 1: Calculate Estimated Revenue per Category
This query calculates the potential revenue from available stock for each product category, helping to identify the most valuable categories.

SELECT
    category,
    SUM(discountedSP * availableQuantity) AS Total_Revenue
FROM
    zepto
GROUP BY
    category
ORDER BY
    Total_Revenue DESC;

Query 2: Find Value-for-Money Products (Price per Gram)
This query identifies products that offer the best value to customers by calculating the price per unit of weight.

SELECT
    name,
    discountedSP,
    weight_in_grams,
    ROUND(discountedSP / weight_in_grams, 2) AS Price_per_Gram
FROM
    zepto
WHERE
    weight_in_grams >= 100
ORDER BY
    Price_per_Gram ASC
LIMIT 10;
