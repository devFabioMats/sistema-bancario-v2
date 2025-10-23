-- Criar o banco de dados
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'banco')
BEGIN
    CREATE DATABASE banco;
END
GO

-- Usar o banco de dados criado
USE banco;
GO

-- Criar tabela Usuario
CREATE TABLE Usuario(
	nome NVARCHAR(50) NOT NULL,
    cpf BIGINT NOT NULL,
    senha NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_Usuario PRIMARY KEY(cpf)
);

-- Criar tabela Endereco
CREATE TABLE Endereco(
	cidade NVARCHAR(50) NOT NULL,
    rua NVARCHAR(50) NOT NULL,
    num INT NOT NULL,
    cpfUsuario BIGINT NOT NULL,
    CONSTRAINT PK_Endereco PRIMARY KEY(cpfUsuario),
    CONSTRAINT FK_Endereco_Usuario FOREIGN KEY(cpfUsuario) REFERENCES Usuario(cpf)
);

-- Criar tabela Conta
CREATE TABLE Conta(
	numConta INT NOT NULL,
    saldo DECIMAL(15,2) DEFAULT 0.00,
    agencia INT NOT NULL,
    cpfUsuario BIGINT NOT NULL,
    CONSTRAINT PK_Conta PRIMARY KEY(cpfUsuario, numConta),
    CONSTRAINT FK_Conta_Usuario FOREIGN KEY(cpfUsuario) REFERENCES Usuario(cpf)
);

-- Criar tabela Cartao
CREATE TABLE Cartao(
	numCartao BIGINT NOT NULL,
    cvv INT NOT NULL,
    limite DECIMAL(15,2) DEFAULT 0.00,
    numConta INT NOT NULL,
    cpfUsuario BIGINT NOT NULL,
    CONSTRAINT PK_Cartao PRIMARY KEY(numCartao),
	CONSTRAINT FK_Cartao_Conta FOREIGN KEY(cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta)
);

-- Criar tabela Investimento
CREATE TABLE Investimento(
	id INT IDENTITY(1,1) NOT NULL,
	quantia DECIMAL(15,2) NOT NULL,
    opcao NVARCHAR(25) NOT NULL,
    rendimento DECIMAL(15,2) DEFAULT 0.00,
    numConta INT NOT NULL,
    cpfUsuario BIGINT NOT NULL,
    dataInvestimento DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_Investimento PRIMARY KEY(id),
    CONSTRAINT FK_Investimento_Conta FOREIGN KEY(cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta)
);

-- Criar tabela Emprestimo
CREATE TABLE Emprestimo(
	id INT IDENTITY(1,1) NOT NULL,
	quantia DECIMAL(15,2) NOT NULL,
    juros DECIMAL(5,2) NOT NULL,
    quantiaPaga DECIMAL(15,2) DEFAULT 0.00,
    numConta INT NOT NULL,
    cpfUsuario BIGINT NOT NULL,
    dataEmprestimo DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_Emprestimo PRIMARY KEY(id),
    CONSTRAINT FK_Emprestimo_Conta FOREIGN KEY(cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta)
);

-- Criar tabela Extrato
CREATE TABLE Extrato(
	id INT IDENTITY(1,1) NOT NULL,
	valor DECIMAL(15,2) NOT NULL,
    tipo NVARCHAR(50) NOT NULL,
    dataTransacao DATETIME DEFAULT GETDATE(),
    descricao NVARCHAR(255),
    numConta INT NOT NULL,
    cpfUsuario BIGINT NOT NULL,
    CONSTRAINT PK_Extrato PRIMARY KEY(id),
    CONSTRAINT FK_Extrato_Conta FOREIGN KEY(cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta)
);