-- CRIANDO BANCO BIBLIOTECA --
CREATE DATABASE IF NOT EXISTS biblioteca
CHARSET = utf8
COLLATE = utf8_general_ci;

-- SELECIONANDO BANCO --
USE biblioteca;

-- CRIANDO TABELA PARA AUTOR --
CREATE TABLE IF NOT EXISTS machadoDeAssis (
	id int(5) primary key auto_increment NOT NULL,
    livro varchar(30) NOT NULL,
    ano int(4) NOT NULL,
    texto varchar(300) NOT NULL
);

INSERT INTO machadoDeAssis (livro, ano, texto)
VALUES ("A cartomante", 1884, "Realmente, era graciosa e viva nos gestos,
olhos cálidos, boca fina e interrogativa."),
("A causa secreta", 1885, "Insensivelmente estendeu
a mão e apertou o pulso ao marido, risonha e
agradecida, como se acabasse de descobrir-lhe o
coração."),
("Falenas", 1870, "Rosa branca do céu, perfume,
alento, vida. Palpita o coração já crente, já
desperto; Povoa-se num dia o que era agro deserto;
"),
("Iaia Garcia", 1878, "A meu marido. Iaiá beijou
com ardor a singela dedicatória, como beijaria a
madrasta se ela lhe aparecesse naquele instante."),
("Mariana", 1871, "Mariana foi com ele até à porta,
interrogando baixo e procurando-lhe no rosto a
verdade que a boca não queria dizer."),
("Quincas Borbas", 1891, "Era daquela casta de
mulheres que o tempo, como um escultor vagaroso,
não acaba logo, e vai polindo ao passar dos longos
dias.");

-- ADICIONANDO CAMPO FULLTEXT PARA BUSCAS POR TRECHOS --
ALTER TABLE machadoDeAssis ADD FULLTEXT (texto);

-- TESTANDO VALORES RETORNADOS POR FULLTEXT --
SELECT COUNT(*) AS 'REPETIÇÕES' FROM machadoDeAssis WHERE MATCH(texto) AGAINST ('marido');

SELECT DISTINCT livro AS 'OBRA', ano AS 'ANO' from machadoDeAssis
WHERE MATCH(texto) AGAINST ('coração');


