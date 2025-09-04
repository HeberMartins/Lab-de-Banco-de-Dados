/* 1.	Um hospital deseja ter um controle amplo sobre seus pacientes e profissionais e exames. Para isso, cada paciente possui uma ficha cadastral 
onde armazena-se os dados cadastrais como CPF, nome, endere�o, data de nascimento. Os m�dicos por sua vez tamb�m possuem as mesmas informa��es do paciente 
mas tamb�m tem um  CRM (n�mero de cadastro no conselho regional de medicina), uma especialidade (ex: pediatra, traumatologista, etc), um cargo e seu respectivo
sal�rio. Toda consulta neste complexo m�dico envolve um paciente um m�dico e seus respectivos exames solicitados, data  e hor�rio de atendimento, os exames 
por sua vez cont�m informa��es sobre tipo de exame (exemplo: exame laboratorial: hemograma, exame de imagens: raio-x, exame, Monitoriza��o Ambulatorial da 
Press�o Arterial, etc). Este centro cl�nico deseja manter o registro de todas as consultas realizadas assim como de seus pacientes e um registro 
dos seus funcion�rios e a suas respectivas evolu��es de cargos e sal�rios com o passar do tempo. */

CREATE DATABASE Hospital

CREATE TABLE Pacientes(
	id_paciente INTEGER PRIMARY KEY IDENTITY,
	CPF VARCHAR(12) NOT NULL UNIQUE,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR (50) NOT NULL,
	nasc date NOT NULL,
	SysStartTime datetime2 generated always as row start not null,
	SySEndTime datetime2 generated always as row end not null,
	period for system_time (SysStartTime, SysEndTime)
	)
	with
	(
		SYSTEM_VERSIONING = ON(history_table = dbo.HistoricoPacientes)
	)


CREATE TABLE Medicos(
	id_medico INTEGER PRIMARY KEY IDENTITY,
	CPF VARCHAR(12) NOT NULL UNIQUE,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR (50) NOT NULL,
	nasc date NOT NULL,
	CRM VARCHAR(20) NOT NULL UNIQUE ,
	especialidade VARCHAR(50) NOT NULL,
	cargo VARCHAR(50) NOT NULL,
	salario SMALLMONEY NOT NULL,
	SysStartTime datetime2 generated always as row start not null,
	SySEndTime datetime2 generated always as row end not null,
	period for system_time (SysStartTime, SysEndTime)
	)
	with
	(
		SYSTEM_VERSIONING = ON(history_table = dbo.HistoricoMedicos)
	)

CREATE TABLE Exames (
	id_exame INTEGER PRIMARY KEY IDENTITY,
	tipo_exame VARCHAR(70)
)


CREATE TABLE Consultas (
	id_consuta INTEGER PRIMARY KEY IDENTITY,
	id_paciente INT
	FOREIGN KEY (id_paciente) REFERENCES Pacientes (id_paciente),
	id_medico INT
	FOREIGN KEY (id_medico) REFERENCES Medicos (id_medico),
	id_exame INT
	FOREIGN KEY (id_exame) REFERENCES Exames (id_exame),
	data date NOT NULL,
	hora time NOT NULL,
	SysStartTime datetime2 generated always as row start not null,
	SySEndTime datetime2 generated always as row end not null,
	period for system_time (SysStartTime, SysEndTime)
	)
	with
	(
		SYSTEM_VERSIONING = ON(history_table = dbo.HistoricoConsultas)
	)


PRINT 'Inserindo Pacientes...';
INSERT INTO Pacientes (CPF, nome, endereco, nasc)
VALUES
('11122233344', 'Jo�o da Silva', 'Rua das Flores, 123', '1985-05-20'),
('55566677788', 'Maria Oliveira', 'Avenida Principal, 456', '1992-11-30'),
('99988877766', 'Pedro Souza', 'Travessa dos Sonhos, 789', '2015-01-10');
GO



PRINT 'Inserindo M�dicos...';
INSERT INTO Medicos (CPF, nome, endereco, nasc, CRM, especialidade, cargo, salario)
VALUES
('12345678900', 'Dr. Carlos Andrade', 'Rua da Sa�de, 10', '1978-08-15', 'SP 123456', 'Cardiologista', 'M�dico Chefe', 18500.00),
('09876543211', 'Dra. Luana Costa', 'Avenida da Paz, 20', '1982-03-25', 'RJ 654321', 'Pediatra', 'M�dica Plantonista', 12000.00);
GO



PRINT 'Inserindo Exames...';
INSERT INTO Exames (tipo_exame)
VALUES
('Hemograma Completo'),
('Raio-X do T�rax'),
('Eletrocardiograma'),
('Monitoriza��o Ambulatorial da Press�o Arterial (MAPA)');
GO



PRINT 'Inserindo Consultas...';
INSERT INTO Consultas (id_paciente, id_medico, id_exame, data, hora)
VALUES

(1, 1, 3, '2024-10-05', '09:30:00'),
(2, 2, 1, '2024-10-05', '11:00:00'),
(1, 1, 2, '2024-11-12', '10:00:00'),
(3, 2, 1, '2024-11-15', '14:00:00');
GO

SELECT * FROM Pacientes;
SELECT * FROM Medicos;
SELECT * FROM Exames;
SELECT * FROM Consultas;

UPDATE Medicos SET salario = 30000.00 WHERE id_medico = 2

SELECT * FROM Medicos
SELECT * FROM HistoricoMedicos
select * from Medicos
for system_time all

UPDATE Pacientes SET endereco = 'Jardim Europa,49' WHERE id_paciente = 3

SELECT * FROM Pacientes
SELECT * FROM HistoricoPacientes
select * from Pacientes
for system_time all

DELETE Consultas WHERE id_consuta = 2

SELECT * FROM Consultas
SELECT * FROM HistoricoConsultas
select * from Consultas
for system_time all