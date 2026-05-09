CREATE OR REPLACE TABLE `crm_analytics.dim_customers_gold` AS

WITH
  user_clean AS (
    SELECT
      id,
      LOWER(TRIM(email)) AS email_tratada,
      UPPER(SUBSTR(gender, 1)) AS genero_tratado,
      UPPER(TRIM(state)) AS estado_tratado,
      UPPER(TRIM(country)) AS pais_tratado,
      COALESCE(age, 0) AS idade_limpa,
      UPPER(TRIM(COALESCE(city, 'NAO INFORMADO'))) AS cidade_limpa,
      date(CAST(created_at AS TIMESTAMP)) AS data_tratada
    FROM bigquery-public-data.thelook_ecommerce.users
  )
SELECT
  u.id AS id,
  u.email_tratada AS email,
  u.genero_tratado AS genero,
  u.estado_tratado AS estado,
  u.pais_tratado AS pais,
  u.idade_limpa AS idade,
  u.cidade_limpa AS cidade,
  u.data_tratada AS data_transacao,
  -- RECÊNCIA: Dias desde a última compra
  date_diff(current_date(), max(date(CAST(created_at AS timestamp))), DAY)
    AS dias_inativo,
  -- FREQUÊNCIA
  COUNT(user_id) AS total_pedidos,
  -- SEGMENTAÇÂO RFM
  CASE
    WHEN
      date_diff(current_date(), max(date(CAST(created_at AS timestamp))), DAY)
      > 90
      THEN
        "Churn"
    WHEN COUNT(user_id) = 1 THEN "Novo"
    ELSE "Recorrente"
    END AS status_cliente
FROM `bigquery-public-data.thelook_ecommerce.orders` AS o
LEFT JOIN user_clean AS u
  ON o.user_id = u.id
GROUP BY ALL;
