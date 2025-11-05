---Distribuição de reservas por tipo de oferta considerando todos status de reserva

SELECT
  o.tipo_oferta,
  COUNT(r.id_reserva) as total_reservas,
  SUM(r.qtd_pessoas) AS total_viajantes
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.ofertas` o ON r.id_oferta = o.id_oferta
GROUP BY 1;

---Taxa de cancelamento

WITH reservas_classificadas AS 
(SELECT
  id_oferta,
  CASE WHEN status IN ('confirmada', 'concluída') THEN 'reserva mantida'
  ELSE 'reserva cancelada'
  END AS status_oferta
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas`)

SELECT
  COUNTIF(status_oferta = 'reserva cancelada') AS total_canceladas,
  COUNTIF(status_oferta = 'reserva mantida') AS total_mantidas,
  ROUND(COUNTIF(status_oferta = 'reserva cancelada') / COUNTIF(status_oferta = 'reserva mantida') *100 ,2 ) AS taxa_cancelamento
FROM reservas_classificadas;

---Impacto financeiro do cancelamento 

--Parte 1: visualizar valor mensal atrelado ao cancelamento

SELECT
  EXTRACT (YEAR FROM data_reserva) AS ano,
  FORMAT_DATE ('%B', DATE (r.data_reserva)) AS nome_mes,
  ROUND(SUM(preco * qtd_pessoas),2) AS valor_cancelamento
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.ofertas` o ON r.id_oferta = o.id_oferta
WHERE r.status = 'cancelada'
GROUP BY 1,2,EXTRACT (MONTH FROM data_reserva)
ORDER BY 1,EXTRACT (MONTH FROM data_reserva)
ASC;

--Parte 2: visualizar valor anual acumulado referente ao cancelamento

WITH valor_cancelamento_mensal AS
(SELECT
  EXTRACT (YEAR FROM data_reserva) AS ano,
  FORMAT_DATE ('%B', DATE (r.data_reserva)) AS nome_mes,
  ROUND(SUM(preco * qtd_pessoas),2) AS valor_cancelamento
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.ofertas` o ON r.id_oferta = o.id_oferta
WHERE r.status = 'cancelada'
GROUP BY 1,2,EXTRACT (MONTH FROM data_reserva)
ORDER BY 1,EXTRACT (MONTH FROM data_reserva)
ASC)

SELECT 
  ano,
  ROUND(SUM(valor_cancelamento),2) as valor_cancelamento_anual
FROM
valor_cancelamento_mensal
GROUP BY
1
ORDER BY
1
ASC;
