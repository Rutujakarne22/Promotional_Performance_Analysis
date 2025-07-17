use retail_events_db;

/* Provide a list of products with a base price greater than 500 
and that are featured in promo type of 'BOGOF */

SELECT DISTINCT( d.product_name) , f.base_price
FROM fact_events as f
JOIN dim_products as d
ON f.product_code = d.product_code
WHERE base_price >500 AND promo_type = 'BOGOF';


/* Generate a report that provides an overview of the number of stores in each city,
 sorted by store count descending */
 
 SELECT city,COUNT(*) AS store_count from
 dim_stores 
 GROUP BY city 
 ORDER BY store_count DESC;
 
 
 /* Display each campaign with total revenue before 
 and after the campaign (in millions) */
 
SELECT 
    d.campaign_name,
    CONCAT(ROUND(SUM(f.base_price * f.`quantity_sold(before_promo)`) / 1000000, 2), 'M') AS `Total_Revenue(Before_Promotion)`,
    CONCAT(ROUND(SUM(
        CASE
            WHEN f.promo_type = 'BOGOF' THEN f.base_price * 0.5 * 2 * f.`quantity_sold(after_promo)`
            WHEN f.promo_type = '50% OFF' THEN f.base_price * 0.5 * f.`quantity_sold(after_promo)`
            WHEN f.promo_type = '25% OFF' THEN f.base_price * 0.75 * f.`quantity_sold(after_promo)`
            WHEN f.promo_type = '33% OFF' THEN f.base_price * 0.67 * f.`quantity_sold(after_promo)`
            WHEN f.promo_type = '500 cashback' THEN (f.base_price - 500) * f.`quantity_sold(after_promo)`
        END
    ) / 1000000, 2), 'M') AS `Total_Revenue(After_Promotion)`
FROM fact_events AS f
JOIN dim_campaigns AS d
    ON f.campaign_id = d.campaign_id
GROUP BY d.campaign_id, d.campaign_name;
 

 /* Calculate the Incremental Sold Quantity % (ISU%) for 
 each category during the Diwali campaign, and rank them  */
 
WITH cte1 AS (
    SELECT f.*, d.campaign_name,p.category,
        CASE 
            WHEN f.promo_type = 'BOGOF' THEN f.`quantity_sold(after_promo)` * 2
            ELSE f.`quantity_sold(after_promo)`
        END AS quantities_sold_AP
    FROM retail_events_db.fact_events AS f
    JOIN retail_events_db.dim_campaigns AS d ON f.campaign_id = d.campaign_id
    JOIN retail_events_db.dim_products AS p ON f.product_code = p.product_code
    WHERE d.campaign_name = 'Diwali'
),
cte2 AS (
    SELECT 
        campaign_name, 
        category,
        ROUND(((SUM(quantities_sold_AP) - SUM(f.`quantity_sold(before_promo)`)) / 
        SUM(f.`quantity_sold(before_promo)`)) * 100, 2) AS `ISU%`
    FROM cte1 AS f
    GROUP BY campaign_name, category
)
SELECT campaign_name, category, `ISU%`, 
    RANK() OVER (ORDER BY `ISU%` DESC) AS `ISU%_Rank`
FROM cte2;

 
/* Generate a report listing the Top 5 products by IR% across all campaigns, providing
product name, category, and IR% */

WITH cte1 AS (
    SELECT p.category,p.product_name,
        SUM(f.base_price * f.`quantity_sold(before_promo)`) AS Total_Revenue_BP,
        SUM(
            CASE
                WHEN f.promo_type = 'BOGOF' THEN f.base_price * 0.5 * 2 * f.`quantity_sold(after_promo)`
                WHEN f.promo_type = '50% OFF' THEN f.base_price * 0.5 * f.`quantity_sold(after_promo)`
                WHEN f.promo_type = '25% OFF' THEN f.base_price * 0.75 * f.`quantity_sold(after_promo)`
                WHEN f.promo_type = '33% OFF' THEN f.base_price * 0.67 * f.`quantity_sold(after_promo)`
                WHEN f.promo_type = '500 cashback' THEN (f.base_price - 500) * f.`quantity_sold(after_promo)`
            END
        ) AS Total_Revenue_AP
    FROM retail_events_db.fact_events AS f
    JOIN retail_events_db.dim_products AS p ON f.product_code = p.product_code
    JOIN retail_events_db.dim_campaigns AS d ON f.campaign_id = d.campaign_id
    GROUP BY p.product_name, p.category
),
cte2 AS (SELECT *,(Total_Revenue_AP - Total_Revenue_BP) AS IR,
        ROUND(((Total_Revenue_AP - Total_Revenue_BP) / Total_Revenue_BP) * 100, 2) AS `IR%`
    FROM cte1
)
SELECT product_name,category,IR,`IR%`,
    RANK() OVER (ORDER BY `IR%` DESC) AS Rank_IR
FROM cte2 LIMIT 5;





