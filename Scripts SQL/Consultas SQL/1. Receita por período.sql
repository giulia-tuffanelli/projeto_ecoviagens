-- Desempenho financeiro geral da plataforma usando a métrica de receita total bruta por período mensal, para avaliar o crescimento do negócio e identificar sazonalidade, considerando as reservas concluídas.

--Parte 1: visualizar receita mensal

SELECT
  EXTRACT (YEAR FROM data_reserva) AS ano,
  FORMAT_DATE ('%B', DATE (r.data_reserva)) AS nome_mes,
  ROUND(SUM(preco * qtd_pessoas),2) AS receita_total
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.ofertas` o ON r.id_oferta = o.id_oferta
WHERE r.status = 'concluída'
GROUP BY 1,2,EXTRACT (MONTH FROM data_reserva)
ORDER BY 1,EXTRACT (MONTH FROM data_reserva)
ASC;

--Parte 2: visualizar receita anual acumulada

WITH receita_mensal AS
(SELECT
  EXTRACT (YEAR FROM data_reserva) AS ano,
  FORMAT_DATE ('%B', DATE (r.data_reserva)) AS nome_mes,
  ROUND(SUM(preco * qtd_pessoas),2) AS receita_total
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.ofertas` o ON r.id_oferta = o.id_oferta
WHERE r.status = 'concluída'
GROUP BY 1,2,EXTRACT (MONTH FROM data_reserva)
ORDER BY 1,EXTRACT (MONTH FROM data_reserva)
ASC)

SELECT 
  ano,
  ROUND(SUM(receita_total),2) as receita_anual
FROM
receita_mensal
GROUP BY
1
ORDER BY
1
ASC;

-- Parte 3: Visualizar variação percentual da receita em relação ao mês anterior, com comparação de crescimento/decrescimento

WITH receita_mensal AS

(SELECT
  DATE_TRUNC(data_reserva, MONTH) as mes,
  ROUND(SUM(preco * qtd_pessoas),2) AS receita_total
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.ofertas` o ON r.id_oferta = o.id_oferta
WHERE r.status = 'concluída'
GROUP BY 1)

SELECT
  mes,
  receita_total,
  LAG(receita_total) OVER (ORDER BY mes) AS receita_anterior,
  ROUND
  (SAFE_DIVIDE(receita_total - LAG(receita_total) OVER (ORDER BY mes), LAG(receita_total) OVER (ORDER BY mes)),2) *100 AS variacao_percentual
FROM
  receita_mensal
ORDER BY 
  1;

--Parte 4: Média geral de faturamento

WITH receita_mensal AS 
(SELECT
  EXTRACT(YEAR FROM r.data_reserva) AS ano,
  EXTRACT(MONTH FROM r.data_reserva) AS mes,
  ROUND(SUM(o.preco * r.qtd_pessoas), 2) AS receita_total_mes
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.ofertas` o 
ON r.id_oferta = o.id_oferta
WHERE r.status = 'concluída'
  GROUP BY 1, 2)

SELECT 
  ROUND(AVG(receita_total_mes), 2) AS receita_media_mensal
FROM receita_mensal;


--- Número de reservas confirmadas por período:

SELECT 
  EXTRACT (YEAR FROM data_reserva) AS ano,
  FORMAT_DATE ('%B', DATE (data_reserva)) AS mes,
  COUNT(*) AS confirmacao
FROM 
  `eco-viagens-470816.plataforma_ecoviagens.reservas`
WHERE 
  status = 'confirmada'
GROUP BY 
  1,2, EXTRACT (MONTH FROM data_reserva)
ORDER BY 
  1, EXTRACT (MONTH FROM data_reserva)
ASC;