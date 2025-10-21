-- =============================================
-- CRIAR BANCO E TABELAS - SQL SERVER
-- Execute este script completo no SSMS
-- =============================================

-- 1. CRIAR O BANCO DE DADOS
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'banco')
BEGIN
    CREATE DATABASE banco;
    PRINT 'Database "banco" criado com sucesso!';
END
ELSE
BEGIN
    PRINT 'Database "banco" já existe.';
END
GO

-- 2. USAR O BANCO CRIADO
USE banco;
GO

-- 3. CRIAR TABELAS
PRINT 'Criando tabelas...';

CREATE TABLE Usuario (
	nome VARCHAR(50),
    cpf INT NOT NULL,
    senha VARCHAR(50),
	CONSTRAINT PK_Usuario PRIMARY KEY (cpf)
);

CREATE TABLE Endereco (
	cidade VARCHAR(50),
    rua VARCHAR(50),
    num INT,
    cpfUsuario INT NOT NULL,
    CONSTRAINT PK_Endereco PRIMARY KEY (cpfUsuario),
    CONSTRAINT FK_Endereco_Usuario FOREIGN KEY (cpfUsuario) REFERENCES Usuario(cpf)
);

CREATE TABLE Conta (
	numConta INT NOT NULL,
    saldo DECIMAL(15,2),
    agencia INT,
    cpfUsuario INT NOT NULL,
    CONSTRAINT PK_Conta PRIMARY KEY (cpfUsuario, numConta),
    CONSTRAINT FK_Conta_Usuario FOREIGN KEY (cpfUsuario) REFERENCES Usuario(cpf)
);

CREATE TABLE Cartao (
	numCartao INT NOT NULL,
    cvv INT,
    limite DECIMAL(15,2),
    numConta INT NOT NULL,
    cpfUsuario INT NOT NULL,
	CONSTRAINT PK_Cartao PRIMARY KEY (numCartao),
    CONSTRAINT FK_Cartao_Conta FOREIGN KEY (cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta)
);

CREATE TABLE Investimento (
	quantia DECIMAL(15,2),
    opcao VARCHAR(25),
    rendimento DECIMAL(15,2),
    numConta INT NOT NULL,
    cpfUsuario INT NOT NULL,
    CONSTRAINT FK_Investimento_Conta FOREIGN KEY (cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta)
);

CREATE TABLE Emprestimo (
	quantia DECIMAL(15,2),
    juros DECIMAL(5,2),
    quantiaPaga DECIMAL(15,2),
    numConta INT NOT NULL,
    cpfUsuario INT NOT NULL,
    CONSTRAINT FK_Emprestimo_Conta FOREIGN KEY (cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta)
);

CREATE TABLE Extrato (
	valor DECIMAL(15,2),
    tipo VARCHAR(50),
    numConta INT NOT NULL,
    cpfUsuario INT NOT NULL,
    CONSTRAINT FK_Extrato_Conta FOREIGN KEY (cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta)
);