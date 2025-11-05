---Qual é o valor médio gasto por cliente em cada reserva, considerando o gasto individual por pessoa.

--Parte 1: Valor médio gasto por pessoa em cada reserva

SELECT
  SUM(qtd_pessoas) AS qtd_pessoas,
  COUNT(id_reserva) AS qtd_reservas,
  ROUND(SUM(preco * qtd_pessoas),2) AS valor_reservas,
  ROUND(SUM(preco * qtd_pessoas) / SUM(qtd_pessoas),2) AS ticket_medio
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.ofertas` o ON r.id_oferta = o.id_oferta
WHERE r.status = 'concluída';

--Parte 2: Média dos valores de experiências oferecidas na plataforma

SELECT
  ROUND(AVG(preco),2) AS preco_medio
FROM `eco-viagens-470816.plataforma_ecoviagens.ofertas`;

--Parte 3: Média de quantidade de pessoas por reserva concluída

SELECT
  ROUND(SUM(qtd_pessoas) / COUNT(id_reserva),2) AS media_pessoas,
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` 
WHERE status = 'concluída';

--Parte 4: Ranking de clientes que gastaram mais que o ticket médio/pessoa

WITH calculo_reservas AS 
(SELECT
  r.id_cliente,
  c.nome,
  ROUND(SUM(preco * qtd_pessoas),2) AS valor_total,
  COUNT(r.id_oferta) AS qtd_reservas,
  SUM(r.qtd_pessoas) AS pessoas_por_reserva
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas` r
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.ofertas` o ON r.id_oferta = o.id_oferta
INNER JOIN `eco-viagens-470816.plataforma_ecoviagens.clientes` c ON r.id_cliente = c.id_cliente
WHERE r.status = 'concluída'GROUP BY r.id_cliente, c.nome)

SELECT
  id_cliente, 
  nome,
  valor_total,
  ROUND((valor_total / pessoas_por_reserva),2) AS ticket_por_pessoa,
  DENSE_RANK() OVER (ORDER BY (valor_total / pessoas_por_reserva) DESC) AS posicao
FROM calculo_reservas
WHERE (valor_total / pessoas_por_reserva) > 276.88
ORDER BY 4 DESC;