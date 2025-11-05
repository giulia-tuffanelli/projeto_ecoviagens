---Taxa de recompra: considerei o cálculo de clientes que fizeram mais de uma compra dividido pelos clientes que já compraram alguma vez. 

--Considerei três etapas na montagem da query:

--1. Lista de clientes que fizeram mais de uma reserva com status 'concluída' (clientes fiéis)
--2. Contar quantos são esses clientes fiéis
--3. Dividir o valor anterior pelo total de clientes que fizeram pelo menos 1 reserva concluída

SELECT
  ROUND (COUNT (*)/(SELECT COUNT (DISTINCT id_cliente) FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` WHERE status = 'concluída'),2)*100 AS percentual_fidelizacao
FROM
  (SELECT
  id_cliente,
    FROM `eco-viagens-470816.plataforma_ecoviagens.reservas`
  WHERE status = 'concluída'
  GROUP BY id_cliente
  HAVING COUNT(id_reserva) > 1) clientes_fidelizados;

--Lista de clientes fidelizados:

SELECT
  r.id_cliente,
  nome,
  COUNT(id_reserva) AS contagem_reservas
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.clientes` c ON r.id_cliente = c.id_cliente
WHERE 
  status = 'concluída'
GROUP BY 
  1,2
HAVING 
  COUNT(id_reserva) > 1
ORDER BY 
  3
DESC;

--Lista de clientes com somente uma reserva concluída:

SELECT
  r.id_cliente,
  nome,
  COUNT(id_reserva) AS contagem_reservas
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.clientes` c ON r.id_cliente = c.id_cliente
WHERE 
  status = 'concluída'
GROUP BY 
  1,2
HAVING 
  COUNT(id_reserva) = 1
ORDER BY 
  3
DESC;

--Tempo médio entre reservas dos clientes fidelizados:

--Aqui filtrei clientes com mais de 1 reserva e depois calculei LAG e LEAD. Então o ideal é separar a contagem em uma CTE e depois trazer as reservas.

WITH clientes_fidelizados AS

(SELECT
  id_cliente,
  data_reserva
FROM 
  `eco-viagens-470816.plataforma_ecoviagens.reservas`
WHERE 
  status = 'concluída'
AND id_cliente IN (
  SELECT
    id_cliente,
  FROM `eco-viagens-470816.plataforma_ecoviagens.reservas`
  WHERE status = 'concluída'
  GROUP BY id_cliente
  HAVING COUNT(DISTINCT id_reserva) > 1)),

dif_datas AS

(SELECT
  id_cliente,
  DATE_DIFF (data_reserva, LAG(data_reserva) OVER (PARTITION BY id_cliente ORDER BY data_reserva), DAY) AS dif_dias
FROM
  clientes_fidelizados)
  
SELECT
  dif.id_cliente,
  nome,
  ROUND(AVG(dif_dias),2) AS intervalo_medio_reservas
FROM
  dif_datas dif
INNER JOIN
  `eco-viagens-470816.plataforma_ecoviagens.clientes` c on dif.id_cliente = c.id_cliente
WHERE 
  dif_dias IS NOT NULL
GROUP BY 
  1,2
ORDER BY
  3
DESC;