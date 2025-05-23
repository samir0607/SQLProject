CREATE VIEW gold.dim_customers AS
    SELECT
        ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key, -- surrogate key
        ci.cst_id AS customer_id,
        ci.cst_key AS customer_number,
        ci.cst_firstname AS first_name,
        ci.cst_lastname AS last_name,
        cl.cntry AS country,
        CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM is master for gender info (data integration)
            ELSE COALESCE(ca.gen, 'n/a')
        END AS gender,
        ci.cst_marital_status AS marital_status,
        ca.bdate AS birth_date,
        ci.cst_create_date AS create_date
    FROM silver.crm_cust_info ci
    LEFT JOIN silver.erp_cust_az12 ca
    ON        ci.cst_key = ca.cid
    LEFT JOIN silver.erp_loc_a101 cl
    ON        ci.cst_key = cl.cid

CREATE VIEW gold.dim_products AS
    SELECT 
        ROW_NUMBER() OVER (ORDER BY prd_id) AS product_key,
        pn.prd_id AS product_id,
        pn.prd_key AS product_number,
        pn.prd_nm AS product_name,
        pn.cat_id AS category_id,
        pc.cat AS category,
        pc.subcat AS sub_category,
        pc.maintenance AS maintenance,
        pn.prd_cost AS cost,
        pn.prd_line AS product_line, 
        pn.prd_start_dt AS start_date
    FROM silver.crm_prd_info pn
    LEFT JOIN silver.erp_px_cat_g1v2 pc 
    ON        pn.cat_id = pc.id
    WHERE pn.prd_end_dt IS NULL -- Filter out all historical data

CREATE VIEW gold.fact_sales AS
    SELECT 
        sa.sls_ord_num AS order_number,
        pr.product_key,
        cs.customer_key,
        sa.sls_order_dt AS order_date,
        sa.sls_ship_dt AS shipping_date,
        sa.sls_due_dt AS due_date,
        sa.sls_quantity AS quantity,
        sa.sls_sales AS sales_amount,
        sa.sls_price price
    FROM silver.crm_sales_details sa
    LEFT JOIN gold.dim_products pr 
    ON        pr.product_number = sa.sls_prd_key
    LEFT JOIN gold.dim_customers cs 
    ON        cs.customer_id = sa.sls_cust_id
