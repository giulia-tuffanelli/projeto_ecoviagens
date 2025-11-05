# **EcoViagens - Plataforma de Turismo Sustentável** 🌱

Nesse projeto apliquei modelagem de dados, conceitos e definição de KPIs (Key Performance Indicator) e criei um dashboard para estudo de performance da empresa EcoViagens com SQL e Power BI para analisar se a empresa possui crescimento sustentável no modelo atual de negócio. 

- [Modelo de Dados](https://github.com/giulia-tuffanelli/projeto_ecoviagens/blob/1a16a46ad4ea28e50591343eab1bf998799668bc/Diagrama%20de%20relacionamento.png)
- [Scripts em SQL](https://github.com/giulia-tuffanelli/projeto_ecoviagens/tree/5bd6b0eb5d92bdb42a6e09d51370694fe0de4e12/Scripts%20SQL)
- [Dashboard em Power BI](https://app.fabric.microsoft.com/view?r=eyJrIjoiZGNiNDY1MmMtMzg0MS00MzI3LWE4ZDgtYjI0OWYyZTc2MGZjIiwidCI6ImFjMWNhNjc0LWNjMmQtNDIzMS05ZjM4LTQ5ZDk4OWMzMmY3YSJ9)
- [Apresentação Corporativa do projeto](https://github.com/giulia-tuffanelli/projeto_ecoviagens/blob/1a16a46ad4ea28e50591343eab1bf998799668bc/Apresenta%C3%A7%C3%A3o%20An%C3%A1lise%20Ecoviagens%20-%20Giulia.pdf)
- [Relatório Técnico completo em PDF](https://github.com/giulia-tuffanelli/projeto_ecoviagens/blob/402f437456be008799bc341d5f2e4dfa26474330/Relat%C3%B3rio%20T%C3%A9cnico%20Ecoviagens%20-%20Giulia.pdf) com toda análise de resultados e performance da EcoViagens no período.


Veja a resolução simplificada nessa página. Para acessar o desenvolvimento na íntegra, acesse o Relatório Técnico no link acima. 

## Índice 

- [1. Contexto](https://github.com/giulia-tuffanelli/projeto_ecoviagens?tab=readme-ov-file#1-contexto)
- [2. Ferramentas de análise](https://github.com/giulia-tuffanelli/projeto_ecoviagens?tab=readme-ov-file#2-ferramentas-de-an%C3%A1lise)
- [3. Etapas do projeto](https://github.com/giulia-tuffanelli/projeto_ecoviagens?tab=readme-ov-file#3-etapas-do-projeto)
- [4. Produtos do projeto](https://github.com/giulia-tuffanelli/projeto_ecoviagens?tab=readme-ov-file#4-produtos-do-projeto)
- [5. Principais insights](https://github.com/giulia-tuffanelli/projeto_ecoviagens?tab=readme-ov-file#5-principais-insights)
- [6. Conclusão](https://github.com/giulia-tuffanelli/projeto_ecoviagens?tab=readme-ov-file#6-conclus%C3%A3o)

## 1. Contexto

**A empresa EcoViagens está lançando uma plataforma online voltada à promoção e reserva de experiências de turismo sustentável no Brasil.** O propósito é conectar viajantes a operadores turísticos locais que disponibilizam atividades ecológicas, hospedagens com práticas sustentáveis e roteiros que reduzam o impacto ambiental.

Essa plataforma necessita de um modelo de dados sólido que possibilite gerenciar reservas, informações sobre operadores e atividades, dados dos clientes, além de permitir a análise sobre sustentabilidade e a popularidade das ofertas. Além disso, a empresa precisa definir quais serão os indicadores, métricas e análises a serem regularmente avaliados para embasar a tomada de decisão pelas equipes. **O objetivo principal é conseguir avaliar a saúde do negócio e se a empresa possui um crescimento sustentável no formato atual.** 

Sendo assim, a EcoViagens me contratou para auxiliar em todo o processo desde a **modelagem dos dados da plataforma de reservas, a definição dos KPIs, a elaboração de consultas em SQL para responder as principais perguntas de negócio até a criação de um dashboard para visualização das principais métricas pela diretoria da empresa.**



## 2. Ferramentas de Análise

- Excel
- SQL
- Google BigQuery
- DBDiagram
- Power BI
- Power Point

## 3. Etapas do projeto

Para melhor entendimento da estratégia de solução envolvida nesse projeto, dividi a resolução em cinco partes. A seguir é possível verificar essa divisão e o resumo de cada uma. Para acessar o desenvolvimento completo, acesse o Relatório Técnico [aqui](link para desenvolvimento completo).

### Parte 1: Modelagem de dados da plataforma

Nessa etapa foram descritas as tabelas envolvidas no funcionamento da plataforma, seus atributos e as relações entre elas. 

Defini então que o ecossistema de dados da EcoViagens possui as seguintes entidades e atributos:

- Clientes - tabela com informações dos clientes cadastrados
- Práticas sustentáveis - práticas sustentáveis associadas às experiências ofertadas na plataforma
- Reservas - informações das reservas feitas pelos clientes
- Operadores - informações de cadastro dos operadores que oferecem as experiêncoas
- Avaliações - avaliação das ofertas pelos clientes
- Ofertas (experiências) - detalhes das ofertas presentes na plataforma de reservas. A Ecoviagens trabalha com dois tipos de experiências, sendo atividade ou hospedagem.

Pensando na estrutura da plataforma, a tabela que melhor se encaixa como central é a de ofertas, que irá conter um campo tipo_oferta para descrever o tipo da experiência (atividade ou hospedagem). Isso permite que todas as ofertas sejam avaliadas juntas quando necessário. Além disso, a tabela de reservas conecta clientes, ofertas, data da reserva e data da experiência; e a tabela de avaliação conecta clientes e ofertas com notas e comentários sobre aquela experiência.

O relacionamento entre tabelas fica então da seguinte forma:

- Clientes (1):(N) Reservas – Um cliente pode fazer várias reservas
- Oferta (1):(N) Reservas – Uma oferta pode ter várias reservas por clientes diferentes
- Clientes (1):(N) Avaliações – Um cliente pode fazer várias avaliações
- Oferta (1):(N) Avaliações – Uma oferta pode ter várias avaliações por clientes diferentes
- Oferta (N):(1) Operador – Várias ofertas podem estar vinculadas a um único operador 

Um ponto de atenção nesse processo é que uma única oferta pode ter várias práticas sustentáveis e a mesma prática pode estar em várias ofertas, esse é um relacionamento N:N (muitos para muitos) que costuma ser problemático em bancos de dados relacionais. Para corrigir essa relação, criei uma tabela intermediária chamada de oferta_pratica para evitar redundância, dados duplicados e melhorar a eficiência de consultas. Assim ambas as entidades tem relação de 1:N com essa tabela intermediária.

Após essa adaptação, criei o diagrama de relações entre entidades e detalhei o tipo de cada atributo utilizando a plataforma DBDiagram. Acesse o diagrama completo [aqui](https://dbdiagram.io/d/68b5fa97777b52b76c8bfe93).

O modelo de dados definido possui relacionamento bem definido, estrutura normalizada adequada à bancos de dados relacionais e facilita o acesso aos dados necessários para inteligência de negócio.

<img width="570" height="380" alt="image" src="https://github.com/user-attachments/assets/e9976ce1-834a-446e-a3eb-1b4645762ac6" />

### Parte 2: Definição dos KPIs de negócio

O objetivo principal da Ecoviagens é ser uma empresa de excelência em turismo sustentável no Brasil. Ela deve ser capaz de proporcionar a melhor experiência possível para o usuário, desenvolver os operadores responsáveis pelas experiências ofertadas na plataforma, possuir rentabilidade financeira e responsabilidade ambiental, social e econômica. Sendo a sustentabilidade o cerne de todo o negócio.

Nessa etapa apliquei a metodologia SMART para definir os principais indicadores de desempenho levando em consideração todo o propósito da empresa. As métricas foram  agrupadas em pilares fundamentais para o crescimento sustentável do negócio aliado a esse propósito. Sendo eles a saúde do negócio, qualidade dos serviços e satisfação dos clientes, performance dos operadores parceiros e sustentabilidade.

No infográfico abaixo, que adaptei para esse projeto, é possível verificar os pilares e as métricas associadas a cada um.


<img width="395" height="843" alt="image" src="https://github.com/user-attachments/assets/0fa13712-edc1-43d8-9f82-a4b34e70c9a8" />



Na tabela abaixo, detalho o objetivo de cada KPI e como deverá ser calculado.


| KPI            |Objetivo      |  Cálculo |
| ------------- | ------------- |----------|
| Receita mensal | Avaliar performance financeira por período | Soma do preço da experiência multiplicado pela quantidade de pessoas das reservas confirmadas por mês |
| Número de reservas confirmadas  | Medir o total de vendas e aderência dos clientes  | Contar registros de reservas com status ‘Confirmada’ no período avaliado da tabela reservas |
| Número de novos clientes  | Acompanhar o crescimento da base de usuários  | Contar os novos ‘id_cliente’ registrados no período através da data_cadastro
| Avaliação média geral  | Medir a qualidade dos serviços oferecidos  | Fazer média da nota na tabela Avaliação para todas as ofertas com avaliação
| Taxa de avaliação pós experiência | Medir engajamento dos clientes após a reserva concluída  | Número de avaliações feitas dividido pelo número total de reservas concluídas
| Taxa de Recompra | Medir a fidelização dos clientes  | Proporção de clientes com mais de uma reserva no período em relação às reservas totais
| Taxa de Cancelamento	| Identiﬁcar problemas operacionais e medir insatisfação do cliente	| Dividir o número de reservas canceladas pelo total de reservas feitas
| Avaliação média por operador |	Avaliar o desempenho individual dos prestadores de serviço | Média das notas das avaliações agrupadas pelo ‘id_operador’
| Efetivação de reservas por operador	| Identificar qual eficiência de efetivação de uma reserva pelo operador | Número de reservas concluídas divididas pelo total de reservas (por operador e por oferta)
| Índice de sustentabilidade |	Avaliar o compromisso com a sustentabilidade ambiental |	Média de práticas associadas por oferta (contagem em Oferta_Pratica)
| Top 5 práticas sustentáveis mais aplicadas | Identifica as práticas sustentáveis mais usadas destacando tendências no mercado	| Contagem de cada prática associada às ofertas em Oferta_Pratica
| Top 5 práticas melhor avaliadas	| Avaliar quais práticas tem maior impacto positivo na satisfação dos usuários |	Média das notas das ofertas associadas a cada prática

### Parte 3: Desenvolvimento de consultas em SQL

Nessa etapa desenvolvi queries em SQL que possibilitem a análise dos KPIs definidos na etapa anterior e deem embasamento para responder às principais perguntas do negócio, também fiz uma análise de cada resultado obtido. 

O data Warehouse que escolhi foi o Google BigQuery, por permitir armazenar e analisar grandes volumes de dados de forma rápida e sem necessidade de servidor. Também é compatível com as principais ferramentas de business intelligence, como o Power BI, tem flexibilidade de preços e baixo custo, que são fatores importantes para a EcoViagens nesse momento.

Durante análise dos dados da plataforma, além da definição dos KPIs, verifiquei que outros insights podem ser obtidos para gerar valor ao negócio. Por isso, as consultas que criei também englobam análises importantes como: 

- Variação percentual da receita em relação ao mês anterior – Importante para comparar a variação entre os meses e sazonalidade de reservas.
- Impacto financeiro do cancelamento de reservas – O quanto a empresa está deixando de ganhar com desistência de reservas e propor ações para reduzir esse impacto.
- Ticket médio gasto por pessoa – O quanto os clientes estão gastando em média por pessoa com as experiências, importante para ajudar a definir o perfil de clientes.
- Lista de clientes que gastaram mais que o ticket médio – Clientes que gastam além da média podem ser identificados e ter direcionamento para ofertas premium que gerem mais receita para a empresa.
- Distribuição de reservas por tipo de oferta (atividade ou hospedagem) – Entender as experiências mais populares para aumentar o catálogo e, consequentemente, gerar mais receita.
- Avaliação média por oferta: Verificar desempenho percebido das ofertas e direcionar recursos para melhoria contínua das experiências ofertadas na plataforma
- Tempo médio entre reservas dos clientes fidelizados: Entender o perfil de reservas de clientes fieis e oferecer produtos de acordo com a necessidade desse perfil.

No [Relatório Técnico](link) explico passo a passo do desenvolvimento de cada query e descrevo minha análise dos resultados. Os Scripts em SQL podem ser verificados [aqui](https://github.com/giulia-tuffanelli/projeto_ecoviagens/tree/5bd6b0eb5d92bdb42a6e09d51370694fe0de4e12/Scripts%20SQL).

### Parte 4: Construção do dashboard em Power BI

Construí um dashboard contendo dois painéis principais para análise de negócio, um direcionado para a Desempenho Financeiro e Fidelização de Clientes e outro englobando a Qualidade de Serviços e Sustentabilidade.  

Acesse o dashboard completo [aqui](https://app.fabric.microsoft.com/view?r=eyJrIjoiZGNiNDY1MmMtMzg0MS00MzI3LWE4ZDgtYjI0OWYyZTc2MGZjIiwidCI6ImFjMWNhNjc0LWNjMmQtNDIzMS05ZjM4LTQ5ZDk4OWMzMmY3YSJ9). 

Escolhi o Power BI para fazer o dashboard pela integração com os sistemas da Microsoft, ideal para criar um ecossistema integrado de dados na EcoViagens, pela conexão direta com diversas fontes de dados, atualização automática e por possuir uma interface de visualização de dados intuitiva e interativa, que facilita a análise pelo usuário. 

Fiz a importação dos dados através da integração direta com o Google BigQuery, acessando as tabelas nativas criadas para esse projeto. A etapa de validação dos dados é simples, mas muito importante para preceder qualquer análise. Fiz o processo de ETL dos dados com o power query após conexão com o BigQuery, assegurando que todos os registros foram devidamente carregados, que não houve alteração dos valores originais e que o formato e tipo dos dados está correto. Essa etapa garante confiabilidade da análise, precisão dos dados que irão embasar as decisões de negócio e reduz retrabalho posterior.

Com a modelagem já definida no início do projeto, apliquei os mesmos relacionamentos entre tabelas, gerenciando as relações entre elas. Como boa prática, criei uma tabela calendário com a primeira e última data de reserva (mais recente) que servirá de base para as funções DAX de inteligência temporal e criação de filtros com agrupamento de períodos (mês/trimestre/semestre). Essa ação também otimiza o desempenho do modelo. Adicionalmente, criei uma tabela que concentrará todas as medidas criadas nesse relatório para uma melhor organização.

A construção das principais medidas usando DAX está descrita passo a passo no [Relatório Técnico completo em PDF]()

<img width="665" height="626" alt="image" src="https://github.com/user-attachments/assets/8b52fbf0-6ab6-480e-b023-902a1e87e947" />

<img width="690" height="468" alt="image" src="https://github.com/user-attachments/assets/f03328f9-3649-4a91-a7f0-e34546ccfa36" />

## 4. Produtos do projeto

- [Modelo de Dados](https://github.com/giulia-tuffanelli/projeto_ecoviagens/blob/402f437456be008799bc341d5f2e4dfa26474330/Diagrama%20de%20relacionamento.png)
- [Scripts em SQL](https://github.com/giulia-tuffanelli/projeto_ecoviagens/tree/5bd6b0eb5d92bdb42a6e09d51370694fe0de4e12/Scripts%20SQL)
- [Dashboard em Power BI](https://app.fabric.microsoft.com/view?r=eyJrIjoiZGNiNDY1MmMtMzg0MS00MzI3LWE4ZDgtYjI0OWYyZTc2MGZjIiwidCI6ImFjMWNhNjc0LWNjMmQtNDIzMS05ZjM4LTQ5ZDk4OWMzMmY3YSJ9)
- [Apresentação Corporativa do projeto](https://github.com/giulia-tuffanelli/projeto_ecoviagens/blob/1a16a46ad4ea28e50591343eab1bf998799668bc/Apresenta%C3%A7%C3%A3o%20An%C3%A1lise%20Ecoviagens%20-%20Giulia.pdf)
- [Relatório Técnico completo em PDF](https://github.com/giulia-tuffanelli/projeto_ecoviagens/blob/402f437456be008799bc341d5f2e4dfa26474330/Relat%C3%B3rio%20T%C3%A9cnico%20Ecoviagens%20-%20Giulia.pdf) com toda análise de resultados e performance da EcoViagens no período.

## 5. Principais Insights

A receita mensal média é de R$ 51 mil, com variação entre R$ 42 mil a R$ 62 mil. **Dos 11 meses completos avaliados, 6 apresentaram queda na receita em relação ao mês anterior. Não houve uma tendência consistente de aumento nesse período**, o que indica que não há segurança, previsibilidade de receita e crescimento sustentável a termo. 

O ticket médio gasto por pessoa na reserva foi de R$ 276,88. **Já o ticket médio por cliente fidelizado é de 277,02 e cliente único é de 276,77, ou seja, não houve ganho expressivo em fidelizar os clientes. Esse número reforça que o cliente também não tem incentivo financeiro em ser fidelizado.** 

**A taxa de fidelização de clientes é baixa, de apenas 23%**. Ainda há espaço para incentivo da recompra por clientes únicos da plataforma e programas especiais de benefícios para clientes recorrentes, já que a EcoViagens oferece experiências diferenciadas da grande maioria do mercado e tem um grande potencial no segmento de turismo sustentável.

**A média de avaliação da plataforma é 2.99, sendo a nota máxima 5**. A categoria hospedagem possui avaliações mais estáveis e melhores médias, com alguns operadores com nota média acima de 3.5. Já as atividades tem uma alta dispersão de notas médias, que pode indicar falta de padronização das experiências dessa categoria. A melhora da avaliação também pode aumentar a recompra e funcionar como um incentivo para reserva na plataforma e não em concorrentes.

**A taxa de cancelamento de reservas no período foi de 10,31% com o impacto total de R$ 145 mil no período, que equivale a 22% da receita total acumulada.** O ano de 2025 apresentou uma queda gradual nos valores de cancelamento e teve uma redução geral de 17% em relação ao ano anterior, que é um ponto positivo. Entretanto, direcionar ações para aumentar a retenção de reservas irá impactar diretamente no aumento e estabilidade da receita.

**O Índice de Sustentabilidade é de 66,83%, que indica que a maior parte das ofertas da plataforma possuem ao menos uma prática sustentável associada.** Esse valor reforça o propósito da empresa e entrega aos clientes opções alinhadas com o compromisso de redução do impacto ambiental, mas mostra que ainda há espaço para crescimento.

## 6. Conclusão

É necessário ter estabilidade de receita e uma base sólida de clientes para ter um modelo de negócios que tenha um crescimento sustentável a longo prazo. Apesar do ticket médio estável, o modelo atual adotado não é capaz de suportar o crescimento esperado. A empresa deve ser capaz de antecipar períodos de sazonalidade e de instabilidade da receita através da estabilização da entrada de capital. Para melhorar a estabilidade de receita nesse cenário sazonal do turismo, a empresa deve mapear os períodos de baixa demanda da plataforma e propor ações que possam mitigar essas perdas. 

Algumas medidas a serem adotadas podem ser campanhas de antecipação para períodos de baixa demanda e ofertas exclusivas que utilizem a sazonalidade como característica, como experiências de inverno por exemplo. Também há grande oportunidade de ganho financeiro na redução do cancelamento, atuando diretamente na retenção das reservas. 

Visando o aumento do ticket médio e fidelização dos clientes, ambos com impacto positivo em receita, é necessário o aumento do valor percebido da plataforma e das experiências pelos clientes. 

Algumas estratégias podem ser: Criação de pacotes mistos (hospedagem + atividade) com benefício agregado; Venda de itens complementares ao pacote como transporte e alimentação; Programa de recompensas para que o cliente tenha vantagem financeira na recompra, além de se sentir reconhecido e valorizado pela empresa; Automatização de campanhas pós venda via mensagem, que possui baixo custo de implantação e incentiva o pensamento do cliente na empresa; Avaliação pós experiência com feedback estruturado, para entender e corrigir as razões de não fidelização, além de validar a experiência do cliente, também cria confiança com a plataforma.

Ainda sobre estratégias de fidelização, é importante que a empresa entenda o perfil dos clientes que buscam ofertas na plataforma. Esse estudo pode ajudar a segmentar os clientes para indicar ofertas com benefícios exclusivos e nível de serviço adequado ao seu perfil, o que pode aumentar a atratividade e justificar a recompra. Além disso, a EcoViagens pode desenhar categorias premium com experiências personalizadas, atraindo clientes diferenciados e elevando o valor percebido da plataforma.  

Sabemos que a performance atual não está alinhada com o potencial do negócio de atingir valorização do serviço e fidelização de clientes, mas **os dados apontam caminhos claros e ações de melhoria que são viáveis para implantação a curto e médio prazo. Portanto, há uma possibilidade real de transformação de um cenário de baixa performance para um crescimento estruturado e consolidação no setor de turismo sustentável como uma marca de referência.**
