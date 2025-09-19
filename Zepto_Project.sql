drop table if exists zepto

create table zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC (8,2),
discountPercent NUMERIC (5,2),
availableQuantity INTEGER,
discountedSP NUMERIC(8,2),
weight_in_grams INTEGER,
outofstock BOOLEAN,
quantity INTEGER
)
 --sku is stock keeping units

--data exploration

--Lets check if the complete data is imported
SELECT COUNT(*) FROM zepto;

--Sample Data
SELECT * FROM zepto
LIMIT 10;

--Different product Category
SELECT DISTINCT category
FROM zepto
ORDER  BY category;

--Product in stock vs out of stock
SELECT outofstock, COUNT (sku_id)
FROM zepto
GROUP BY  outofstock;

--product names present multiple times
SELECT name, COUNT(sku_id) as "Number of SKUs"
FROM zepto
Group by name
Having count(sku_id) > 1
ORDER by count (sku_id) DESC;

--DATA CLEANING

-- Product with price 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSP = 0; --(ONE FOUND)

--Deleting that row
DELETE FROM zepto
WHERE mrp = 0;

--converting paise into rupees
UPDATE zepto
SET mrp = mrp/100.0,
discountedSP = discountedSP/100.0;


--Q1. Find Top 10 best value Products based on the discount percentage
SELECT name,mrp,discountPercent 
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--Q2. What are the Product with High MRP but Out Of Stock
SELECT DISTINCT name, mrp
FROM zepto
WHERE outofstock = TRUE and mrp>300
ORDER BY mrp DESC;

--High Price products that companies would want to restock if they are in demand

--Q3. Calculate Estimate Revenue for each category
SELECT category,
SUM(discountedSP * availableQuantity) AS Total_Revenue
FROM zepto
GROUP BY category
ORDER BY Total_Revenue;

--Q4. Find all the products where MRP is greater than 500rs and Discount is less than 10%.
SELECT DISTINCT name,mrp,discountPercent
FROM zepto
WHERE mrp>500 AND discountPercent<10
ORDER BY mrp DESC;

--Q5. Identify the top 5 categories offering the highest average discount
SELECT category,
ROUND(AVG(discountPercent),2) AS Avg_Discount
FROM zepto
GROUP BY category
ORDER BY Avg_Discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by the best value.
SELECT DISTINCT name,discountedSP,weight_in_grams,
ROUND(discountedSP/weight_in_grams,2) AS Price_per_Gram
FROM zepto
WHERE weight_in_grams >=100
ORDER BY Price_per_Gram;

--this could be helpful for finding value for money products for customers and aslo in ternal pricing strategy


--Q7. Group the products into categories like low, medium, bulk
SELECT DISTINCT name,weight_in_grams,
CASE WHEN weight_in_grams < 1000 THEN 'Low'
     WHEN weight_in_grams < 5000 THEN 'Medium'
	 ELSE 'Bulk'
	 END AS Weight_Category
FROM zepto;

-- This segment can behelpful in bulk order strategies, packaging, delivery planning


--Q8. What is the Total Inventory Weight Per Category?
SELECT category,
SUM(weight_in_grams * availableQuantity) AS Total_Weight
FROM zepto
GROUP BY category
ORDER BY Total_Weight;

--Helpful in Warehouse planning, Identifying Bulky Items