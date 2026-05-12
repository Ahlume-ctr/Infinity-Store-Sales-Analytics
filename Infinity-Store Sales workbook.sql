-- Databricks notebook source
CREATE OR REPLACE TABLE workspace.default.retail_store_sales_clean AS

SELECT TRY_CAST(GET(SPLIT(transactionId, "_"), 1) AS INT) AS TransactionID,
         TRY_CAST(GET(SPLIT(customerId, "_"), 1) AS INT) AS CustomerID,
           category AS Product_Category,
             TRY_CAST(GET(SPLIT(item, "_"), 1) AS INT) AS Item,
                quantity AS Quantity,
                  totalSpent AS Total_Spent,
                     discountApplied AS Discount_Applied
FROM workspace.default.retail_store_sales;


SELECT*
FROM  workspace.default.retail_store_sales_clean;

--1. TOTAL REVENUE
SELECT
      SUM(Total_Spent) AS Total_Revenue
FROM  workspace.default.retail_store_sales_clean;

--2. PRODUCT PERFORMANCE
SELECT Product_Category,
      SUM(Total_Spent) AS Total_Revenue
FROM  workspace.default.retail_store_sales_clean
GROUP BY Product_Category
ORDER BY Total_Revenue DESC;

--3. SALES PATTERN "DISCOUNT APPLIED"
SELECT COUNT(Discount_Applied) AS Discount_Applied
FROM  workspace.default.retail_store_sales_clean
WHERE Discount_Applied = true;

--3.1 SALES PATTERN "DISCOUNT NOT APPLIED"
SELECT COUNT(Discount_Applied) AS Discount_Not_Applied
FROM  workspace.default.retail_store_sales_clean
WHERE Discount_Applied = false;

--4. TRANSACTION INSIGHTS - Average Customer Spending
SELECT
        AVG(Quantity) AS Avg_Order_Value
FROM  workspace.default.retail_store_sales_clean;

--4.1 Average quantity per transaction
SELECT  CustomerID,
        ROUND(AVG(Quantity), 1) AS Avg_Quantity_Per_Transact --Average quantity per transaction
FROM  workspace.default.retail_store_sales_clean
GROUP BY CustomerID;

