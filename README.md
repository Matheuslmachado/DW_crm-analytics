## Contexto de Negócio

A The Look é uma e-commerce que realiza milhares de pedidos globalmente, atualmente vem sofrendo com sua infraestrutura de dados que foram paralizada no desenvolvimento. O time de Marketing e Financeiro enfrenta dificuldade na integração dos seus sistemas, logo a confiabilidade em calcular suas métricas acabam sendo comprometidas. 

## O Problema (A Dor)

- **Cegueira de Cliente:** Não sabemos quem são nossos melhores clientes. Não diferenciamos um cliente que comprou uma meia há 3 anos de  um que gasta $500 todo mês.
- **Dados Sujos:** Temos registros duplicados, países escritos de formas diferentes (ex: "USA", "United States", "US") e datas em fusos  horários misturados.
- **Métricas Inexistentes:** Não temos clareza sobre nosso Churn (taxa de cancelamento/abandono) nem sobre o LTV (Lifetime Value).  Gastamos dinheiro trazendo clientes que não voltam.

## Objetivo Principal

Construir a **Single Source of Truth (SSOT)** -- a Fonte Única da Verdade -- para a área de CRM e Vendas. Desenvolvendo um Data Warehouse  no BigQuery que limpe os dados brutos e entregue tabelas prontas para o consumo do time de BI (Business Intelligence). 

## Solução Técnica

> **Stack**: Google BigQuery (Standard SQL).

<img width="786" height="253" alt="Image" src="https://github.com/user-attachments/assets/46caad3b-907d-4caa-93f7-d09706c0b853" />

<b></b>


1. **Tabela dim_customers_gold**: Uma visão 360º de cada usuário único. Deve conter:
-  Dados demográficos limpos.
- Segmentação de valor (RFM - Recência, Frequência, Valor Monetário).
- Status do cliente (Novo, Ativo, Churn, Recuperado).
2. **Tabela fct_sales_performance**: Uma tabela de fatos de vendas otimizada.
- Cálculo de ticket médio.
- Métricas de tempo (dias entre pedido e envio).
- Séries temporais (Vendas YoY e MoM).
3. **Relatório Diagnóstico**: Uma análise final respondendo:

  > "Onde estamos perdendo dinheiro e onde estão as oportunidades ocultas?"

## Relatório Diagnostico: Principais Insights
### Desempenho Anual (2019-2026)
> **Recomendação:**
