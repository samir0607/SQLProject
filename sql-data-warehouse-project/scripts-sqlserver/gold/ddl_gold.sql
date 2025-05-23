SELECT cst_id, COUNT(*) FROM
    (SELECT
        ci.cst_id,
        ci.cst_key,
        ci.cst_firstname,
        ci.cst_lastname,
        ci.cst_marital_status,
        ci.cst_gndr,
        ci.cst_create_date,
        ca.bdate,
        ca.gen,
        cl.cntry
    FROM silver.crm_cust_info ci
    LEFT JOIN silver.erp_cust_az12 ca
    ON        ci.cst_key = ca.cid
    LEFT JOIN silver.erp_loc_a101 cl
    ON        ci.cst_key = cl.cid
)t GROUP BY cst_id
    HAVING COUNT(*) > 1;

SELECT
    ci.cst_gndr,
    ca.gen
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON        ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 cl
ON        ci.cst_key = cl.cid