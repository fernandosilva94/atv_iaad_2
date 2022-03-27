-- 2)
-- A) 
SELECT DISTINCT F.Pnome, F.Unome FROM FUNCIONARIO AS F
	LEFT JOIN DEPENDENTE AS D
	ON D.Fcpf = F.Cpf
	WHERE D.Sexo = 'F';

-- B) 
SELECT F.Pnome FROM FUNCIONARIO AS F
	WHERE F.Cpf_supervisor = '88866555576';

-- C) 
SELECT D.Dnome FROM DEPARTAMENTO AS D
	LEFT JOIN LOCALIZACAO_DEP AS LD
	ON LD.Dnumero = D.Dnumero
	WHERE LD.Dlocal = "São Paulo";

-- D) 
SELECT F.Pnome, F.Unome FROM FUNCIONARIO AS F
	LEFT JOIN DEPARTAMENTO AS D
		ON D.Dnumero = F.Dnr -- chave primaria = chave estrangeira
	LEFT JOIN TRABALHA_EM AS TE
		ON TE.Fcpf = D.Cpf_gerente
	LEFT JOIN PROJETO AS P
		ON P.ProjNumero = TE.Pnr
		WHERE D.Dnome = 'Administração' AND 15 <= TE.Horas <= 35 AND P.Projnome = 'Novosbenefícios';

-- E)
INSERT INTO DEPENDENTE VALUES
	('98765432168', 'Fernanda','F', '1975-08-03', 'Filha');	
SELECT DISTINCT F.Pnome, F.Unome FROM FUNCIONARIO AS F
	LEFT JOIN DEPENDENTE AS D
		ON D.Fcpf = F.Cpf
		WHERE D.Sexo = 'F';

-- F)
UPDATE DEPARTAMENTO
SET Cpf_gerente = '99988777767',
	Data_inicio_gerente = '2022/03/01'
	WHERE Dnumero = 4;

UPDATE FUNCIONARIO
SET Salario = Salario + (Salario * 0.8)
	WHERE Cpf = '99988777767';

-- G) O que aconteceu foi por causa da Integridade de chave. Não pode alterar uma chave estrangeira, porque ela tem que ser igual a chave primária da tabela pai
UPDATE FUNCIONARIO
SET Cpf_supervisor = '55689742328'
	WHERE Cpf = '33344555587';

-- H) Esse tipo de erro, que viola a integridade de entidade, acontece porque essa coluna está em uso em outras tabelas. Para dar certo, esse delete tem que ser feito na tabela pai
DELETE FROM FUNCIONARIO
 WHERE Cpf = '66688444476'; 
 
 -- I) Aqui deu certo porque a coluna foi deletada na tabela pai
 DELETE FROM TRABALHA_EM
	WHERE Fcpf = '66688444476';
 
 -- J) Porque agora essa coluna não está sendo usada em outras tabelas, liberando a possibilidade dessa coluna ser deletada
 DELETE FROM FUNCIONARIO
	WHERE Cpf = '66688444476'; 
    
-- K) Colocaria tipo Numeric por questão de segurança, para impedir que o usuário tente colocar caracteres não-numericos nesse campo
ALTER TABLE FUNCIONARIO ADD COLUMN telefone NUMERIC; 