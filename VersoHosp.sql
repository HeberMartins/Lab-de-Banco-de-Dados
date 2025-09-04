/* 1.	Um hospital deseja ter um controle amplo sobre seus pacientes e profissionais e exames. Para isso, cada paciente possui uma ficha cadastral 
onde armazena-se os dados cadastrais como CPF, nome, endereço, data de nascimento. Os médicos por sua vez também possuem as mesmas informações do paciente 
mas também tem um  CRM (número de cadastro no conselho regional de medicina), uma especialidade (ex: pediatra, traumatologista, etc), um cargo e seu respectivo
salário. Toda consulta neste complexo médico envolve um paciente um médico e seus respectivos exames solicitados, data  e horário de atendimento, os exames 
por sua vez contém informações sobre tipo de exame (exemplo: exame laboratorial: hemograma, exame de imagens: raio-x, exame, Monitorização Ambulatorial da 
Pressão Arterial, etc). Este centro clínico deseja manter o registro de todas as consultas realizadas assim como de seus pacientes e um registro 
dos seus funcionários e a suas respectivas evoluções de cargos e salários com o passar do tempo. */

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
('11122233344', 'João da Silva', 'Rua das Flores, 123', '1985-05-20'),
('55566677788', 'Maria Oliveira', 'Avenida Principal, 456', '1992-11-30'),
('99988877766', 'Pedro Souza', 'Travessa dos Sonhos, 789', '2015-01-10');
GO



PRINT 'Inserindo Médicos...';
INSERT INTO Medicos (CPF, nome, endereco, nasc, CRM, especialidade, cargo, salario)
VALUES
('12345678900', 'Dr. Carlos Andrade', 'Rua da Saúde, 10', '1978-08-15', 'SP 123456', 'Cardiologista', 'Médico Chefe', 18500.00),
('09876543211', 'Dra. Luana Costa', 'Avenida da Paz, 20', '1982-03-25', 'RJ 654321', 'Pediatra', 'Médica Plantonista', 12000.00);
GO



PRINT 'Inserindo Exames...';
INSERT INTO Exames (tipo_exame)
VALUES
('Hemograma Completo'),
('Raio-X do Tórax'),
('Eletrocardiograma'),
('Monitorização Ambulatorial da Pressão Arterial (MAPA)');
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