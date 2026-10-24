USE customer_behavior;

CREATE DATABASE Customer_Behavior;

USE Customer_Behavior;

USE Customer_Behavior;

SELECT COUNT(*) AS total_customers
FROM customer;

SELECT COUNT(*) AS total_transactions
FROM transactions;

SELECT COUNT(*) AS total_product_categories
FROM product_category;


SELECT *
FROM customer
LIMIT 10; 


SELECT COUNT(*) AS total_rows,
       COUNT(customer_Id) AS non_null_customer_ids,
       COUNT(DISTINCT customer_Id) AS unique_customer_ids
FROM customer;


SELECT
    COUNT(*) AS total_rows,
    SUM(DOB IS NULL) AS missing_dob,
    SUM(Gender IS NULL) AS missing_gender,
    SUM(city_code IS NULL) AS missing_city
FROM customer; 


SELECT Gender, COUNT(*) AS customer_count
FROM customer
GROUP BY Gender;


SELECT *
FROM transactions
LIMIT 10;


SELECT Gender, COUNT(*) AS customer_count
FROM customer
GROUP BY Gender;


SELECT
    MIN(Qty) AS minimum_quantity,
    MAX(Qty) AS maximum_quantity,
    MIN(total_amt) AS minimum_amount,
    MAX(total_amt) AS maximum_amount
FROM transactions;


SELECT *
FROM product_category
ORDER BY prod_cat, prod_subcat;

SELECT
    COUNT(*) AS total_rows,
    SUM(customer_Id IS NULL) AS null_customer_id,
    SUM(DOB IS NULL) AS null_DOB,
    SUM(Gender IS NULL) AS null_Gender,
    SUM(city_code IS NULL) AS null_city_code
FROM customer;

SELECT customer_Id, COUNT(*) AS count
FROM customer
GROUP BY customer_Id
HAVING COUNT(*) > 1;

SELECT Gender, COUNT(*) AS count
FROM customer
GROUP BY Gender;

SELECT city_code, COUNT(*) AS count
FROM customer
GROUP BY city_code
ORDER BY city_code;  

SELECT DOB
FROM customer
LIMIT 20;

SELECT *
FROM customer
WHERE Gender = '';

SELECT *
FROM customer
WHERE TRIM(Gender) = ''; 

SELECT DISTINCT Gender
FROM customer; 

SELECT COUNT(*) AS total_rows
FROM customer;

SHOW TABLES;

SELECT COUNT(*) AS total_rows
FROM customer;

SELECT *
FROM customer
WHERE customer_Id IN (267199, 271626);

UPDATE customer
SET Gender = NULL
WHERE TRIM(Gender) = '';
SET SQL_SAFE_UPDATES = 0;

UPDATE customer
SET Gender = NULL
WHERE TRIM(Gender) = '';

SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM customer
WHERE customer_Id IN (267199, 271626);

SELECT
    customer_Id,
    Gender,
    Gender IS NULL AS is_missing
FROM customer
WHERE customer_Id IN (267199, 271626);

SELECT
    COUNT(*) AS total_rows,
    SUM(customer_Id IS NULL) AS null_customer_id,
    SUM(DOB IS NULL) AS null_DOB,
    SUM(Gender IS NULL) AS null_Gender,
    SUM(city_code IS NULL) AS null_city_code
FROM customer; 

SELECT DOB
FROM customer
WHERE STR_TO_DATE(DOB, '%d-%m-%Y') IS NULL;

SELECT customer_Id, COUNT(*) AS count
FROM customer
GROUP BY customer_Id
HAVING COUNT(*) > 1; 

SELECT
    MIN(city_code) AS minimum_city_code,
    MAX(city_code) AS maximum_city_code,
    COUNT(DISTINCT city_code) AS unique_city_codes
FROM customer;  

DESCRIBE product_category;

SELECT *
FROM product_category
LIMIT 10; 

SELECT COUNT(*) AS total_rows
FROM product_category;

SELECT
    COUNT(*) AS total_rows,
    SUM(prod_cat_code IS NULL) AS null_cat_code,
    SUM(prod_cat IS NULL) AS null_cat,
    SUM(prod_sub_cat_code IS NULL) AS null_subcat_code,
    SUM(prod_subcat IS NULL) AS null_subcat
FROM product_category; 

SELECT
    prod_cat_code,
    prod_cat,
    prod_sub_cat_code,
    prod_subcat,
    COUNT(*) AS count
FROM product_category
GROUP BY
    prod_cat_code,
    prod_cat,
    prod_sub_cat_code,
    prod_subcat
HAVING COUNT(*) > 1; 

SELECT
    prod_cat_code,
    prod_cat,
    COUNT(*) AS subcategory_count
FROM product_category
GROUP BY prod_cat_code, prod_cat
ORDER BY prod_cat_code; 

SELECT
    prod_sub_cat_code,
    prod_subcat,
    COUNT(*) AS count
FROM product_category
GROUP BY prod_sub_cat_code, prod_subcat
ORDER BY prod_sub_cat_code; 

DESCRIBE transactions;

SELECT *
FROM transactions
LIMIT 10; 

SELECT COUNT(*) AS total_rows
FROM transactions;

SELECT
    COUNT(*) AS total_rows,
    SUM(transaction_id IS NULL) AS null_transaction_id,
    SUM(cust_id IS NULL) AS null_cust_id,
    SUM(tran_date IS NULL) AS null_tran_date,
    SUM(prod_subcat_code IS NULL) AS null_subcat_code,
    SUM(prod_cat_code IS NULL) AS null_prod_cat_code,
    SUM(Qty IS NULL) AS null_Qty,
    SUM(Rate IS NULL) AS null_Rate,
    SUM(Tax IS NULL) AS null_Tax,
    SUM(total_amt IS NULL) AS null_total_amt,
    SUM(Store_type IS NULL) AS null_store_type
FROM transactions;

SELECT
    transaction_id,
    COUNT(*) AS count
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS negative_transactions
FROM transactions
WHERE Qty < 0
   OR Rate < 0
   OR total_amt < 0;
   
   SELECT
    COUNT(*) AS negative_qty
FROM transactions
WHERE Qty < 0;

SELECT
    Store_type,
    COUNT(*) AS count
FROM transactions
GROUP BY Store_type
ORDER BY count DESC;

SELECT COUNT(*) AS invalid_dates
FROM transactions
WHERE STR_TO_DATE(tran_date, '%d-%m-%Y') IS NULL;

SELECT
    Qty,
    Rate,
    Tax,
    total_amt,
    Store_type,
    COUNT(*) AS count
FROM transactions
WHERE Qty < 0
GROUP BY Qty, Rate, Tax, total_amt, Store_type
ORDER BY count DESC; 

SELECT tran_date, COUNT(*) AS count
FROM transactions
WHERE STR_TO_DATE(tran_date, '%d-%m-%Y') IS NULL
GROUP BY tran_date
ORDER BY count DESC
LIMIT 30;

SELECT COUNT(*) AS invalid_dates
FROM transactions
WHERE STR_TO_DATE(tran_date, '%e/%c/%Y') IS NULL;

SELECT
    CASE
        WHEN tran_date LIKE '%-%' THEN 'DD-MM-YYYY format'
        WHEN tran_date LIKE '%/%' THEN 'D/M/YYYY format'
        ELSE 'Other format'
    END AS date_format,
    COUNT(*) AS count
FROM transactions
GROUP BY date_format;

SELECT
    COUNT(*) AS duplicate_ids,
    SUM(cnt - 1) AS extra_rows,
    MAX(cnt) AS maximum_repetitions
FROM (
    SELECT transaction_id, COUNT(*) AS cnt
    FROM transactions
    GROUP BY transaction_id
    HAVING COUNT(*) > 1
) AS duplicates;

SELECT
    transaction_id,
    COUNT(*) AS occurrences,
    COUNT(DISTINCT tran_date) AS different_dates,
    COUNT(DISTINCT cust_id) AS different_customers,
    COUNT(DISTINCT total_amt) AS different_amounts
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1
ORDER BY occurrences DESC
LIMIT 10;

SELECT COUNT(*) AS invalid_category_records
FROM transactions t
LEFT JOIN product_category p
    ON t.prod_cat_code = p.prod_cat_code
    AND t.prod_subcat_code = p.prod_sub_cat_code
WHERE p.prod_cat_code IS NULL;

ALTER TABLE transactions
ADD COLUMN clean_tran_date DATE;

UPDATE transactions
SET clean_tran_date =
    CASE
        WHEN tran_date LIKE '%-%'
            THEN STR_TO_DATE(tran_date, '%d-%m-%Y')
        WHEN tran_date LIKE '%/%'
            THEN STR_TO_DATE(tran_date, '%e/%c/%Y')
    END;
    
    SET SQL_SAFE_UPDATES = 0;
    
    UPDATE transactions
SET clean_tran_date =
    CASE
        WHEN tran_date LIKE '%-%'
            THEN STR_TO_DATE(tran_date, '%d-%m-%Y')
        WHEN tran_date LIKE '%/%'
            THEN STR_TO_DATE(tran_date, '%e/%c/%Y')
    END;
    
    SET SQL_SAFE_UPDATES = 1;
    
    SELECT
    COUNT(*) AS total_rows,
    SUM(clean_tran_date IS NULL) AS null_clean_dates,
    MIN(clean_tran_date) AS earliest_date,
    MAX(clean_tran_date) AS latest_date
FROM transactions;

SELECT
    transaction_id,
    tran_date,
    clean_tran_date
FROM transactions
LIMIT 10; 

SELECT
    ROUND(SUM(total_amt), 2) AS total_revenue
FROM transactions; 

SELECT
    MIN(clean_tran_date) AS start_date,
    MAX(clean_tran_date) AS end_date,
    DATEDIFF(MAX(clean_tran_date), MIN(clean_tran_date)) AS total_days,
    TIMESTAMPDIFF(MONTH, MIN(clean_tran_date), MAX(clean_tran_date)) AS total_months,
    TIMESTAMPDIFF(YEAR, MIN(clean_tran_date), MAX(clean_tran_date)) AS total_years
FROM transactions;

SELECT
    prod_cat,
    prod_subcat
FROM product_category
WHERE LOWER(TRIM(prod_subcat)) = 'diy';

SELECT
    Store_type,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY Store_type
ORDER BY transaction_count DESC;

SELECT
    Gender,
    COUNT(*) AS customer_count
FROM customer
GROUP BY Gender
ORDER BY customer_count DESC;

SELECT
    city_code,
    COUNT(*) AS customer_count
FROM customer
GROUP BY city_code
ORDER BY customer_count DESC
LIMIT 1;

SELECT
    COUNT(*) AS books_subcategory_count
FROM product_category
WHERE prod_cat = 'Books';

SELECT
    MAX(Qty) AS maximum_quantity
FROM transactions
WHERE Qty > 0;

SELECT
    prod_cat_code,
    ROUND(SUM(total_amt), 2) AS net_revenue
FROM transactions
WHERE prod_cat_code IN (
    SELECT prod_cat_code
    FROM product_category
    WHERE prod_cat IN ('Electronics', 'Books')
)
GROUP BY prod_cat_code;

SELECT
    cust_id,
    COUNT(*) AS transaction_count
FROM transactions
WHERE Qty > 0
GROUP BY cust_id
HAVING COUNT(*) > 10
ORDER BY transaction_count DESC;

SELECT
    ROUND(SUM(t.total_amt), 2) AS combined_revenue
FROM transactions t
JOIN product_category p
    ON t.prod_cat_code = p.prod_cat_code
    AND t.prod_subcat_code = p.prod_sub_cat_code
WHERE p.prod_cat IN ('Electronics', 'Clothing')
  AND t.Store_type = 'Flagship store';
  
  SELECT
    p.prod_subcat,
    ROUND(SUM(CASE WHEN t.Qty > 0 THEN t.total_amt ELSE 0 END), 2) AS sales,
    ROUND(ABS(SUM(CASE WHEN t.Qty < 0 THEN t.total_amt ELSE 0 END)), 2) AS returns
FROM transactions t
JOIN product_category p
    ON t.prod_cat_code = p.prod_cat_code
    AND t.prod_subcat_code = p.prod_sub_cat_code
GROUP BY p.prod_subcat
ORDER BY sales DESC
LIMIT 5;

SELECT
    p.prod_subcat,
    ROUND(
        100 * SUM(CASE WHEN t.Qty > 0 THEN t.total_amt ELSE 0 END)
        / (SELECT SUM(CASE WHEN Qty > 0 THEN total_amt ELSE 0 END)
           FROM transactions),
        2
    ) AS sales_percentage,
    ROUND(
        100 * ABS(SUM(CASE WHEN t.Qty < 0 THEN t.total_amt ELSE 0 END))
        / (SELECT ABS(SUM(CASE WHEN Qty < 0 THEN total_amt ELSE 0 END))
           FROM transactions),
        2
    ) AS return_percentage
FROM transactions t
JOIN product_category p
    ON t.prod_cat_code = p.prod_cat_code
    AND t.prod_subcat_code = p.prod_sub_cat_code
GROUP BY p.prod_subcat
ORDER BY sales_percentage DESC;

SELECT
    ROUND(SUM(t.total_amt), 2) AS revenue
FROM transactions t
JOIN customer c
    ON t.cust_id = c.customer_Id
WHERE TIMESTAMPDIFF(
          YEAR,
          STR_TO_DATE(c.DOB, '%d-%m-%Y'),
          t.clean_tran_date
      ) BETWEEN 25 AND 35
  AND t.clean_tran_date BETWEEN
      DATE_SUB((SELECT MAX(clean_tran_date) FROM transactions), INTERVAL 30 DAY)
      AND (SELECT MAX(clean_tran_date) FROM transactions);
      
      
      SELECT
    p.prod_cat,
    ROUND(
        ABS(SUM(CASE WHEN t.Qty < 0 THEN t.total_amt ELSE 0 END)),
        2
    ) AS return_value
FROM transactions t
JOIN product_category p
    ON t.prod_cat_code = p.prod_cat_code
    AND t.prod_subcat_code = p.prod_sub_cat_code
WHERE t.clean_tran_date >= DATE_SUB(
    (SELECT MAX(clean_tran_date) FROM transactions),
    INTERVAL 3 MONTH
)
GROUP BY p.prod_cat
ORDER BY return_value DESC;

SELECT
    Store_type,
    ROUND(SUM(CASE WHEN Qty > 0 THEN total_amt ELSE 0 END), 2) AS sales_revenue,
    SUM(CASE WHEN Qty > 0 THEN Qty ELSE 0 END) AS quantity_sold
FROM transactions
GROUP BY Store_type
ORDER BY sales_revenue DESC;

SELECT
    p.prod_cat,
    ROUND(AVG(t.total_amt), 2) AS average_revenue
FROM transactions t
JOIN product_category p
    ON t.prod_cat_code = p.prod_cat_code
    AND t.prod_subcat_code = p.prod_sub_cat_code
GROUP BY p.prod_cat
HAVING AVG(t.total_amt) > (
    SELECT AVG(total_amt)
    FROM transactions
)
ORDER BY average_revenue DESC;

SELECT
    p.prod_cat,
    p.prod_subcat,
    ROUND(AVG(t.total_amt), 2) AS average_revenue,
    ROUND(SUM(t.total_amt), 2) AS total_revenue
FROM transactions t
JOIN product_category p
    ON t.prod_cat_code = p.prod_cat_code
    AND t.prod_subcat_code = p.prod_sub_cat_code
WHERE p.prod_cat IN (
    SELECT prod_cat
    FROM (
        SELECT
            p2.prod_cat,
            SUM(CASE WHEN t2.Qty > 0 THEN t2.Qty ELSE 0 END) AS quantity_sold
        FROM transactions t2
        JOIN product_category p2
            ON t2.prod_cat_code = p2.prod_cat_code
            AND t2.prod_subcat_code = p2.prod_sub_cat_code
        GROUP BY p2.prod_cat
        ORDER BY quantity_sold DESC
        LIMIT 5
    ) AS top_categories
)
GROUP BY p.prod_cat, p.prod_subcat
ORDER BY p.prod_cat, total_revenue DESC;

WITH category_quantity AS (
    SELECT
        p.prod_cat,
        SUM(CASE WHEN t.Qty > 0 THEN t.Qty ELSE 0 END) AS quantity_sold
    FROM transactions t
    JOIN product_category p
        ON t.prod_cat_code = p.prod_cat_code
        AND t.prod_subcat_code = p.prod_sub_cat_code
    GROUP BY p.prod_cat
),
top_5_categories AS (
    SELECT prod_cat
    FROM category_quantity
    ORDER BY quantity_sold DESC
    LIMIT 5
)
SELECT
    p.prod_cat,
    p.prod_subcat,
    ROUND(AVG(t.total_amt), 2) AS average_revenue,
    ROUND(SUM(t.total_amt), 2) AS total_revenue
FROM transactions t
JOIN product_category p
    ON t.prod_cat_code = p.prod_cat_code
    AND t.prod_subcat_code = p.prod_sub_cat_code
JOIN top_5_categories tc
    ON p.prod_cat = tc.prod_cat
GROUP BY p.prod_cat, p.prod_subcat
ORDER BY p.prod_cat, total_revenue DESC;