--Aula03
----------Criar Tabelas (CREATE TABLE)----------------------------------------------------------------------------------------------

--drop table livro --deletar a tabela
create table livro (
	ISBN integer,        --int (Sem aspas)
	titulo varchar (50), --texto (Aspas Simples)
	relDate date,	     --Aspas Simples
	constraint pk_ISBN primary key (ISBN) --Chave Primaria 
	--constraint pk_ISBN primary key (ISBN,titulo) -- caso a chave primaria fosse composta do ISBN e do Titulo
); 

select * from livro; --mostrar todos os elementos da tabela

----------Inserir Dados nas Tabelas (INSERT)----------------------------------------------------------------------------------

insert into livro values (1111,'nomeLivro1','01/01/2001'), --Valores na ordem de criação da tabela (ISBN,titulo)
						 (2222,'nomeLivro2','02/02/2002'),
						 (3333,'nomeLivro3','03/03/2003');
						 
----------Deletar Dados das Tabelas (DELETE)----------------------------------------------------------------------------------

delete from livro where titulo = 'nomeLivro3' --(Delete toda coluna cujo o nome do livro seja nomeLivro3)

delete from livro --Apaga todas as linhas

----------Atualizar Dados das Tabelas (UPDATE)--------------------------------------------------------------------------------

update livro set titulo = 'nomeLivro2_ALTERADO' where titulo = 'nomeLivro2'

--Aula04
----------Chave Estrangeira (Constraint Foreign Key)------------------------------------------------------------------------------------------
--drop table cliente
CREATE TABLE cliente(
	cpf VARCHAR (13) NOT NULL,
	nome VARCHAR (60) NOT NULL,
	constraint pk_cliente primary key (cpf)
);

--drop table pedido
CREATE TABLE pedido(
	cod_pedido integer NOT NULL,
	valor numeric (9,2) NOT NULL,
	cpf_cli VARCHAR (13) NOT NULL, --Variavel criada para ser a chave estrangeira de "cliente" nessa tabela
	CONSTRAINT pk_pedido PRIMARY KEY (cod_pedido),
	CONSTRAINT fk_pedido_cliente FOREIGN KEY (cpf_cli) REFERENCES cliente --cpf_cli recebe a chave primaria de "Cliente" que é "cpf"
); 

----------Deletando/Alterando Dados de Tabelas Relacionadas(DELETE CASCADE, UPDATE CASCADE, DELETE SET NULL)------------------------------------------------------------------------------------------
--drop table funcionario
CREATE table Funcionario (
	codFunc integer NOT NULL,				          		
	nome VARCHAR(50) NOT NULL, 
	constraint pk_funcionario PRIMARY KEY (codFunc));
	
--drop table dependente
CREATE table DEPENDENTE (
	codDepend INTEGER NOT NULL,
	codFunc INTEGER NOT NULL,
	nome VARCHAR(50) NOT NULL,
	constraint pk_dependente PRIMARY KEY(codDepend, codFunc),
	constraint fk_dependente_func FOREIGN KEY (codFunc) REFERENCES FUNCIONARIO 
	ON DELETE CASCADE  --Linhas que fazem referencia a apagada também são apagadas
	ON UPDATE CASCADE  --Linhas que fazem referencia a alterada essas também serão atualizadas
  --ON DELETE SET NULL --Linhas que fazem referencia a apagada, terão valores NULL na tabela da chave estrangeira
);
insert into funcionario values (12,'Carlos');
insert into funcionario values (11,'Carlos');
insert into funcionario values (10,'Roberto');
insert into dependente values (1,12,'Alberto');
insert into dependente values (2,12,'Tiago');

--Aula05
----------Mostrando/Pesquisando dados nas Tabelas (WHERE)------------------------------------------------------------------------------------------

select * from funcionario; --Mostra todos os atributos de funcionario

select nome,codDepend from dependente where nome = 'Alberto' --Mostrar todos os dependentes que chamam alberto

select nome,codDepend from dependente where nome <> 'Alberto' --Mostrar todos os dependentes que não chamam Alberto
select nome,codDepend from dependente where nome not in ('Alberto') --Mostrar todos os dependentes que não chamam Alberto

select nome,codDepend from dependente where nome = 'Alberto' OR nome = 'Tiago' --Retorna quem chama Alberto OU Tiago

select nome,codDepend from dependente where nome = 'Alberto' AND nome = 'Tiago' --Retorna quem chama Alberto E Tiago
select nome,codDepend from dependente where nome in ('Alberto','Tiago') --Retorna quem chama Alberto E Tiago

select distinct (nome) from Funcionario; -- Elimina nomes repetidos, mostrando apenas um

----------Ordenando Consultas (ORDER BY, ASC, DESC)------------------------------------------------------------------------------------------

select nome,codDepend from dependente order by nome ASC; -- Nomes em Ordem Crescente

select nome,codDepend from dependente order by nome Desc;-- Nomes em Ordem Decrescente 

----------Alias (Mudar o noem de um atributo em uma consulta)------------------------------------------------------------------------------------------

select nome as "Nome dos Dependentes" ,codDepend from dependente;  --nome temporario em "Aspas duplas"


--Aula06
----------Comparando valores (BETWEEN)--------------------------------------------------------------------

select nome,idade from dependente where idade BETWEEN 1 and 18;
select nome,idade from dependente where idade >= 1 and idade <= 18;

----------Pesquisas em nomes('A%','%a%', LIKE e ILIKE)--------------------------------------------------------------------
-- % (Qualquer quantidade de caracteres, 0 ou mais())

-- _ (Qualquer caractere mas só 1 )

--LIKE (Case sensitive)
select * from empregado WHERE pnome LIKE 'A%'; --mostra nomes que possuem 'A' Em primeira letra
select * from empregado WHERE pnome LIKE '%a%';--mostra nomes que possuem 'a' em qualquer lugar
select * from empregado WHERE pnome LIKE '_a'; --mostra nomes que possuem 'a' Depois da primeira Letra
select * from empregado WHERE pnome LIKE 'a_'; --mostra nomes que possuem 'a' como penultima letra

--ILIKE (não é case sensitive)
select * from empregado WHERE pnome ILIKE 'A%'; --essas duas pesquisas ssão iguais pois não ira diferenciar maiusculas de minusculas
select * from empregado WHERE pnome ILIKE 'a%';

----------Funçoes Agregadas(AVG, COUNT, MAX, MIN, SUM)--------------------------------------------------------------------

SELECT avg(salario) from empregado --MEDIA de uma Coluna

SELECT count(*) AS "Quantidade de Gerente na Empresa" FROM empregado WHERE cargo = 'Gerente' --QUANTIDADE de valores da coluna

SELECT max(salario), min(salario) from empregado --o MAIOR salario e o MENOR salario da coluna

SELECT sum(salario) AS "Soma salarial" FROM empregado; -- SOMA de todos os salarios da coluna

--Deverão ser utilizados com GROUP BY e HAVING ao invés de where caso haja restrição

SELECT cargo, sum(salario) from empregado
GROUP BY cargo --mostra a SOMA do salario de cada TIPO de Cargo
HAVING sum(salario) > 10000 --Restrição (Como se fosse where) 

--Aula07
----------Junções (INNER JOIN e WHERE/AND)--------------------------------------------------------------------

--INNER JOIN
select a.pnome, p.pnome , nota, nomeCurso, ano --Igual nos Dois
from curso c --Uma tabela de cada vez
inner join aluno a on a.idCurso = c.idCurso --Acrescenta uma tabela, e liga com a de Cima (Aluno com Curso)
inner join professorLecionaAluno pl on pl.prontuarioAluno = a.prontuario --(professorLecionaAluno com Aluno)
inner join professor p on p.prontuario = pl.prontuarioProfessor --(professor com professorLecionaAluno)
where nota>7; --where com restrição no final

--Junção
select a.pnome, p.pnome, nota,nomeCurso,ano    --Igual nos Dois
from aluno a, professor p, professorLecionaAluno pl, curso c --Todas as tabelas são escritas no FROM
where c.idCurso = a.idCurso and pl.prontuarioAluno = a.prontuario and p.prontuario = pl.prontuarioProfessor --as tabelas são ligadas com a anterior em where (Curso com Aluno, professorLecionaAluno com Aluno, professor com professorLecionaAluno)
and nota > 7; -- and para adicionar a restrição, pois ja esta dentro de um where



