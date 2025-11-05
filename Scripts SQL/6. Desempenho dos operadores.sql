--Desempenho médio dos operadores por categoria de ofertas

--Para resolver essa questão vamos usar diversas tabelas -> avaliações, ofertas, reservas e operadores. Também considerei somente as reservas concluídas e dividi as consultas por CTE

WITH reservas_concluidas AS

(SELECT
DISTINCT
  r.id_oferta,
  tipo_oferta,
  id_operador
FROM
  `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN
  `eco-viagens-470816.plataforma_ecoviagens.ofertas` o ON r.id_oferta = o.id_oferta
WHERE
  status = 'concluída')

SELECT
  tipo_oferta,
  rc.id_operador,
  nome_fantasia,
  ROUND(AVG(nota),2) AS nota_media
FROM
  reservas_concluidas rc
INNER JOIN
  `eco-viagens-470816.plataforma_ecoviagens.avaliacoes` a ON rc.id_oferta = a.id_oferta
INNER JOIN
  `eco-viagens-470816.plataforma_ecoviagens.operadores` op ON rc.id_operador = op.id_operador
GROUP BY
  1,2,3
ORDER BY
  2,4;

--- Taxa de efetivação de reservas por operador

SELECT
  op.id_operador,
  op.nome_fantasia,
  COUNTIF(r.status = 'concluída') AS reservas_concluidas,
  COUNT(r.id_reserva) AS reservas_totais,
  ROUND(COUNTIF(r.status = 'concluída') / COUNT(r.id_reserva) *100 , 2) AS taxa_efetivacao
FROM
  `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN
  `eco-viagens-470816.plataforma_ecoviagens.ofertas` o ON r.id_oferta = o.id_oferta
INNER JOIN
  `eco-viagens-470816.plataforma_ecoviagens.operadores` op ON o.id_operador = op.id_operador
GROUP BY
  1,2
ORDER BY
  5 
DESC;
