--índice de práticas sustentáveis: Quantidade de ofertas com práticas sustentáveis / total de ofertas oferecidas na plataforma -- consulta retorna 802 ofertas c/ práticas associadas de um total de 1200 ofertas registradas

SELECT
ROUND
  (COUNT(DISTINCT id_oferta) / 
  (SELECT COUNT(DISTINCT id_oferta) 
FROM `eco-viagens-470816.plataforma_ecoviagens.ofertas`) *100 ,2) AS indice_sustentabilidade
FROM
  `eco-viagens-470816.plataforma_ecoviagens.oferta_pratica`;

--Lista de parceiros que não possuem prática sustentável associada a oferta

SELECT
  o.id_oferta,
  o.titulo,
  op.nome_fantasia
FROM
  `eco-viagens-470816.plataforma_ecoviagens.ofertas` o
LEFT JOIN
  `eco-viagens-470816.plataforma_ecoviagens.oferta_pratica` p ON o.id_oferta = p.id_oferta
LEFT JOIN
  `eco-viagens-470816.plataforma_ecoviagens.operadores` op ON o.id_operador = op.id_operador
WHERE
  p.id_pratica IS NULL
ORDER BY
  1,3;

--Lista de parceiros que possuem pelo menos prática sustentável associada a oferta

SELECT
  DISTINCT o.id_oferta,
  o.titulo,
  op.nome_fantasia
FROM
  `eco-viagens-470816.plataforma_ecoviagens.ofertas` o
LEFT JOIN
  `eco-viagens-470816.plataforma_ecoviagens.oferta_pratica` p ON o.id_oferta = p.id_oferta
LEFT JOIN
  `eco-viagens-470816.plataforma_ecoviagens.operadores` op ON o.id_operador = op.id_operador
WHERE
  p.id_pratica IS NOT NULL
ORDER BY
  1,3;

--Práticas sustentáveis mais populares entre as ofertas

SELECT
  ps.nome,
  COUNT(r.id_reserva) AS total_reservas
FROM
 `eco-viagens-470816.plataforma_ecoviagens.praticas_sustentaveis` ps
INNER JOIN
`eco-viagens-470816.plataforma_ecoviagens.oferta_pratica` op ON ps.id_pratica = op.id_pratica
INNER JOIN 
`eco-viagens-470816.plataforma_ecoviagens.reservas` r ON op.id_oferta = r.id_oferta AND status = 'concluída'
GROUP BY 
  1
ORDER BY
  2
DESC;

--Práticas sustentáveis melhor avaliadas

SELECT
  p.id_pratica,
  pr.nome,
  ROUND(AVG(a.nota), 2) AS media_nota_pratica,
  COUNT(DISTINCT a.id_oferta) AS qtd_ofertas_avaliadas
FROM
  `eco-viagens-470816.plataforma_ecoviagens.avaliacoes` a
INNER JOIN
  `eco-viagens-470816.plataforma_ecoviagens.oferta_pratica` p ON a.id_oferta = p.id_oferta
INNER JOIN
  `eco-viagens-470816.plataforma_ecoviagens.praticas_sustentaveis` pr ON p.id_pratica = pr.id_pratica
GROUP BY
  1,2
ORDER BY
  3 
DESC;

