-- Script SQL adaptado para SQL Server
-- Sistema Bancário v2

-- Criar database se não existir
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'SistemaBancario')
BEGIN
    CREATE DATABASE SistemaBancario;
END
GO

-- Usar o database
USE SistemaBancario;
GO

-- Tabela Usuario
CREATE TABLE Usuario(
    nome VARCHAR(50) NOT NULL,
    cpf INT NOT NULL,
    senha VARCHAR(50) NOT NULL,
    PRIMARY KEY(cpf)
);
GO

-- Tabela Endereco
CREATE TABLE Endereco(
    cidade VARCHAR(50) NOT NULL,
    rua VARCHAR(50) NOT NULL,
    num INT NOT NULL,
    cpfUsuario INT NOT NULL,
    PRIMARY KEY(cpfUsuario),
    FOREIGN KEY(cpfUsuario) REFERENCES Usuario(cpf)
);
GO

-- Tabela Conta
CREATE TABLE Conta(
    numConta INT NOT NULL,
    saldo DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    agencia INT NOT NULL,
    cpfUsuario INT NOT NULL,
    PRIMARY KEY(cpfUsuario, numConta),
    FOREIGN KEY(cpfUsuario) REFERENCES Usuario(cpf)
);
GO

-- Tabela Cartao
CREATE TABLE Cartao(
    numCartao INT NOT NULL,
    cvv INT NOT NULL,
    limite DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    numConta INT NOT NULL,
    cpfUsuario INT NOT NULL,
    FOREIGN KEY(cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta),
    PRIMARY KEY(numCartao)
);
GO

-- Tabela Investimento
CREATE TABLE Investimento(
    quantia DECIMAL(15,2) NOT NULL,
    opcao VARCHAR(25) NOT NULL,
    rendimento DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    numConta INT NOT NULL,
    cpfUsuario INT NOT NULL,
    FOREIGN KEY(cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta)
);
GO

-- Tabela Emprestimo
CREATE TABLE Emprestimo(
    quantia DECIMAL(15,2) NOT NULL,
    juros INT NOT NULL,
    quantiaPaga DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    numConta INT NOT NULL,
    cpfUsuario INT NOT NULL,
    FOREIGN KEY(cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta)
);
GO

-- Tabela Extrato
CREATE TABLE Extrato(
    valor DECIMAL(15,2) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    numConta INT NOT NULL,
    cpfUsuario INT NOT NULL,
    FOREIGN KEY(cpfUsuario, numConta) REFERENCES Conta(cpfUsuario, numConta)
);
GO

PRINT 'Database SistemaBancario criado com sucesso!';
GO