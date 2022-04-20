-- 3º) A)
SELECT DISTINCT A.Pnome, A.Unome, C.Fcpf FROM FUNCIONARIO AS A
	JOIN DEPARTAMENTO AS B
		ON B.Dnumero = A.Dnr -- chave primaria = chave estrangeira
	JOIN TRABALHA_EM AS C
		ON C.Fcpf = B.Cpf_gerente
	JOIN PROJETO AS D
		ON D.ProjNumero = C.Pnr
	WHERE B.Dnome = 'Administração';
    
select * from departamento;    
    
-- B)
select * FROM FUNCIONARIO as A
	where salario > 39000.00;
