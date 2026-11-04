-- ============================================
-- SQL Server — Class  Homework
-- BikeStores Sample Database
-- Topics: JOINS and VIEWS 
-- ============================================

-- Q1
-- Show all product names along with their brand name. Sort by brand name, then by product name alphabetically.
   ANSWER:
          SELECT
              P.PRODUCT_NAME,
              B.BRAND_NAME
          FROM 
          [production].[products] P 
          INNER JOIN [production].[brands] B
          ON P.BRAND_ID = B.BRAND_ID
          ORDER BY BRAND_NAME,PRODUCT_NAME ASC 

-- Q2
-- List all products with their category name and list price. Sort by category name, then by price from cheapest to most expensive.
   ANSWER:
          SELECT
             P.PRODUCT_NAME,
             C.CATEGORY_NAME,
             P.LIST_PRICE
          FROM 
          [production].[products] P 
          INNER JOIN [production].[categories] C
          ON P.CATEGORY_ID = C.CATEGORY_ID
          ORDER BY C.CATEGORY_NAME,P.LIST_PRICE ASC 

-- Q3
-- Show all orders with the customer's full name and order date. Sort by order date from newest to oldest.
   ANSWER:
           SELECT
              O.ORDER_ID,
              C.FIRST_NAME +' '+ C.LAST_NAME AS "CUSTOMER FULL NAME" ,
              O.ORDER_DATE
           FROM 
           [sales].[orders] O
           INNER JOIN [sales].[customers] C
           ON O.CUSTOMER_ID = C.CUSTOMER_ID
           ORDER BY O.ORDER_DATE DESC 
           
-- Q4
-- Display each order item with the product name, quantity, unit price, and a computed column called "Line Total" (quantity × list_price). Sort by order ID.
   ANSWER:
          SELECT
             P.PRODUCT_NAME,
             OI.QUANTITY,
             P.LIST_PRICE AS "UNIT PRICE",
             (OI.QUANTITY*P.LIST_PRICE) AS "LINE TOTAL"
          FROM 
          [production].[products] P
          INNER JOIN [sales].[order_items] OI
          ON P.PRODUCT_ID = OI.PRODUCT_ID
          ORDER BY OI.ORDER_ID ASC

-- Q5
-- Show each order along with the store name where it was placed and the order date. Sort by store name.
   ANSWER:
           SELECT
              O.ORDER_ID,
              S.STORE_NAME,
              O.ORDER_DATE
           FROM 
           [sales].[orders] O
           INNER JOIN [sales].[stores] S
           ON O.STORE_ID = O.STORE_ID
           ORDER BY S.STORE_NAME ASC

-- Q6
-- Show each order with: order ID, customer full name, store name, and the staff member's full name who handled it.
   ANSWER:
           SELECT
              O.ORDER_ID,
              C.FIRST_NAME +' '+ C.LAST_NAME AS "CUSTOMER FULL NAME",
              S.STORE_NAME,
              ST.FIRST_NAME +' '+ ST.LAST_NAME AS "STAFF MEMBER FULL NAME"
           FROM 
           [sales].[orders] O
           INNER JOIN [sales].[customers] C
           ON O.CUSTOMER_ID = C.CUSTOMER_ID
           INNER JOIN [sales].[stores] S
           ON O.STORE_ID = S.STORE_ID
           INNER JOIN [sales].[staffs] ST
           ON O.STAFF_ID = ST.STAFF_ID

-- Q7
-- List all products from the brand "Trek" along with their category name and price. Sort by price descending. (Use JOIN — do NOT filter by brand_id directly.)
   ANSWER:
          SELECT
             P.PRODUCT_NAME,
             B.BRAND_NAME,
             C.CATEGORY_NAME,
             P.LIST_PRICE
          FROM 
          [production].[products] P
          INNER JOIN [production].[brands] B
          ON P.BRAND_ID = B.BRAND_ID
          INNER JOIN [production].[categories] C
          ON P.CATEGORY_ID = C.CATEGORY_ID
          WHERE B.BRAND_NAME = 'TREK'
          ORDER BY LIST_PRICE DESC

-- Q8
-- Find all customers from the state of "NY" who have placed at least one order. Show customer full name, city, and order date. (Use JOIN — do not use a subquery.)
   ANSWER:
	SELECT
           C.FIRST_NAME + ' ' + C.LAST_NAME AS CUSTOMER_FULL_NAME,
           C.CITY,
           O.ORDER_DATE
        FROM
        [sales].[customers] C
        INNER JOIN [sales].[orders] O
        ON C.CUSTOMER_ID = O.CUSTOMER_ID
        WHERE C.STATE = 'NY'

-- Q9
-- Show all completed orders (order_status = 4) from the store "Rowlett Bikes". Display order ID, customer full name, and order date.
   ANSWER:
          SELECT
             O.ORDER_ID,
             C.FIRST_NAME + ' ' + C.LAST_NAME AS CUSTOMER_FULL_NAME,
             O.ORDER_DATE
          FROM
          [sales].[orders] O
          INNER JOIN [sales].[customers] C
          ON O.CUSTOMER_ID = C.CUSTOMER_ID
          INNER JOIN [sales].[stores] S
          ON O.STORE_ID = S.STORE_ID
          WHERE O.ORDER_STATUS = 4
          AND S.STORE_NAME = 'Rowlett Bikes'
-- Q10
-- List ALL customers and any orders they have placed. Include customers who have never placed an order (show NULL for order columns). Sort by customer ID.
   ANSWER:
           SELECT
              C.CUSTOMER_ID,
              C.FIRST_NAME + ' ' + C.LAST_NAME AS CUSTOMER_FULL_NAME,
              O.ORDER_ID,
              O.ORDER_DATE,
              O.ORDER_STATUS
           FROM
           [sales].[customers] C
           LEFT JOIN [sales].[orders] O
           ON C.CUSTOMER_ID = O.CUSTOMER_ID
           ORDER BY C.CUSTOMER_ID

-- Q11
-- Find all customers who have NEVER placed an order. Show their full name and email.
   ANSWER:
          SELECT
             C.FIRST_NAME + ' ' + C.LAST_NAME AS CUSTOMER_FULL_NAME,
             C.EMAIL
          FROM
          [sales].[customers] C
          LEFT JOIN [sales].[orders] O
          ON C.CUSTOMER_ID = O.CUSTOMER_ID
          WHERE O.ORDER_ID IS NULL

-- Q12
-- List all products and their stock quantity at every store. Include products that have NO stock record at all. Show product name, store ID, and quantity.
   ANSWER:
           SELECT
              P.PRODUCT_NAME,
              S.STORE_ID,
              S.QUANTITY
           FROM
           [production].[products] P
           LEFT JOIN [production].[stocks] S
           ON P.PRODUCT_ID = S.PRODUCT_ID

-- Q13
-- Find all products that have NEVER been ordered (no record in order_items). Show product name and list price.
   ANSWER:
          SELECT
             P.PRODUCT_NAME,
             P.LIST_PRICE
          FROM
          [production].[products] P
          LEFT JOIN [sales].[order_items] OI
          ON P.PRODUCT_ID = OI.PRODUCT_ID
          WHERE OI.PRODUCT_ID IS NULL
-- Q14
-- List each staff member along with the full name of their manager. Staff with no manager (top-level) should still appear — show NULL for manager name.
   ANSWER:
           SELECT
              S.FIRST_NAME + ' ' + S.LAST_NAME AS STAFF_FULL_NAME,
              M.FIRST_NAME + ' ' + M.LAST_NAME AS MANAGER_FULL_NAME
           FROM
           [sales].[staffs] S
           LEFT JOIN [sales].[staffs] M
           ON S.MANAGER_ID = M.STAFF_ID

-- Q15
-- Create a view called vw_bike_catalog that shows product_name, brand_name, category_name, model_year, and list_price. Then query it to show only products priced over $2,000, sorted by price descending.
   ANSWER:
          CREATE VIEW vw_bike_catalog
           AS
          SELECT
             P.PRODUCT_NAME,
             B.BRAND_NAME,
             C.CATEGORY_NAME,
             P.MODEL_YEAR,
             P.LIST_PRICE
          FROM
          [production].[products] P
          INNER JOIN [production].[brands] B
          ON P.BRAND_ID = B.BRAND_ID
          INNER JOIN [production].[categories] C
          ON P.CATEGORY_ID = C.CATEGORY_ID

   SECOND QUERY:
              SELECT
                 PRODUCT_NAME,
                 BRAND_NAME,
                 CATEGORY_NAME,
                 MODEL_YEAR,
                 LIST_PRICE
              FROM vw_bike_catalog
              WHERE LIST_PRICE > 2000
              ORDER BY LIST_PRICE DESC
          
-- Q16
-- BONUS: Create a view called vw_customer_orders showing: customer full name, order_id, order_date, store_name, and order_status. Then query it to show only orders where the customer city is "New York", sorted by order_date.
   ANSWER:
          CREATE VIEW vw_customer_orders
          AS
          SELECT
             C.FIRST_NAME + ' ' + C.LAST_NAME AS CUSTOMER_FULL_NAME,
             C.CITY,
             O.ORDER_ID,
             O.ORDER_DATE,
             S.STORE_NAME,
             O.ORDER_STATUS
         FROM
         [sales].[customers] C
         INNER JOIN [sales].[orders] O
         ON C.CUSTOMER_ID = O.CUSTOMER_ID
         INNER JOIN [sales].[stores] S
         ON O.STORE_ID = S.STORE_ID

   SECOND QUERY:
             SELECT
                CUSTOMER_FULL_NAME,
                ORDER_ID,
                ORDER_DATE,
                STORE_NAME,
                ORDER_STATUS
            FROM vw_customer_orders
            WHERE CITY = 'New York'
            ORDER BY ORDER_DATE

                             - - - - - - - - - - ASSIGNMENT COMPLETED - - - - - - - - - - -