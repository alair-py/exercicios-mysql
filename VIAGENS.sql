-- CRIANDO BANCO VIAGENS --
CREATE DATABASE IF NOT EXISTS viagens 
CHARSET = utf8
COLLATE = utf8_general_ci;

-- SELECIONANDO BANCO --
USE viagens;

-- CRIANDO TABELAS --
CREATE TABLE IF NOT EXISTS capitao (
	cpf bigint(11) primary key not null,
    nome varchar(25) not null,
    endereco varchar(35) not null,
    numero int(5) not null,
    celular int(10) not null
);


CREATE TABLE IF NOT EXISTS escuna (
	numero int(5) primary key auto_increment not null,
    nome varchar(30) not null,
    capitao_cpf bigint(11) not null,
    foreign key (capitao_cpf) references capitao(cpf)
);

CREATE TABLE IF NOT EXISTS destino (
	id int(3) primary key auto_increment not null,
    nome varchar(35) not null
);


CREATE TABLE IF NOT EXISTS passeio (
	id int(5) primary key auto_increment not null,
    dia Date not null,
    hr_saida time not null,
    hr_chegada time not null,
    escuna_numero int(5) not null,
    destino_id int(3) not null,
    foreign key (escuna_numero) references escuna(numero),
    foreign key (destino_id) references destino(id)
);



-- INSERINDO VALORES --
INSERT INTO capitao (cpf, nome, endereco, numero, celular)
VALUES
(1234567891, "Jack", "Rua Robalo", 100, 998976554),
(9876543219, "Ian", "Rua Robalo", 55, 988772200),
(7418529631, "Paula", "Rua Marinha", 89, 977885512),
(1472583697, "Miguel", "Rua do Mar", 250, 999226655),
(3692581473, "Adriano", "Rua das Ondas", 1200, 994495885);

INSERT INTO escuna (numero, nome, capitao_cpf)
VALUES
(12345, "Black Flag", 1234567891),
(12346, "Caveira", 9876543219),
(12347, "Brazuka", 1472583697),
(12348, "Rosa Brilhante 1", 7418529631),
(12349, "Tubarão Ocean", 3692581473),
(12350, "Rosa Brilhante 2", 7418529631);


INSERT INTO destino (nome) 
VALUES 
("Ilha Dourada"),
("Ilha D'areia fina"),
("Ilha Encantada"),
("Ilhinha"),
("Ilha dos Ventos"),
("Ilha Torta"),
("Ilha dos Sonhos"),
("Ilha do Sono");


INSERT INTO passeio (id, dia, hr_saida, hr_chegada, escuna_numero, destino_id)
VALUES
(0, "2018/01/02", "08:00","14:00", 12345, 1),
(0, "2018/01/02", "07:00", "17:00", 12346, 8),
(0, "2018/01/02", "08:00", "14:00", 12350, 3),
(0, "2018/01/03", "06:00", "12:00", 12347, 2),
(0, "2018/01/03", "07:00", "13:00", 12348, 4),
(0, "2018/01/03", "08:00", "14:00", 12349, 6),
(0, "2018/01/03", "09:00", "15:00", 12345, 5),
(0, "2018/01/04", "07:00", "16:00", 12347, 1),
(0, "2018/01/04", "07:00", "17:00", 12345, 3),
(0, "2018/01/04", "09:00", "13:00", 12349, 7),
(0, "2018/01/05", "10:00", "18:00", 12350, 8),
(0, "2018/01/05", "09:00", "13:00", 12347, 7);


-- CRIANDO VIEW PARA CONSULTA RÁPIDA --
CREATE VIEW v_consulta AS 
SELECT escuna.nome AS "ESCUNA", destino.nome AS "ILHA", hr_saida AS "SAIDA",
hr_chegada AS "CHEGADA", passeio.dia AS "DATA"
FROM passeio INNER JOIN escuna, destino
WHERE passeio.escuna_numero = escuna.numero 
AND passeio.destino_Id = destino.id ORDER BY passeio.dia;

SELECT * FROM v_consulta;


-- COMMIT E BACKUPS PARA PREVENÇÃO DE ERROS --
SET AUTOCOMMIT = 0;

SAVEPOINT backup1;

-- CRIANDO ERRO PARA TESTE --
UPDATE destino
SET nome = 'Pequena Ilha do Mar';
SELECT * FROM destino;

-- UTILIZANDO BACKUP CRIADO --
ROLLBACK TO SAVEPOINT backup1;
SELECT * FROM destino;

-- GRAVAR ALTERAÇÕES FEITAS --
COMMIT;

-- NOVO BACKUP (PRIMEIRO É APAGADO COM COMMIT) --
SAVEPOINT backup2;

-- NOVA TABELA VENDAS --
CREATE TABLE IF NOT EXISTS vendas (
	numero int(11) primary key auto_increment not null,
    destino_id int(11) not null,
    embarque date,
    quant int(11) not null,
    foreign key (destino_id) references destino(id)
);


-- ADICIONANDO CAMPO VALOR EM TABLE DESTINO --
ALTER TABLE destino ADD COLUMN valor decimal(5,2);

-- INSERINDO PREÇOS PARA DESTINOS --
INSERT destino (id, nome, valor)
VALUES
(0, "Ilha Dourada", 100.00),
(0, "Ilha D'areia fina", 120.00),
(0, "Ilha Encantada", 80.00),
(0, "Ilha dos Ventos", 90.00),
(0, "Pequena Ilha do Mar", 100.00),
(0, "Ilha Torta", 150.00),
(0, "Ilha dos Sonhos", 120.00),
(0, "Ilha do Sono", 180.00);

-- INSERINDO ITENS DE VENDAS PARA TESTE --
INSERT INTO vendas (numero, destino_id, embarque, quant)
VALUES
(1, 1, 20200903, 3), (2, 7, 20200903, 2), (3, 5, 20200903, 1);



-- FUNÇÃO PARA CALCULAR 30% DE DESCONTO --
CREATE FUNCTION fn_desconto (x decimal(5,2), y int)
RETURNS decimal(5,2)
RETURN ((x * y) * 0.7);

-- PROCEDIMENTO PARA RETORNAR VALORES --
CREATE PROCEDURE proc_desconto (var_numvendas int)
SELECT (fn_desconto(destino.valor, vendas.quant)) AS 'VALOR C/ DESCONTO',
destino.nome AS 'DESTINO', vendas.quant AS 'PASSAGENS', vendas.embarque
FROM vendas INNER JOIN destino ON vendas.destino_id = destino.id
WHERE numero = var_numvendas;


-- CHAMANDO PROCEDIMENTO --
CALL proc_desconto(1);
CALL proc_desconto(2);
CALL proc_desconto(3);
