CREATE DATABASE FicEmpresa


CREATE TABLE Produtos (
    id_produtos INTEGER PRIMARY KEY IDENTITY,
    nome VARCHAR(70),
    categoria VARCHAR(50),
    estoque  INTEGER,
    preco_unitario SMALLMONEY NOT NULL

);


CREATE TABLE Vendas (
    id_vendas INTEGER PRIMARY KEY IDENTITY,
    id_produto INTEGER,
    FOREIGN KEY(id_produto) REFERENCES Produtos (id_produtos),
    quantidade_comprada INTEGER NOT NULL,
    vendedor VARCHAR(50),
    cpf_cliente VARCHAR(12),
    valor_venda SMALLMONEY
);

GO

CREATE TRIGGER AtualizaEstoqueEVenda
	ON Vendas AFTER INSERT AS
	BEGIN
		UPDATE Produtos
		SET estoque = estoque - inserted.quantidade_comprada
		FROM Produtos, inserted
		WHERE Produtos.id_produtos = inserted.id_produto;
 
		UPDATE Vendas
		SET valor_venda = inserted.quantidade_comprada * Produtos.preco_unitario
		FROM Vendas
		INNER JOIN inserted ON Vendas.id_vendas = inserted.id_vendas
		INNER JOIN Produtos ON inserted.id_produto = Produtos.id_produtos;

	END


INSERT INTO Produtos VALUES ('Teclado', 'Tech', 40, 100)
INSERT INTO Produtos VALUES ('Caneta', 'Papelaria', 100, 1.50)
SELECT * FROM Produtos
INSERT INTO Vendas VALUES (1, 1, 'Sergio', '000000000/09', 2)
INSERT INTO Vendas VALUES (2, 3, 'Sergio', '000000000/09', 2)
SELECT * FROM Produtos
SELECT * FROM Vendas

GO

CREATE TRIGGER NaoNegativo
	ON Produtos AFTER UPDATE AS
	BEGIN
		DECLARE @preco_atualizado smallmoney
		SELECT @preco_atualizado = (SELECT inserted.preco_unitario FROM inserted)

		IF @preco_atualizado < 0.1
			BEGIN
				ROLLBACK
				RAISERROR('Preço Negativo', 14, 1)
			END
END

UPDATE Produtos SET preco_unitario = -10 WHERE preco_unitario = 100