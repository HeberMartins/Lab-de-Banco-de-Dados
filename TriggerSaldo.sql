CREATE DATABASE BancoStandard

CREATE TABLE Cliente(
	id_cliente INTEGER PRIMARY KEY IDENTITY,
	nome VARCHAR(50),
	cpf VARCHAR(12) NOT NULL,
	tipo_conta VARCHAR(50),
	saldo SMALLMONEY
)

CREATE TABLE Transferencia(
	id_transferencia INTEGER PRIMARY KEY IDENTITY,
	id_cliente INTEGER,
	FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente),
	tipo_transferencia VARCHAR(50),
	data_transferencia DATE,
	valor_transferencia SMALLMONEY
)

GO

INSERT INTO Cliente VALUES ('Tobias', '000000000/09', 'Normal', 900)

GO

CREATE TRIGGER SaldoBaixo
ON Transferencia 
INSTEAD OF INSERT AS
BEGIN
	DECLARE @valor_verficando SMALLMONEY
	DECLARE @saldo SMALLMONEY
	DECLARE @conta INT

	SELECT
        @valor_verficando = inserted.valor_transferencia,
		@conta = inserted.id_cliente
    FROM inserted;

	SELECT @saldo = saldo FROM Cliente WHERE id_cliente = @conta
	
	IF @valor_verficando > @saldo
		BEGIN
			ROLLBACK
			RAISERROR('Saldo Insuficiente', 14, 1)
		END

END

INSERT INTO Transferencia VALUES (1, 'Conta Corrente', '21/08/2025', 901)

