-- CRIANDO BANCO PET SHOP --
CREATE DATABASE IF NOT EXISTS pet_shop
CHARACTER SET = utf8
COLLATE = utf8_general_ci;

-- SELECIONANDO BANCO --
USE pet_shop;

-- CRIANDO TABELA PET --
CREATE TABLE IF NOT EXISTS pet (
	id int(3) primary key auto_increment not null,
    nome varchar(25) not null,
    raca varchar(30) not null
);

-- CRIANDO TABELA DONO --
CREATE TABLE IF NOT EXISTS dono (
	cod int(3) primary key auto_increment not null,
    nome varchar(50) not null,
    pet_id int(3) not null,
    foreign key (pet_id) references pet(id)
);

-- CRIANDO TABELA CUIDADOR --
CREATE TABLE IF NOT EXISTS cuidador (
	codigo int(3) primary key auto_increment not null,
    nome varchar(50) not null,
    telefone int(10) not null
);

-- CRIANDO TABELA HOSPEDAGEM --
CREATE TABLE IF NOT EXISTS hospedagem (
	num int(3) primary key auto_increment not null,
    pet_id int(3) not null,
    cuidador_codigo int(3) not null,
    foreign key (pet_id) references pet(id),
    foreign key (cuidador_codigo) references cuidador(codigo)
);


-- INSERINDO VALORES --
INSERT INTO pet (nome, raca)
VALUES ('BELINHA', 'VIRA-LATA'), ('MEG', 'DALMATA'), ('KATARA', 'AKITA');

INSERT INTO dono (nome, pet_id)
VALUES ('ALAIR', 1), ('JUNIOR', 2), ('LUCAS', 3);

INSERT INTO cuidador (nome, telefone)
VALUES ('ANA', 99999999), ('PEDRO', 88888888), ('ALINE', 77777777);

INSERT INTO hospedagem (pet_id, cuidador_codigo)
VALUES (1, 3), (2, 1), (3, 2);


-- RETORNANDO VALORES BASEADO NO FILTRO --
SELECT hospedagem.num AS 'REGISTRO', pet.nome AS 'PET', dono.nome AS 'PROPRIETÁRTIO',
cuidador.nome AS 'CUIDADOR' FROM hospedagem INNER JOIN pet ON hospedagem.pet_id = pet.id
INNER JOIN dono ON dono.pet_id = pet.id INNER JOIN cuidador 
ON hospedagem.cuidador_codigo = cuidador.codigo ORDER BY pet.nome;





