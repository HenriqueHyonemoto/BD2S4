CREATE TABLE marinheiros (id_marin integer PRIMARY KEY, nome_marin VARCHAR (40), avaliacao integer, idade integer);

INSERT INTO marinheiros VALUES (1,'Capitão Gancho', 8, 57),(2,'Alma Negra', 9, 37),
			(3,'Jack Sparrow', 5, 35),(4,'Marujo Frajuto', 3, 42),(5,'Barba Branca', 10, 67);

--INSERT INTO marinheiros VALUES (6,'Willy caolho', 8, 59)
CREATE TABLE barcos (id_barco INTEGER PRIMARY KEY, nome_barco VARCHAR (40), cor VARCHAR(10));

INSERT INTO barcos VALUES (1, 'Pérola Negra', 'Preto'), (2, 'Azul do Mar', 'Azul'),(3, 'Catraca voadora', 'Verde')
			,(4, 'Sigano do Mar', 'Marron'),(5, 'Jóia do Oceano', 'Preto'),(6, 'Marinheiros Gayvotenses', 'Rosa');

CREATE TABLE reservas (id_marin INTEGER REFERENCES marinheiros (id_marin), id_barco INTEGER REFERENCES barcos (id_barco), data_res date,
			PRIMARY KEY (id_marin,id_barco,data_res));

INSERT INTO reservas values (1,2,'01/01/2013'),(2,4,'07/04/2013'),(3,1,'05/06/2013'),(2,2,'07/08/2013'),(4,2,'05/03/2013'),
(5,6,'24/10/2013'),(3,5,'08/02/2013'),(2,4,'12/08/2013'),(5,5,'03/04/2013'),(3,5,'07/04/2013'),(1,6,'25/09/2013');

SELECT * FROM marinheiros;
SELECT * FROM barcos;
SELECT * FROM reservas;

--------------------------------Exercicios------------------------------
select * from marinheiros;
--1.Faça uma consulta que retorne o nome de todos os marinheiros com uma letra a no nome ou que tenham a penúltima letra r.--{
select nome_marin as "Nomes com 'a' o Penultima letra 'r'" from marinheiros where nome_marin ilike '%a%' or nome_marin like '%r_';
--}

--2. Faça uma consulta que retorne o nome dos barcos e a quantidade de cores que cada barco possui.{
select nome_barco as "Nome do Barco", count(cor) as "Quantidade de Cores" from barcos group by nome_barco;
--}
--3. Faça uma consulta que selecione o nome de todos os barcos que foram alugados e a data da reserva, ordenados pela data crescentemente.{
select nome_barco, data_res from reservas r
inner join barcos b
on b.id_Barco = r.id_Barco
order by data_res asc;
--}
--4. Faça uma consulta que retorne o nome dos marinheiros que possuem uma letra i no nome que alugaram um barco depois de 05/05/2013.{
select nome_marin, data_res from marinheiros m
inner join reservas r
on r.id_marin = m.id_marin
where nome_marin ilike '%i%' and data_res > '05/05/2013'; --Datas vão ente aspas simples 
--}
--5. Faça uma consulta que retorne a quantidade de barcos que cada marinheiro já fez reserva. Deve ser retornado o nome dos marinheiros e a quantidade.{
select nome_marin, count(nome_barco) as "Barcos Reservados" from reservas r
inner join marinheiros m
on r.id_marin = m.id_marin
inner join barcos b
on b.id_barco = r.id_barco
group by nome_marin;


--}

--6. Modifique o exercício 5 para que sejam somente os marinheiros que alugaram uma quantidade maior que um barco.{

select nome_marin, count(nome_barco) as "Barcos Reservados" from reservas r
inner join marinheiros m
on r.id_marin = m.id_marin
inner join barcos b
on b.id_barco = r.id_barco
group by nome_marin
having count(nome_barco) > 1 
order by nome_marin asc;


--}
--7. Selecione o nome dos marinheiros e dos barcos que alugaram em ordem alfabética do marinheiro.{
select nome_marin, nome_barco from reservas r
inner join marinheiros m
on m.id_marin = r.id_marin
inner join barcos b
on b.id_barco = r.id_barco
order by nome_marin asc;
--}

