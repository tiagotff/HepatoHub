-- Apagar Banco de Dados
DROP DATABASE hepatohub_bd;

-- Create the database
CREATE DATABASE hepatohub_bd;

-- Use the database
USE hepatohub_bd;

-- Create the Uf table
CREATE TABLE Uf (
    Id_Uf INT PRIMARY KEY AUTO_INCREMENT,
    Uf CHAR(2)
);

-- Create the Municipio table
CREATE TABLE Municipio (
    Id_Municipio INT PRIMARY KEY AUTO_INCREMENT,
    Cod_Municipio_Ibge INT,
    Municipio VARCHAR(50),
    Id_Uf INT,
    FOREIGN KEY (Id_Uf) REFERENCES Uf(Id_Uf)
);

-- Create the Endereco table
CREATE TABLE Endereco (
    Id_Endereco INT PRIMARY KEY AUTO_INCREMENT,
    Id_Municipio INT,
    Logradouro VARCHAR(100),
    Numero VARCHAR(7),
    Bairro VARCHAR(25),
    Complemento VARCHAR(10),
    Cep CHAR(8),
    Latitude DECIMAL(10, 8),
    Longitude DECIMAL(10, 8),
    FOREIGN KEY (Id_Municipio) REFERENCES Municipio(Id_Municipio)
);

-- Create the Usuario table
CREATE TABLE Usuario (
    Id_Usuario INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Email VARCHAR(50),
    Senha VARCHAR(14),
    Tipo VARCHAR(25),
    Id_Municipio INT,
    Id_Endereco INT,
    Telefone CHAR(12),
    FOREIGN KEY (Id_Municipio) REFERENCES Municipio(Id_Municipio),
    FOREIGN KEY (Id_Endereco) REFERENCES Endereco(Id_Endereco)
);

-- Create the Estabelecimento_Farmaceutico table
CREATE TABLE Estabelecimento_Farmaceutico (
    Id_Estabelecimento INT PRIMARY KEY AUTO_INCREMENT,
    Cod_Cnes_Estabelecimento INT,
    Razao_Social_Estabelecimento VARCHAR(100),
    Nome_Fantasia_Estabelecimento VARCHAR(100),
    Id_Endereco INT,
    FOREIGN KEY (Id_Endereco) REFERENCES Endereco(Id_Endereco)
);

-- Create the Programa table
CREATE TABLE Programa (
    Id_Programa INT PRIMARY KEY AUTO_INCREMENT,
    Sg_Programa_Saude VARCHAR(10),
    Desc_Programa_Saude VARCHAR(50),
    Sg_Origem VARCHAR(10)
);

-- Create the Medicamento table
CREATE TABLE Medicamento (
    Id_Medicamento INT PRIMARY KEY AUTO_INCREMENT,
    Cod_Catmat VARCHAR(25),
    Desc_Produto VARCHAR(255),
    Tipo_Produto CHAR(1)
);

-- Create the Estoque table
CREATE TABLE Estoque (
    Id_Estoque INT PRIMARY KEY AUTO_INCREMENT,
    Id_Medicamento INT,
    Dt_Posicao_Estoque DATE,
    Dt_Validade DATE,
    Qtde_Itens INT,
    Num_Lote VARCHAR(50),
    FOREIGN KEY (Id_Medicamento) REFERENCES Medicamento(Id_Medicamento)
);

-- Create the Auditoria table
CREATE TABLE Auditoria (
    Id_Auditoria INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Tabela VARCHAR(50),
    Id_Registro INT,
    Acao VARCHAR(15),
    Usuario_Responsavel VARCHAR(50),
    Detalhes JSON,
    Dt_Alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the Programa_Medicamento table to represent the N:N relationship
CREATE TABLE Programa_Medicamento (
    Id_Programa INT,
    Id_Medicamento INT,
    PRIMARY KEY (Id_Programa, Id_Medicamento),
    FOREIGN KEY (Id_Programa) REFERENCES Programa(Id_Programa),
    FOREIGN KEY (Id_Medicamento) REFERENCES Medicamento(Id_Medicamento)
);