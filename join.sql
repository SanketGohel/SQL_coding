/*
 BACKGROUND:
 
 The following schema is a subset of a relational database of a grocery store
 chain. This chain sells many products of different product classes to its
 customers across its different stores. It also conducts many different
 promotion campaigns.
 
 The relationship between the four tables we want to analyze is depicted below:
 
        # sales                                # products
        +------------------+---------+         +---------------------+---------+
        | product_id       | INTEGER |>--------| product_id          | INTEGER |
        | store_id         | INTEGER |    +---<| product_class_id    | INTEGER |
        | customer_id      | INTEGER |    |    | brand_name          | VARCHAR |
   +---<| promotion_id     | INTEGER |    |    | product_name        | VARCHAR |
   |    | store_sales      | DECIMAL |    |    | is_low_fat_flg      | TINYINT |
   |    | store_cost       | DECIMAL |    |    | is_recyclable_flg   | TINYINT |
   |    | units_sold       | DECIMAL |    |    | gross_weight        | DECIMAL |
   |    | transaction_date | DATE    |    |    | net_weight          | DECIMAL |
   |    +------------------+---------+    |    +---------------------+---------+
   |                                      |
   |    # promotions                      |    # product_classes
   |    +------------------+---------+    |    +---------------------+---------+
   +----| promotion_id     | INTEGER |    +----| product_class_id    | INTEGER |
        | promotion_name   | VARCHAR |         | product_subcategory | VARCHAR |
        | media_type       | VARCHAR |         | product_category    | VARCHAR |
        | cost             | DECIMAL |         | product_department  | VARCHAR |
        | start_date       | DATE    |         | product_family      | VARCHAR |
        | end_date         | DATE    |         +---------------------+---------+
        +------------------+---------+
 */
 /*
 PROMPT
 -- The CMO is interested in understanding how the sales of different
 -- product families are affected by promotional campaigns.
 -- To do so, for each of the available product families,
 -- show the total number of units sold,
 -- as well as the ratio of units sold that had a valid promotion
 -- to units sold without a promotion,
 -- ordered by increasing order of total units sold.
 
 
 EXPECTED OUTPUT
 Note: Please use the column name(s) specified in the expected output in your solution.
 +----------------+------------------+--------------------------------------------------+
 | product_family | total_units_sold | ratio_units_sold_with_promo_to_sold_without_promo|
 +----------------+------------------+--------------------------------------------------+
 | Drink          |          43.0000 |                           0.79166666666666666667 |
 | Non-Consumable |         176.0000 |                           0.76000000000000000000 |
 | Food           |         564.0000 |                           0.75155279503105590062 |
 +----------------+------------------+--------------------------------------------------+
 
 -------------- PLEASE WRITE YOUR SQL SOLUTION BELOW THIS LINE ----------------
*/
SELECT 
    product_family,
    total_units_sold,
    CASE 
      WHEN units_without_promo = 0 
      THEN NULL
      ELSE (units_with_promo / units_without_promo) *1.0
    END AS ratio_units_sold_with_promo_to_sold_without_promo
FROM 
  (
    SELECT 
      pc.product_family AS product_family,
      SUM(s.units_sold) * 1.0 AS total_units_sold,
      SUM(
          CASE 
              WHEN s.promotion_id IS NOT NULL 
                AND p.promotion_id IS NOT NULL
                AND s.transaction_date BETWEEN p.start_date AND p.end_date 
              THEN (s.units_sold) * 1.0 ELSE 0 
          END
      ) AS units_with_promo,
      SUM(
          CASE 
              WHEN s.promotion_id IS NULL THEN (s.units_sold) * 1.0 ELSE 0 
          END
      ) AS units_without_promo
    FROM sales s
    JOIN products pr ON s.product_id = pr.product_id
    JOIN product_classes pc ON pr.product_class_id = pc.product_class_id
    LEFT JOIN promotions p ON s.promotion_id = p.promotion_id
    GROUP BY pc.product_family
 ) AS sub
ORDER BY total_units_sold ASC
