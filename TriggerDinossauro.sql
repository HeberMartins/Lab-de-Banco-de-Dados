CREATE TABLE Grupo(
    grupo_id INT PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE Era(
    era_id INT PRIMARY KEY,
    nome VARCHAR(50),
    inicio INT,
    fim INT
);

CREATE TABLE Descobridor(
    descobridor_id INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE Pais(
    pais_id INT PRIMARY KEY,
    nome VARCHAR(50)
);

CREATE TABLE Dinossauro(
    dinossauro_id INT PRIMARY KEY,
    nome VARCHAR(100),
    toneladas FLOAT,
    ano_descoberta INT,
    grupo_id INT,
    descobridor_id INT,
    era_id INT,
    pais_id INT,
    FOREIGN KEY (grupo_id) REFERENCES Grupo(grupo_id),
    FOREIGN KEY (descobridor_id) REFERENCES Descobridor(descobridor_id),
    FOREIGN KEY (era_id) REFERENCES Era(era_id),
    FOREIGN KEY (pais_id) REFERENCES Pais(pais_id)
);




INSERT INTO GRUPO(grupo_id, nome) VALUES
(1, 'Anquilossauros'),
(2, 'Ceratopsídeos'),
(3, 'Estegossauros')


INSERT INTO Era(era_id, nome, inicio, fim) VALUES
(1, 'Cretáceo', 145, 66),
(2, 'Jurássico', 201, 145)


INSERT INTO Descobridor(descobridor_id, nome) VALUES
(1, 'Maryanska'),
(2, 'John Bell Hatcher'),
(3, 'Cientistas Alemães')

INSERT INTO Pais(pais_id, nome) VALUES
(1, 'Mongólia'),
(2, 'Canadá'),
(3, 'Tanzânia')

INSERT INTO Dinossauro(dinossauro_id, nome, toneladas, ano_descoberta, grupo_id, descobridor_id, era_id, pais_id) VALUES
(1, 'Saichania', 4, 1977, 1, 1, 1, 1),
(2, 'Tricerátops', 6, 1887, 2, 2, 1, 2),
(3, 'Kentrossauro', 2, 1909, 3, 3, 2, 3)


SELECT * FROM Dinossauro ORDER BY nome

GO

CREATE TRIGGER VeriEra
ON Dinossauro INSTEAD OF INSERT
AS
BEGIN
	DECLARE @era INT
	DECLARE @anoDesc INT
	DECLARE @era_id INT;

	SELECT @anoDesc = inserted.ano_descoberta, @era_id = inserted.era_id FROM inserted
	SELECT @era = inicio FROM Era WHERE @era_id = era_id

	IF(@era != @anoDesc)
		BEGIN
			ROLLBACK
			RAISERROR('O ano de descoberta difere do começo da era', 14, 1)
		END 

END