-- Databricks notebook source
SELECT TRY_CAST(GET(SPLIT(transactionId, "_"), 1) AS INT) AS TransactionID,
         TRY_CAST(GET(SPLIT(customerId, "_"), 1) AS INT) AS CustomerID,
           category AS Categoty,
             TRY_CAST(GET(SPLIT(item, "_"), 1) AS INT) AS Item,
                quantity AS Quantity,
                  totalSpent AS Total_Spent,
                     discountApplied AS Discount_Applied
FROM workspace.default.retail_store_sales;

