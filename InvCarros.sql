CREATE DATABASE temporal

CREATE TABLE inventorioCarros (
	id integer primary key identity,
	ano integer,
	marca varchar(50),
	modelo varchar(40),
	cor varchar(12),
	kilometragem integer,
	emEstoque bit not null default 1,
	SysStartTime datetime2 generated always as row start not null,
	SySEndTime datetime2 generated always as row end not null,
	period for system_time (SysStartTime, SysEndTime)
	)
	with
	(
		SYSTEM_VERSIONING = ON
	)

INSERT INTO inventorioCarros (ano, marca, modelo, cor, kilometragem)
VALUES 
(2020, 'Toyota', 'Corolla', 'Prata', 35000);
 
INSERT INTO inventorioCarros (ano, marca, modelo, cor, kilometragem)
VALUES 
(2018, 'Honda', 'Civic', 'Preto', 52000);
 
INSERT INTO inventorioCarros (ano, marca, modelo, cor, kilometragem)
VALUES 
(2022, 'Ford', 'Ranger', 'Branco', 18000);

select * from inventorioCarros

update inventorioCarros set kilometragem = 3500 where id = 1

select * from inventorioCarros
for system_time all

delete from inventorioCarros where id = 2
select * from inventorioCarros
for system_time all
where id = 3

drop table inventorioCarros

alter table inventorioCarros
set (System_versioning = off)

drop table inventorioCarros

CREATE TABLE inventorioCarros (
	id integer primary key identity,
	ano integer,
	marca varchar(50),
	modelo varchar(40),
	cor varchar(12),
	kilometragem integer,
	emEstoque bit not null default 1,
	SysStartTime datetime2 generated always as row start not null,
	SySEndTime datetime2 generated always as row end not null,
	period for system_time (SysStartTime, SysEndTime)
	)
	with
	(
		SYSTEM_VERSIONING = ON(history_table = dbo.HistoricoIventarioCarros)
	)

INSERT INTO inventorioCarros (ano, marca, modelo, cor, kilometragem)
VALUES 
(2020, 'Toyota', 'Corolla', 'Prata', 35000);
 
INSERT INTO inventorioCarros (ano, marca, modelo, cor, kilometragem)
VALUES 
(2018, 'Honda', 'Civic', 'Preto', 52000);
 
INSERT INTO inventorioCarros (ano, marca, modelo, cor, kilometragem)
VALUES 
(2022, 'Ford', 'Ranger', 'Branco', 18000);

update inventorioCarros set kilometragem = 3500 where id = 1

select * from inventorioCarros
select * from HistoricoIventarioCarros
select * from inventorioCarros
for system_time all
