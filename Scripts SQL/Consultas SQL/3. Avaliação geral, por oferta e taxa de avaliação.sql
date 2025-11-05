--- Avaliação Média Geral

SELECT
  ROUND(AVG(a.nota),2) AS nota_media
FROM
`eco-viagens-470816.plataforma_ecoviagens.ofertas` o
INNER JOIN
`eco-viagens-470816.plataforma_ecoviagens.reservas` r ON o.id_oferta = r.id_oferta AND status = 'concluída'
INNER JOIN
`eco-viagens-470816.plataforma_ecoviagens.avaliacoes` a ON o.id_oferta = a.id_oferta;

--- Avaliação Média Geral por tipo de experiência

SELECT
  tipo_oferta,
  ROUND(AVG(a.nota),2) AS nota_media
FROM
`eco-viagens-470816.plataforma_ecoviagens.ofertas` o
INNER JOIN
`eco-viagens-470816.plataforma_ecoviagens.reservas` r ON o.id_oferta = r.id_oferta AND status = 'concluída'
INNER JOIN
`eco-viagens-470816.plataforma_ecoviagens.avaliacoes` a ON o.id_oferta = a.id_oferta
GROUP BY 
1
ORDER BY 
2;

---Avaliação média das ofertas

--Usando o inner join, retornamos somente as ofertas com reservas concluídas e com avaliação -> média geral

SELECT
  o.id_oferta,
  o.titulo,
  ROUND(AVG(a.nota),2) AS nota_media
FROM
`eco-viagens-470816.plataforma_ecoviagens.ofertas` o
INNER JOIN
`eco-viagens-470816.plataforma_ecoviagens.reservas` r ON o.id_oferta = r.id_oferta AND status = 'concluída'
LEFT JOIN
`eco-viagens-470816.plataforma_ecoviagens.avaliacoes` a ON o.id_oferta = a.id_oferta
GROUP BY
  1,2
ORDER BY
  3
DESC;

--Reservas concluídas mas sem avaliação e ofertas que não tiveram reservas concluídas, consequentemente sem avaliação.

SELECT
  o.id_oferta,
  o.titulo,
  ROUND(AVG(a.nota),2) AS nota_media,
  CASE
    WHEN COUNT(DISTINCT id_reserva) = 0 THEN "sem reserva concluída"
    WHEN COUNT(DISTINCT id_reserva) > 0 AND COUNT(DISTINCT id_avaliacao) = 0 THEN "reserva concluída sem avaliação"
    ELSE "reserva e avaliação concluídas"
    END AS status_oferta
FROM
`eco-viagens-470816.plataforma_ecoviagens.ofertas` o
LEFT JOIN
`eco-viagens-470816.plataforma_ecoviagens.reservas` r ON o.id_oferta = r.id_oferta AND status = 'concluída'
LEFT JOIN
`eco-viagens-470816.plataforma_ecoviagens.avaliacoes` a ON o.id_oferta = a.id_oferta
GROUP BY
  1,2
ORDER BY
  3
DESC;

---Taxa de avaliação após experiência

WITH ofertas_com_reserva AS 
(SELECT 
  COUNT (id_oferta)
FROM `eco-viagens-470816.plataforma_ecoviagens.reservas`
WHERE status = 'concluída'),

ofertas_avaliadas AS 
(SELECT 
  COUNT (id_oferta)
FROM `eco-viagens-470816.plataforma_ecoviagens.avaliacoes`)

SELECT
ROUND((SELECT * FROM ofertas_com_reserva) / (SELECT * FROM ofertas_avaliadas ) * 100 , 2) AS taxa_avaliacao;