-- CRIANDO BANCO QUIMICOS --
CREATE DATABASE IF NOT EXISTS quimicos
CHARSET = utf8
COLLATE = utf8_general_ci;

-- SELECIONANDO BANCO --
USE quimicos;

-- CRIANDO TABELA DE REAGENTES --
CREATE TABLE IF NOT EXISTS reagentes (
	id int(3) primary key auto_increment not null,
    nome varchar(15) not null,
    reagente1 decimal(4,2) not null,
    reagente2 decimal(4,2) not null,
    reagente3 decimal(4,2) not null
);

-- INSERINDO VALORES --
INSERT INTO reagentes (nome, reagente1, reagente2, reagente3)
VALUES
('Bio_1', 2.51, 4.33, 11.81),
('Bio_2', 2.51, 3.99, 8.55),
('Bio_3', 2.51, 0.85, 5.05);


-- CRIAR FUNÇÃO PARA CALCULAR MISTURAS (ONDE O PRODUTO DE REAGENTE 1 E 2 NÃO PODEM ULTRAPASSAR O VALOR DO REAGENTE 3 --
SET GLOBAL log_bin_trust_function_creators = 1;

CREATE FUNCTION fn_calculo (x decimal(4,2), y decimal(4,2))
RETURNS decimal(4,2)
RETURN x * y;


-- FAZENDO CALCULO REQUISITADO --
SELECT nome, fn_calculo (reagente1, reagente2) AS 'VALOR DA MISTURA',
reagente3 AS 'VALOR MÁXIMO' from reagentes;

-- REPARAR LIMITES EXCEDIDOS --
SET AUTOCOMMIT = 0;
SAVEPOINT pesquisa1;

UPDATE reagentes
SET reagente1 = 1.10 WHERE reagente1;

-- REFAZENDO CALCULO REQUISITADO --
SELECT nome, fn_calculo (reagente1, reagente2) AS 'VALOR DA MISTURA',
reagente3 AS 'VALOR MÁXIMO' from reagentes;

-- PARA RETORNAR VALORES INICIAIS NO BACKUP--
ROLLBACK TO SAVEPOINT pesquisa1;


