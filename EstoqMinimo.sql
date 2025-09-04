CREATE DATABASE Estoque

/*
-Estoque mínimo
Um sistema possui uma tabela para armazenar os registros dos PRODUTOS que comercializa, 
e tambem uma tabela de REQUISICOES que pode ser de entrada ou de saída, além da MOVIMENTACAO, 
que pode ser de entrada ou de saida - uma requisição que foi confirmada.
Faça uma trigger que gere uma nova REQUISICAO de entrada caso as requisições de saída atinjam 
mais de 70% da quantidade do item em questão em estoque.
*/

CREATE TABLE Produtos(
	id_produto INT PRIMARY KEY IDENTITY,
	nome VARCHAR(100),
	categoria VARCHAR(50),
	estoque INT
)

CREATE TABLE Requisicoes(
	id_req INT PRIMARY KEY IDENTITY,
	tipo VARCHAR (20),
	id_produto INT
	FOREIGN KEY (id_produto) REFERENCES Produtos (id_produto),
	quantidade INT
)

CREATE TABLE Movimentacao(
	id_mov INT PRIMARY KEY IDENTITY,
	id_req INT,
	FOREIGN KEY (id_req) REFERENCES Requisicoes (id_req),
	tipo_mov VARCHAR (6)
)

GO

INSERT INTO Produtos VALUES ('Teclado', 'Tec', 80)
INSERT INTO Requisicoes VALUES ('Compra', 1, 20)
INSERT INTO Movimentacao VALUES (1, 'Entrada')
INSERT INTO Produtos VALUES ('Mouse', 'Tec', 50)
INSERT INTO Requisicoes VALUES ('Venda', 2, 10)
INSERT INTO Movimentacao VALUES (2, 'Saida')

GO

CREATE TRIGGER EstoqMinimo 
ON Requisicoes INSTEAD OF INSERT AS
BEGIN
	DECLARE @TipoM VARCHAR(20)
	DECLARE @Req INT
	DECLARE @TipoR VARCHAR(6)
	DECLARE @Quant INT
	DECLARE @Prod INT
	DECLARE @Est INT
	
	SELECT @TipoR = inserted.tipo, @Quant = inserted.quantidade, @Prod = inserted.id_produto FROM inserted
	SELECT @TipoM = tipo_mov, @Req = id_req FROM Movimentacao
	SELECT @Est = estoque FROM Produtos WHERE @Prod = id_produto

	IF(@TipoR = 'Entrada')
		BEGIN
			UPDATE Produtos
			SET estoque = Produtos.estoque + inserted.quantidade
			FROM Produtos
			JOIN inserted ON Produtos.id_produto = inserted.id_produto;
		END ELSE IF(@Quant > 0.70 * @Est)
			BEGIN
				ROLLBACK
				RAISERROR('Estoque Baixo. Insira mais produtos no estoque', 14, 1)
			END

END