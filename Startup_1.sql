-- Introdução ao Armazenamento e Análise de Dados (IAAD) - BSI/UFRPE
-- Script do Banco de Dados Empresa 
-- O comando 'create database' é semelhante ao comando 'create schema'

begin;
--
CREATE SCHEMA startupfernandosilva;

USE startupfernandosilva;

-- Criação da tabela Startup
CREATE TABLE Startup(
	id_startup INT NOT NULL AUTO_INCREMENT,
    nome_startup VARCHAR(100),
    PRIMARY KEY(id_startup),
	cidade_sede VARCHAR (50));

-- Criação da tabela linguagem_programacao
CREATE TABLE Linguagem_Programacao(
	id_linguagem INT NOT NULL AUTO_INCREMENT,
    nome_linguagem VARCHAR(20),
	ano_lançamento VARCHAR (15),
	PRIMARY KEY (id_linguagem),
	UNIQUE(nome_linguagem));
    
-- Criando a tabela Programador
CREATE TABLE Programador(
	id_programador INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome_programador VARCHAR(50),
    genero CHAR(1),
    data_nascimento DATE NOT NULL,
    email VARCHAR(60) NOT NULL,
	UNIQUE(email),
    id_startup INT,
    CONSTRAINT fk_id_startup FOREIGN KEY (id_startup)
    REFERENCES Startup(id_startup)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
    CREATE TABLE Programador_Linguagem(
	id_programador INT,
	id_linguagem INT);

-- INSERTS
INSERT INTO Startup (nome_startup, cidade_sede) VALUES
	('Tech4Toy','Porto Alegre'),
	('Smart123','Belo Horizonte'),
	('knowledgeUp','Rio de Janeiro'),
	('BSI Next Level','Recife'),
	('QualiHealth','São Paulo'),
	('ProEdu','Florianopolis');	

INSERT INTO Linguagem_Programacao (nome_linguagem, ano_lançamento) VALUES
	('Python', '1991'),
    ('PHP', '1995'),
    ('Java', '1995'),
    ('C', '1972'),
	('JavaScript', '1995'),
	('Dart', '2011');	
    
INSERT INTO Programador (nome_programador, genero, data_nascimento, email) values
	('João Pedro','M', '1993-06-23', 'joaop@mail.com'),
	('Paula Silva','F', '1986-01-10', 'paulas@mail.com'),
	('Renata Vieira','F', '1991-07-05', 'renatav@mail.com'),
	('Felipe Santos','M', '1976-11-25', 'felipes@mail.com'),
	('Ana Cristina','F', '1968-02-19', 'anac@mail.com'),
	('Alexandre Alves','M', '1988-07-07', 'alexandrea@mail.com'),
	('Laura Marques','F', '1987-10-04', 'lauram@mail.com');	

INSERT INTO Programador_Linguagem VALUES
	(30001, 20001),
    (30001, 20002),
    (30002, 20003),
    (30003, 20004),
    (30003, 20005),
    (30004, 20005),
    (30007, 20001),
    (30007, 20002);        
-- FIM INSERTS    

UPDATE Programador SET id_startup = 10001 WHERE id_programador = 30001;
UPDATE Programador SET id_startup = 10002 WHERE id_programador = 30002;
UPDATE Programador SET id_startup = 10003 WHERE id_programador = 30003;
UPDATE Programador SET id_startup = 10004 WHERE id_programador = 30004;
UPDATE Programador SET id_startup = 10001 WHERE id_programador = 30005;
UPDATE Programador SET id_startup = 10004 WHERE id_programador = 30006;
UPDATE Programador SET id_startup = 10002 WHERE id_programador = 30007;

-- ALTER TABLE AND FOREGIN KEYS
ALTER TABLE Startup AUTO_INCREMENT=10001;
ALTER TABLE Linguagem_Programacao AUTO_INCREMENT=20001;
ALTER TABLE Programador AUTO_INCREMENT=30001;
ALTER TABLE Programador_Linguagem ADD FOREIGN KEY (id_programador) REFERENCES Programador(id_programador) ON DELETE RESTRICT ;
ALTER TABLE Programador_Linguagem ADD FOREIGN KEY (id_linguagem) REFERENCES Linguagem_Programacao(id_linguagem) ON DELETE RESTRICT;
-- FIM ALTER TABLE AND FOREGIN KEYS

-- B) 

INSERT Programador (id_programador, nome_programador, genero, data_nascimento, email) VALUES
	(30003,'reginaldo rossi','M', '1943-02-14', 'exemPROGLINGo@mail.com');
    
INSERT Programador (id_programador, nome_programador, genero, data_nascimento, email) VALUES
	(30009,'reginaldo rossi','Masculino', '1943-02-14', 'exemPROGLINGo@mail.com');

INSERT Programador (id_programador, nome_programador, genero, data_nascimento, email) VALUES
	(30009,'reginaldo rossi','Masculino', '1943-02-14');

UPDATE Programador SET id_startup = 10009 WHERE id_programador = 30009;

-- C) 
SELECT Programador.nome_programador, Startup.nome_startup FROM Programador
	LEFT JOIN Startup
		ON Programador.id_startup = Startup.id_startup;

SELECT Programador.nome_programador, DATE_FORMAT (Programador.data_nascimento , '%d/%m/%Y') FROM Programador
	WHERE Programador.genero = 'F';

SELECT P.nome_programador FROM Programador AS P
	LEFT JOIN Programador_Linguagem AS PROGLING
		ON P.id_programador = PROGLING.id_programador 
	LEFT JOIN Linguagem_Programacao AS LINGPROG
		ON LINGPROG.id_linguagem = PROGLING.id_linguagem
		WHERE LINGPROG.nome_linguagem = 'JavaScript' OR LINGPROG.nome_linguagem = 'Python';

SELECT P.nome_programador FROM Programador AS P
	LEFT JOIN Programador_Linguagem AS PROGLING
		ON P.id_programador = PROGLING.id_programador 
	LEFT JOIN Linguagem_Programacao AS LINGPROG
		ON LINGPROG.id_linguagem = PROGLING.id_linguagem
		WHERE LINGPROG.nome_linguagem = 'PHP' AND P.data_nascimento >= '1980/01/01' AND P.data_nascimento <= '1990/12/31';

SELECT P.nome_programador FROM Programador AS P
	LEFT JOIN Startup AS S
		ON P.id_startup = S.id_startup
		WHERE S.nome_startup LIKE '%BSI Next Level%' AND P.data_nascimento >= 1993/01/01;

SELECT P.nome_programador, A.nome_startup FROM Programador AS P
	LEFT JOIN Startup AS A
	ON P.id_startup = A.id_startup
	WHERE A.cidade_sede LIKE 'A%';

commit;