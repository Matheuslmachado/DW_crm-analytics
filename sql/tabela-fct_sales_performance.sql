CREATE OR REPLACE TABLE `crm_analytics.fct_sales_performance` AS
WITH orders_clean AS (
  SELECT 
        order_id,
        user_id,
        UPPER(TRIM(status)) AS status,
        DATE(CAST(created_at AS TIMESTAMP)) AS data_transacao,
        DATE(CAST(shipped_at AS TIMESTAMP)) AS data_envio
  FROM `bigquery-public-data.thelook_ecommerce.orders`
)
SELECT
      tb2.order_id,
      tb2.user_id,
      tb2.status,
      tb2.data_transacao,
      tb2.data_envio,
      COUNT(tb1.id) AS itens_comprados,
      DATE_DIFF(tb2.data_envio, tb2.data_transacao, DAY) AS tempo_envio,
      SUM(tb1.sale_price) AS receita_bruta
FROM `bigquery-public-data.thelook_ecommerce.order_items` tb1
LEFT JOIN orders_clean tb2 USING(order_id)
GROUP BY 1,2,3,4,5;
