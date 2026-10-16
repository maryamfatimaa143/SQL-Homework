-- ============================================
-- SQL Server — Class 1 Homework
-- BikeStores Sample Database
-- Topics: Querying · Sorting · Filtering · Set Operators
-- ============================================

-- Q1: List all brand names from the brands table.

-- ANS 01: SELECT BRAND_NAME 
           FROM [PRODUCTION].[BRANDS];

-- Q2: Show the product name and list price of all products,
-- sorted from most expensive to cheapest.

-- ANS 02: SELECT PRODUCT_NAME,LIST_PRICE 
           FROM [PRODUCTION].[PRODUCTS] 
           ORDER BY LIST_PRICE DESC;

-- Q3: Find all customers who live in the state of New York (NY).

-- ANS 03: SELECT * FROM [SALES].[CUSTOMERS] 
           WHERE STATE = 'NY';

-- Q4: Show only the top 5 most expensive products in the store.

-- ANS 04: SELECT TOP 5 * FROM [PRODUCTION].[PRODUCTS] 
           ORDER BY LIST_PRICE DESC;

-- Q5: List all products with a price between $200 and $500,
-- sorted by price ascending.

-- ANS 05: SELECT * FROM [PRODUCTION].[PRODUCTS] 
           WHERE LIST_PRICE BETWEEN 200 AND 500 
           ORDER BY LIST_PRICE ASC;

-- Q6: Find all customers whose last name starts with the letter 'S'.

-- ANS 06: SELECT * FROM [SALES].[CUSTOMERS] 
           WHERE LAST_NAME LIKE 'S%';

-- Q7: List all products that belong to:
-- category 6 (Mountain Bikes) OR category 7 (Road Bikes).

-- ANS 07: SELECT * FROM [PRODUCTION].[PRODUCTS] 
           WHERE CATEGORY_ID IN (6,7);

-- Q8: Show all orders that have NOT been shipped yet
-- (shipped_date is missing).

-- ANS 08: SELECT * FROM [SALES].[ORDERS] 
           WHERE SHIPPED_DATE IS NULL;

-- Q9: Display:
-- product name,
-- brand ID,
-- and a computed column showing 15% off the list price
-- labeled as 'Sale Price'.

-- ANS 09: SELECT PRODUCT_NAME,BRAND_ID,
           LIST_PRICE - (LIST_PRICE*0.15) AS SALES_PRICE 
           FROM [PRODUCTION].[PRODUCTS];

-- Q10: Get a unique list of all cities where BikeStores customers live,
-- sorted alphabetically.

-- ANS 10: SELECT DISTINCT CITY 
           FROM [SALES].[CUSTOMERS] 
           ORDER BY CITY ASC;

-- Q11: List all staff members who are currently active (active = 1),
-- showing their full name and email.

-- ANS 11: SELECT FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
           EMAIL,ACTIVE FROM [SALES].[STAFFS] 
           WHERE ACTIVE = 1;

-- Q12: Using UNION:
-- Get a combined list of all cities from both customers and stores
-- (no duplicates), sorted A–Z.

-- ANS 12: SELECT CITY FROM [SALES].[CUSTOMERS] 
           UNION
           SELECT CITY FROM [SALES].[STORES] 
           ORDER BY CITY ASC;

-- Q13: Using EXCEPT:
-- Find product IDs that exist in order_items
-- but are NOT in the products table.

-- ANS 13: SELECT PRODUCT_ID FROM [SALES].[ORDER_ITEMS] 
           EXCEPT 
           SELECT PRODUCT_ID FROM [PRODUCTION].[PRODUCTS];

-- Q14: List all products from the year 2016
-- with a price greater than $1,500,
-- sorted by price descending.

-- ANS 14: SELECT * FROM [PRODUCTION].[PRODUCTS] 
           WHERE MODEL_YEAR = 2016 AND LIST_PRICE > 1500 
           ORDER BY LIST_PRICE DESC;

-- Q15 (BONUS): Using UNION ALL:
-- Show Trek (brand_id = 9) products from 2016
-- and Surly (brand_id = 8) products from 2017.
-- Include product name, brand, year, and price.
-- Order by year then price descending.

-- ANS 15: SELECT P.PRODUCT_NAME, B.BRAND_NAME, P.MODEL_YEAR, P.LIST_PRICE
           FROM PRODUCTION.PRODUCTS AS P
           INNER JOIN PRODUCTION.BRANDS AS B
           ON P.BRAND_ID = B.BRAND_ID
           WHERE P.BRAND_ID = 9 AND P.MODEL_YEAR = 2016

           UNION ALL 

           SELECT P.PRODUCT_NAME, B.BRAND_NAME, P.MODEL_YEAR, P.LIST_PRICE
           FROM PRODUCTION.PRODUCTS AS P
           INNER JOIN PRODUCTION.BRANDS AS B
           ON P.BRAND_ID = B.BRAND_ID
           WHERE P.BRAND_ID = 8 AND P.MODEL_YEAR = 2017

           ORDER BY MODEL_YEAR, LIST_PRICE DESC;

                           __________________________Assignment Completed_______________________