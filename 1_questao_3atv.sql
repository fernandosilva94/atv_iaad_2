SELECT Programador.nome_programador, Startup.nome_startup FROM Programador
	JOIN Startup
		WHERE Programador.id_startup = Startup.id_startup;

SELECT Programador.nome_programador, Startup.nome_startup FROM Programador
	INNER JOIN startup
		ON Programador.id_startup = Startup.id_startup;
        
SELECT Programador.nome_programador, Startup.nome_startup FROM Programador
	NATURAL JOIN startup;
-- ============================================================================================================>

-- 1 QUESTÃO B) ==============================================================================================>
SELECT * FROM Programador AS P
	LEFT JOIN Programador_Linguagem AS PROGLING
		ON P.id_programador = PROGLING.id_programador 
	LEFT JOIN Linguagem_Programacao AS LINGPROG
		ON LINGPROG.id_linguagem = PROGLING.id_linguagem
	WHERE LINGPROG.id_linguagem != PROGLING.id_linguagem;
    
    
SELECT * FROM Programador AS P
	LEFT JOIN Programador_Linguagem AS PROGLING
		ON P.id_programador = PROGLING.id_programador 
	LEFT JOIN Linguagem_Programacao AS LINGPROG
		ON LINGPROG.id_linguagem = PROGLING.id_linguagem
	WHERE LINGPROG.id_linguagem NOT IN (PROGLING.id_linguagem);
    
SELECT * FROM Programador AS P
	LEFT JOIN Programador_Linguagem AS PROGLING
		ON P.id_programador = PROGLING.id_programador 
	LEFT JOIN Linguagem_Programacao AS LINGPROG
		ON LINGPROG.id_linguagem = PROGLING.id_linguagem;
		
select * from programador as p
	where not exists (select * from Programador_Linguagem as PROGLING
						left join Linguagem_Programacao as LINGPROG
							on LINGPROG.id_linguagem = PROGLING.id_linguagem);
-- ============================================================================================================>    

-- 1ª QUESTÃO C) ==============================================================================================>
SELECT distinct A.nome_startup, COUNT(B.id_programador) FROM Startup as A
    LEFT JOIN Programador AS B
        ON A.id_startup = B.id_startup
        GROUP BY A.nome_startup;
        
-- D  Especifique o comando SQL que retorna a tabela abaixo: 

SELECT S.nome_startup, 
	GROUP_CONCAT(" ", P.nome_programador) AS nomes_programadores
FROM  Startup AS S
LEFT JOIN Programador AS P
	ON S.id_startup = P.id_startup
GROUP BY S.nome_startup;

-- E Especifique o comando SQL que retorna o código e nome de cada linguagem de programação (LP), seguido do número de programadores(as) (quantidade total) que programam na LP. Devem aparecer no resultado da consulta apenas as LP com mais de 1 programador(a). Ou seja, retornar as linguagens de programação que têm mais de um(a) programador(a). Além do comando SQL, apresente a tabela resultante.

SELECT A.id_linguagem, COUNT(B.id_programador) AS cont_prog FROM Linguagem_Programacao AS A
	LEFT JOIN programador_linguagem as B
		ON A.id_linguagem = B.id_linguagem
	LEFT JOIN programador AS C 
		ON C.id_programador = B.id_programador
			WHERE B.id_linguagem > 0
        GROUP BY A.id_linguagem;
        -- 
		

-- chave primaria = chave estrangeira
-- GROUP BY LP.id_linguagem, LP.nome_linguagem;

-- F Apresente a expressão da álgebra relacional e o comando SQL que retorna os nomes e e-mail das programadoras (apenas gênero feminino) que nasceram entre 1985 e 1990, além dos nomes das respectivas  linguagens de programação em que elas programam. Apresente também a tabela resultante.

SELECT A.nome_programador,
	   A.email, 
       C.nome_linguagem,
       A.data_nascimento FROM Programador AS A
JOIN Programador_Linguagem AS B
ON A.id_programador = B.id_programador -- chave primaria = chave estrangeira
JOIN Linguagem_Programacao AS C
ON C.id_linguagem = B.id_linguagem
	WHERE A.genero = 'F' AND A.data_nascimento BETWEEN '1985/01/01' AND '1990/12/31';

-- G Apresente a expressão da álgebra relacional e o comando SQL que retorna os identificadores das linguagens de programação cadastradas no BD Startup em que o programador cujo id é “30003” não programa. Apresente também a tabela resultante.

SELECT * FROM linguagem_programacao as A
	LEFT JOIN programador_linguagem as B
		ON A.id_linguagem = B.id_linguagem
	LEFT JOIN programador as C
		ON C.id_programador = B.id_programador
        where A.id_linguagem <> 30003 and A.nome_linguagem not in ('C', 'JavaScript')
		group by B.id_linguagem;

-- H)
SELECT * FROM startup AS A
	left JOIN programador as B
		on A.id_startup = B.id_startup
		and A.id_startup = null;
        
-- I)
SELECT *
FROM Programador AS P
JOIN Startup AS S
ON P.id_startup = S.id_startup
WHERE S.nome_startup = 'Smart123' OR P.data_nascimento BETWEEN '1987-04-17' and '2022-04-17'; 

-- J)
SELECT *
FROM Programador AS P
JOIN Startup AS S
ON P.id_startup = S.id_startup
WHERE S.nome_startup = 'Smart123' AND P.data_nascimento BETWEEN '1987-04-17' and '2022-04-17';

