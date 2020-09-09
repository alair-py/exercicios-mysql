-- CRIANDO BANCO GUIA TURISTICO --
CREATE DATABASE IF NOT EXISTS guia_turistico
CHARACTER SET = utf8
COLLATE = utf8_general_ci;

-- SELECIONANDO BANCO --
USE guia_turistico;

-- CRIANDO TABELA PAÍSES --
CREATE TABLE IF NOT EXISTS paises (
	id int(3) NOT NULL primary key auto_increment,
	nome varchar(30) NOT NULL,
    continente ENUM('ÁSIA', 'AMÉRICA', 'OCEANIA', 'ÁFRICA', 'EUROPA', 'ANTÁRTIDA'),
    capital varchar(30) NOT NULL,
    codigo varchar(3) NOT NULL DEFAULT ''
);


-- CRIANDO TABELA ESTADOS --
CREATE TABLE IF NOT EXISTS estados (
	id int(3) NOT NULL primary key auto_increment,
    nome varchar(30) NOT NULL,
    sigla varchar(5) NOT NULL
);


-- CRIANDO TABELA CIDADES -- 
CREATE TABLE IF NOT EXISTS cidades (
	id int(3) NOT NULL primary key auto_increment,
    nome varchar(30) NOT NULL,
    populacao int(10) NOT NULL DEFAULT 0
);


-- CRIANDO TABELA PONTOS TURISTICOS --
CREATE TABLE IF NOT EXISTS pontos_tur (
	id int(3) NOT NULL primary key auto_increment,
    nome varchar(30) NOT NULL,
    tipo ENUM('Atrativo', 'Serviço', 'Equipamento', 'Infraestrutura', 'Instituição', 'Organização'),
    servicos varchar(30)
);

-- CRIANDO TABELA LINGUAGEM DE PAÍS --
CREATE TABLE IF NOT EXISTS linguagem_pais (
	id int(3) NOT NULL primary key auto_increment,
    cod_pais int(3),
    linguagem varchar(30) NOT NULL DEFAULT '',
    oficial ENUM('SIM', 'NÃO') NOT NULL DEFAULT 'NÃO',
    FOREIGN KEY (cod_pais) REFERENCES paises(id)
);


-- INSERINDO VALORES --
INSERT INTO paises (nome, continente, capital, codigo)
VALUES ('BRASIL', 'AMÉRICA', 'BRASILIA', 'BRA'),
('CHINA', 'ÁSIA', 'PEQUIM', 'CHI'),
('JAPÃO', 'ÁSIA', 'TÓQUIO', 'JAP');

INSERT INTO estados (nome, sigla)
VALUES ('MARANHÃO', 'MA'),
('SÃO PAULO', 'sp'),
('SANTA CATARINA', 'SC'),
('RIO DE JANEIRO', 'RJ');

INSERT INTO cidades (nome, populacao)
VALUES ('SOROCABA', 700000),
('DÉLI', 26000000),
('XANGAI', 22000000),
('TÓQUIO', 38000000);

INSERT INTO pontos_tur (nome, tipo)
VALUES ('QUINZINHO DE BARROS', 'Instituição'),
('PARQUE EST JALAPÃO', 'Atrativo'),
('TORRE EIFFEL', 'Atrativo'),
('FOGO DE CHÃO', 'Serviço');


-- INSERINDO NOVO CAMPO EM PONTOS TURISTICOS --
ALTER TABLE pontos_tur ADD COLUMN gps GEOMETRY;


