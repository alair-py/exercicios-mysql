-- CRIAR BANCO --
CREATE DATABASE IF NOT EXISTS supergames
CHARACTER SET = utf8
COLLATE = utf8_general_ci;

-- SELECIONAR BANCO --
USE supergames;

-- CRIAR TABELA LOCALIZACAO --
CREATE TABLE IF NOT EXISTS localizacao (
	id INT(3) auto_increment primary key,
    secao VARCHAR(50) not null,
    plateleira VARCHAR(50) not null
);

-- CRIAR TABELA JOGO --
CREATE TABLE IF NOT EXISTS jogo (
	cod INT(3) auto_increment primary key,
    nome VARCHAR(50) not null,
    valor DECIMAL(6,2) not null,
    localizacao_id INT(3) not null,
    FOREIGN KEY (localizacao_id) REFERENCES localizacao(id) 
);

-- INSERIR VALORES --
INSERT INTO localizacao (secao, plateleira)
VALUES ('GUERRA', '001'), ('GUERRA', '002'), ('AVENTURA', '100'), ('AVENTURA', '101'), ('RPG', '150'), ('RPG', '151');

INSERT INTO jogo (nome, valor, localizacao_id)
VALUES ('COD 3', 125, 1), ('BF', 150, 1), ('GOW 4', 200, 3), ('SLY', 99, 3), ('FF X', 205, 5);
 
 -- RETORNAR VALORES FILTRADOS --
SELECT jogo.nome AS 'NOME', jogo.valor AS 'PREÇO', localizacao.secao AS 'SEÇÃO', localizacao.plateleira AS 'PLATELEIRA'
FROM jogo LEFT JOIN localizacao ON jogo.cod = localizacao.id;

-- POR TIPO --
SELECT jogo.nome AS 'NOME', localizacao.secao AS 'SEÇÃO' FROM jogo INNER JOIN localizacao 
ON jogo.cod = localizacao.id WHERE secao = 'GUERRA';

-- POR ORDEM ALFABÉTICA --
SELECT jogo.nome AS 'NOME', localizacao.secao AS 'SEÇÃO', jogo.valor AS 'VALOR' FROM jogo INNER JOIN localizacao ON
localizacao.id = jogo.localizacao_id order by jogo.nome asc;

-- POR VALOR --
SELECT * FROM jogo INNER JOIN localizacao ON jogo.cod = localizacao.id WHERE jogo.valor <= 150;

-- POR QUANTIDADE EM ESTOQUE --
SELECT COUNT(*) FROM jogo;

-- VALOR MAIS ALTO --
SELECT nome, MAX(valor) AS 'MAIOR VALOR' FROM jogo WHERE valor = (SELECT MAX(valor) FROM jogo);

-- VALOR MAIS BAIXO --
SELECT nome, MIN(valor) AS 'MENOR VALOR' FROM jogo WHERE valor = (SELECT MIN(valor) FROM jogo);

-- VALOR MÉDIO DOS PRODUTOS --
SELECT AVG(valor) AS 'VALOR MÉDIO' FROM jogo INNER JOIN localizacao ON jogo.cod = localizacao.id;

-- TOTAL DE TODOS VALORES --
SELECT SUM(valor) AS 'VALOR TOTAL' FROM jogo;

-- TODOS PRODUTOS E LOCALIZACAO --
SELECT * FROM jogo, localizacao WHERE jogo.cod = localizacao.id;

-- INSERINDO NOVO ITEM --
INSERT INTO localizacao (secao, plateleira)
VALUES ('CORRIDA', '200');

INSERT INTO jogo (nome, valor, localizacao_id)
VALUES ('SUPER DRIVE', 250, 7), ('NEO', 100, 1), ('MAX JOE', 120, 3), ('N. NEW', 99, 5);

-- ATUALIZANDO PREÇO DE JOGO ESPECIFICO --
UPDATE jogo SET valor = valor*0.5 WHERE jogo.nome = 'BF';

-- CRIA TABELA DE PROMOÇÃO --
CREATE TABLE IF NOT EXISTS promocao (
	promo INT(3) auto_increment primary key,
    cod_jogo INT(3) not null,
    foreign key (cod_jogo) references jogo(cod)
);

-- INSERE ITENS PARA PROMOÇÃO BASEADO NO CODIGO --
INSERT INTO promocao (cod_jogo)
VALUES (1), (2);

-- RETORNA ITENS EM PROMOÇÃO --
SELECT jogo.nome AS 'NOME', jogo.valor AS 'VALOR', localizacao.secao AS 'SEÇÃO' 
FROM jogo RIGHT JOIN localizacao ON jogo.cod = localizacao.id
WHERE jogo.cod IN (SELECT cod_jogo FROM promocao);

-- E ITENS FORA DE PROMOÇÃO --
SELECT jogo.nome AS 'NOME', jogo.valor AS 'VALOR' 
FROM jogo WHERE jogo.cod NOT IN (SELECT cod_jogo FROM promocao);
