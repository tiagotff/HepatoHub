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

-- *********************************************************************************
-- *********************************************************************************
-- Triggers
-- Tabela Medicamento
-- Trigger para inserção na tabela Medicamento
DELIMITER //
CREATE TRIGGER trg_medicamento_insert
AFTER INSERT ON Medicamento
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Medicamento', NEW.Id_Medicamento, 'Inserção', CURRENT_USER(), JSON_OBJECT('Cod_Catmat', NEW.Cod_Catmat, 'Desc_Produto', NEW.Desc_Produto, 'Tipo_Produto', NEW.Tipo_Produto));
END;
//
DELIMITER ;

-- Trigger para atualização na tabela Medicamento
DELIMITER //
CREATE TRIGGER trg_medicamento_update
AFTER UPDATE ON Medicamento
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Medicamento', NEW.Id_Medicamento, 'Atualização', CURRENT_USER(), JSON_OBJECT('Cod_Catmat', NEW.Cod_Catmat, 'Desc_Produto', NEW.Desc_Produto, 'Tipo_Produto', NEW.Tipo_Produto));
END;
//
DELIMITER ;

-- Trigger para exclusão na tabela Medicamento
DELIMITER //
CREATE TRIGGER trg_medicamento_delete
BEFORE DELETE ON Medicamento
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Medicamento', OLD.Id_Medicamento, 'Exclusão', CURRENT_USER(), JSON_OBJECT('Cod_Catmat', OLD.Cod_Catmat, 'Desc_Produto', OLD.Desc_Produto, 'Tipo_Produto', OLD.Tipo_Produto));
    
    -- Refletir a exclusão nas tabelas relacionadas
    DELETE FROM Estoque WHERE Id_Medicamento = OLD.Id_Medicamento;
    DELETE FROM Programa_Medicamento WHERE Id_Medicamento = OLD.Id_Medicamento;
END;
//
DELIMITER ;

-- Trigger para inserção na tabela Programa
DELIMITER //
CREATE TRIGGER trg_programa_insert
AFTER INSERT ON Programa
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Programa', NEW.Id_Programa, 'Inserção', CURRENT_USER(), JSON_OBJECT('Sg_Programa_Saude', NEW.Sg_Programa_Saude, 'Desc_Programa_Saude', NEW.Desc_Programa_Saude, 'Sg_Origem', NEW.Sg_Origem));
END;
//
DELIMITER ;

-- Trigger para atualização na tabela Programa
DELIMITER //
CREATE TRIGGER trg_programa_update
AFTER UPDATE ON Programa
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Programa', NEW.Id_Programa, 'Atualização', CURRENT_USER(), JSON_OBJECT('Sg_Programa_Saude', NEW.Sg_Programa_Saude, 'Desc_Programa_Saude', NEW.Desc_Programa_Saude, 'Sg_Origem', NEW.Sg_Origem));
END;
//
DELIMITER ;

-- Trigger para exclusão na tabela Programa
DELIMITER //
CREATE TRIGGER trg_programa_delete
BEFORE DELETE ON Programa
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Programa', OLD.Id_Programa, 'Exclusão', CURRENT_USER(), JSON_OBJECT('Sg_Programa_Saude', OLD.Sg_Programa_Saude, 'Desc_Programa_Saude', OLD.Desc_Programa_Saude, 'Sg_Origem', OLD.Sg_Origem));
END;
//
DELIMITER ;

-- Trigger para inserção na tabela Estoque
DELIMITER //
CREATE TRIGGER trg_estoque_insert
AFTER INSERT ON Estoque
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Estoque', NEW.Id_Estoque, 'Inserção', CURRENT_USER(), JSON_OBJECT('Id_Medicamento', NEW.Id_Medicamento, 'Dt_Posicao_Estoque', NEW.Dt_Posicao_Estoque, 'Dt_Validade', NEW.Dt_Validade, 'Qtde_Itens', NEW.Qtde_Itens, 'Num_Lote', NEW.Num_Lote));
END;
//
DELIMITER ;

-- Trigger para atualização na tabela Estoque
DELIMITER //
CREATE TRIGGER trg_estoque_update
AFTER UPDATE ON Estoque
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Estoque', NEW.Id_Estoque, 'Atualização', CURRENT_USER(), JSON_OBJECT('Id_Medicamento', NEW.Id_Medicamento, 'Dt_Posicao_Estoque', NEW.Dt_Posicao_Estoque, 'Dt_Validade', NEW.Dt_Validade, 'Qtde_Itens', NEW.Qtde_Itens, 'Num_Lote', NEW.Num_Lote));
END;
//
DELIMITER ;

-- Trigger para exclusão na tabela Estoque
DELIMITER //
CREATE TRIGGER trg_estoque_delete
BEFORE DELETE ON Estoque
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Estoque', OLD.Id_Estoque, 'Exclusão', CURRENT_USER(), JSON_OBJECT('Id_Medicamento', OLD.Id_Medicamento, 'Dt_Posicao_Estoque', OLD.Dt_Posicao_Estoque, 'Dt_Validade', OLD.Dt_Validade, 'Qtde_Itens', OLD.Qtde_Itens, 'Num_Lote', OLD.Num_Lote));
END;
//
DELIMITER ;

-- Trigger para inserção na tabela Municipio
DELIMITER //
CREATE TRIGGER trg_municipio_insert
AFTER INSERT ON Municipio
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Municipio', NEW.Id_Municipio, 'Inserção', CURRENT_USER(), JSON_OBJECT('Cod_Municipio_Ibge', NEW.Cod_Municipio_Ibge, 'Municipio', NEW.Municipio, 'Id_Uf', NEW.Id_Uf));
END;
//
DELIMITER ;

-- Trigger para atualização na tabela Municipio
DELIMITER //
CREATE TRIGGER trg_municipio_update
AFTER UPDATE ON Municipio
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Municipio', NEW.Id_Municipio, 'Atualização', CURRENT_USER(), JSON_OBJECT('Cod_Municipio_Ibge', NEW.Cod_Municipio_Ibge, 'Municipio', NEW.Municipio, 'Id_Uf', NEW.Id_Uf));
END;
//
DELIMITER ;

-- Trigger para exclusão na tabela Municipio
DELIMITER //
CREATE TRIGGER trg_municipio_delete
BEFORE DELETE ON Municipio
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Municipio', OLD.Id_Municipio, 'Exclusão', CURRENT_USER(), JSON_OBJECT('Cod_Municipio_Ibge', OLD.Cod_Municipio_Ibge, 'Municipio', OLD.Municipio, 'Id_Uf', OLD.Id_Uf));
    
    -- Refletir a exclusão nas tabelas relacionadas
    -- Não há tabelas relacionadas nesta implementação
END;
//
DELIMITER ;

-- Trigger para inserção na tabela Endereco
DELIMITER //
CREATE TRIGGER trg_endereco_insert
AFTER INSERT ON Endereco
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Endereco', NEW.Id_Endereco, 'Inserção', CURRENT_USER(), JSON_OBJECT('Id_Municipio', NEW.Id_Municipio, 'Logradouro', NEW.Logradouro, 'Numero', NEW.Numero, 'Bairro', NEW.Bairro, 'Complemento', NEW.Complemento, 'Cep', NEW.Cep, 'Latitude', NEW.Latitude, 'Longitude', NEW.Longitude));
END;
//
DELIMITER ;

-- Trigger para atualização na tabela Endereco
DELIMITER //
CREATE TRIGGER trg_endereco_update
AFTER UPDATE ON Endereco
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Endereco', NEW.Id_Endereco, 'Atualização', CURRENT_USER(), JSON_OBJECT('Id_Municipio', NEW.Id_Municipio, 'Logradouro', NEW.Logradouro, 'Numero', NEW.Numero, 'Bairro', NEW.Bairro, 'Complemento', NEW.Complemento, 'Cep', NEW.Cep, 'Latitude', NEW.Latitude, 'Longitude', NEW.Longitude));
END;
//
DELIMITER ;

-- Trigger para exclusão na tabela Endereco
DELIMITER //
CREATE TRIGGER trg_endereco_delete
BEFORE DELETE ON Endereco
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Endereco', OLD.Id_Endereco, 'Exclusão', CURRENT_USER(), JSON_OBJECT('Id_Municipio', OLD.Id_Municipio, 'Logradouro', OLD.Logradouro, 'Numero', OLD.Numero, 'Bairro', OLD.Bairro, 'Complemento', OLD.Complemento, 'Cep', OLD.Cep, 'Latitude', OLD.Latitude, 'Longitude', OLD.Longitude));
    
    -- Refletir a exclusão nas tabelas relacionadas
    -- Não há tabelas relacionadas nesta implementação
END;
//
DELIMITER ;

-- Trigger para inserção na tabela Usuario
DELIMITER //
CREATE TRIGGER trg_usuario_insert
AFTER INSERT ON Usuario
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Usuario', NEW.Id_Usuario, 'Inserção', CURRENT_USER(), JSON_OBJECT('Nome', NEW.Nome, 'Email', NEW.Email, 'Senha', NEW.Senha, 'Tipo', NEW.Tipo, 'Id_Municipio', NEW.Id_Municipio, 'Id_Endereco', NEW.Id_Endereco, 'Telefone', NEW.Telefone));
END;
//
DELIMITER ;

-- Trigger para atualização na tabela Usuario
DELIMITER //
CREATE TRIGGER trg_usuario_update
AFTER UPDATE ON Usuario
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Usuario', NEW.Id_Usuario, 'Atualização', CURRENT_USER(), JSON_OBJECT('Nome', NEW.Nome, 'Email', NEW.Email, 'Senha', NEW.Senha, 'Tipo', NEW.Tipo, 'Id_Municipio', NEW.Id_Municipio, 'Id_Endereco', NEW.Id_Endereco, 'Telefone', NEW.Telefone));
END;
//
DELIMITER ;

-- Trigger para exclusão na tabela Usuario
DELIMITER //
CREATE TRIGGER trg_usuario_delete
BEFORE DELETE ON Usuario
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Usuario', OLD.Id_Usuario, 'Exclusão', CURRENT_USER(), JSON_OBJECT('Nome', OLD.Nome, 'Email', OLD.Email, 'Senha', OLD.Senha, 'Tipo', OLD.Tipo, 'Id_Municipio', OLD.Id_Municipio, 'Id_Endereco', OLD.Id_Endereco, 'Telefone', OLD.Telefone));
    
    -- Refletir a exclusão nas tabelas relacionadas
    -- Não há tabelas relacionadas nesta implementação
END;
//
DELIMITER ;

-- Trigger para inserção na tabela Estabelecimento_Farmaceutico
DELIMITER //
CREATE TRIGGER trg_estabelecimento_farmaceutico_insert
AFTER INSERT ON Estabelecimento_Farmaceutico
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Estabelecimento_Farmaceutico', NEW.Id_Estabelecimento, 'Inserção', CURRENT_USER(), JSON_OBJECT('Cod_Cnes_Estabelecimento', NEW.Cod_Cnes_Estabelecimento, 'Razao_Social_Estabelecimento', NEW.Razao_Social_Estabelecimento, 'Nome_Fantasia_Estabelecimento', NEW.Nome_Fantasia_Estabelecimento, 'Id_Endereco', NEW.Id_Endereco));
END;
//
DELIMITER ;

-- Trigger para atualização na tabela Estabelecimento_Farmaceutico
DELIMITER //
CREATE TRIGGER trg_estabelecimento_farmaceutico_update
AFTER UPDATE ON Estabelecimento_Farmaceutico
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Estabelecimento_Farmaceutico', NEW.Id_Estabelecimento, 'Atualização', CURRENT_USER(), JSON_OBJECT('Cod_Cnes_Estabelecimento', NEW.Cod_Cnes_Estabelecimento, 'Razao_Social_Estabelecimento', NEW.Razao_Social_Estabelecimento, 'Nome_Fantasia_Estabelecimento', NEW.Nome_Fantasia_Estabelecimento, 'Id_Endereco', NEW.Id_Endereco));
END;
//
DELIMITER ;

-- Trigger para exclusão na tabela Estabelecimento_Farmaceutico
DELIMITER //
CREATE TRIGGER trg_estabelecimento_farmaceutico_delete
BEFORE DELETE ON Estabelecimento_Farmaceutico
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('Estabelecimento_Farmaceutico', OLD.Id_Estabelecimento, 'Exclusão', CURRENT_USER(), JSON_OBJECT('Cod_Cnes_Estabelecimento', OLD.Cod_Cnes_Estabelecimento, 'Razao_Social_Estabelecimento', OLD.Razao_Social_Estabelecimento, 'Nome_Fantasia_Estabelecimento', OLD.Nome_Fantasia_Estabelecimento, 'Id_Endereco', OLD.Id_Endereco));
    
    -- Refletir a exclusão nas tabelas relacionadas
    DELETE FROM Estoque WHERE Id_Estabelecimento = OLD.Id_Estabelecimento;
END;
//
DELIMITER ;

-- Trigger para inserção na tabela UF
DELIMITER //
CREATE TRIGGER trg_uf_insert
AFTER INSERT ON UF
FOR EACH ROW
BEGIN
    DECLARE detalhes JSON;
    SET detalhes = JSON_OBJECT('Id_UF', NEW.Id_UF, 'Sigla_UF', NEW.Uf);
    
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('UF', NEW.Id_UF, 'Inserção', CURRENT_USER(), detalhes);
END;
//
DELIMITER ;

-- Trigger para atualização na tabela UF
DELIMITER //
CREATE TRIGGER trg_uf_update
AFTER UPDATE ON UF
FOR EACH ROW
BEGIN
    DECLARE detalhes JSON;
    SET detalhes = JSON_OBJECT(
        'Id_UF', NEW.Id_UF,
        'Sigla_UF_Old', OLD.Uf,
        'Sigla_UF_New', NEW.Uf
    );
    
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('UF', NEW.Id_UF, 'Atualização', CURRENT_USER(), detalhes);
END;
//
DELIMITER ;

-- Trigger para exclusão na tabela UF
DELIMITER //
CREATE TRIGGER trg_uf_delete
BEFORE DELETE ON UF
FOR EACH ROW
BEGIN
    DECLARE detalhes JSON;
    SET detalhes = JSON_OBJECT(
        'Id_UF', OLD.Id_UF,
        'Sigla_UF', OLD.Uf
    );
    
    INSERT INTO Auditoria (Nome_Tabela, Id_Registro, Acao, Usuario_Responsavel, Detalhes) 
    VALUES ('UF', OLD.Id_UF, 'Exclusão', CURRENT_USER(), detalhes);
END;
//
DELIMITER ;



-- *********************************************************************************
-- *********************************************************************************
-- Cargas de teste
-- Inserção 

-- Usar o banco de dados
USE hepatohub_bd;

-- Como está agora ?
SELECT * FROM endereco;
SELECT * FROM medicamento;
SELECT * FROM usuario;

-- DELETE FROM auditoria;
SELECT * FROM auditoria;

-- Inserir dados de teste na tabela Uf
INSERT INTO Uf (Uf) VALUES 
('RO'),
('SP');

-- Inserir dados de teste na tabela Municipio
INSERT INTO Municipio (Cod_Municipio_Ibge, Municipio, Id_Uf) VALUES 
(1100015, 'Alta Floresta D\'Oeste', 1),
(1100023, 'Ariquemes', 1);

-- Inserir dados de teste na tabela Endereco
INSERT INTO Endereco (Id_Municipio, Logradouro, Numero, Bairro, Complemento, Cep, Latitude, Longitude) VALUES 
(1, 'Rua das Flores', '123', 'Centro', 'Apto 1', '76870000', -10.9284, -62.3384),
(2, 'Avenida Brasil', '456', 'Industrial', 'Bloco B', '76870001', -9.9111, -63.0333);

-- Inserir dados de teste na tabela Usuario
INSERT INTO Usuario (Nome, Email, Senha, Tipo, Id_Municipio, Id_Endereco, Telefone) VALUES 
('João Silva', 'joao@example.com', 'senha123', 'Paciente', 1, 1, '69999999999'),
('Maria Oliveira', 'maria@example.com', 'senha456', 'Profissional de Saúde', 2, 2, '69999999988');

-- Inserir dados de teste na tabela Medicamento
INSERT INTO Medicamento (Cod_Catmat, Desc_Produto, Tipo_Produto) VALUES 
('123456', 'Paracetamol 500mg', 'A'),
('789012', 'Ibuprofeno 200mg', 'B');

-- Inserir dados de teste na tabela Estabelecimento_Farmaceutico
INSERT INTO Estabelecimento_Farmaceutico (Cod_Cnes_Estabelecimento, Razao_Social_Estabelecimento, Nome_Fantasia_Estabelecimento, Id_Endereco) VALUES 
(111222, 'Farmacia Central Ltda', 'Farmacia Central', 1),
(333444, 'Drogaria Popular S/A', 'Drogaria Popular', 2);

-- Inserir dados de teste na tabela Programa
INSERT INTO Programa (Sg_Programa_Saude, Desc_Programa_Saude, Sg_Origem) VALUES 
('PSF', 'Programa Saúde da Família', 'MS'),
('ACS', 'Agente Comunitário de Saúde', 'MS');

-- Inserir dados de teste na tabela Estoque
INSERT INTO Estoque (Id_Medicamento, Dt_Posicao_Estoque, Dt_Validade, Qtde_Itens, Num_Lote) VALUES 
(1, '2024-06-01', '2025-06-01', 100, 'Lote001'),
(2, '2024-06-02', '2025-06-02', 200, 'Lote002');

-- Inserir dados de teste na tabela Programa_Medicamento
INSERT INTO Programa_Medicamento (Id_Programa, Id_Medicamento) VALUES 
(1, 1),
(2, 2);

-- DELETE FROM auditoria;
SELECT * FROM auditoria;

SELECT * FROM programa_medicamento;

-- *********************************************************************************
-- Atualizações

-- Atualizar dados na tabela Usuario
UPDATE Usuario SET Email = 'joao_novo@example.com' WHERE Id_Usuario = 1;

-- Atualizar dados na tabela Medicamento
UPDATE Medicamento SET Desc_Produto = 'Paracetamol 750mg' WHERE Id_Medicamento = 1;

-- Atualizar dados na tabela Estoque
UPDATE Estoque SET Qtde_Itens = 150 WHERE Id_Estoque = 1;

-- *********************************************************************************
-- Deleções

-- Deletar dados na tabela Usuario
DELETE FROM Usuario WHERE Id_Usuario = 2;

-- Deletar dados na tabela Estoque
DELETE FROM Estoque WHERE Id_Medicamento = 1;

-- Deletar dados na tabela Programa_Medicamento
DELETE FROM Programa_Medicamento WHERE Id_Medicamento = 1;

-- Deletar dados na tabela Medicamento
DELETE FROM Medicamento WHERE Id_Medicamento = 1;

-- Deletar dados na tabela Estoque
DELETE FROM Estoque WHERE Id_Estoque = 2;

-- *********************************************************************************
-- Verificação das auditorias

SELECT * FROM Auditoria;

-- *********************************************************************************





-- Como está agora ?
SELECT * FROM endereco;
SELECT * FROM medicamento;
SELECT * FROM usuario;

-- *********************************************************************************
-- *********************************************************************************
-- Criação de Usuários e Testes

-- Criar usuários de teste
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'password1';
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'password2';

-- Conceder permissões necessárias
GRANT ALL PRIVILEGES ON hepatohub_bd.* TO 'user1'@'localhost';
GRANT ALL PRIVILEGES ON hepatohub_bd.* TO 'user2'@'localhost';

-- Logar como user1 e executar operações de teste
-- (Logue no MySQL como user1 e execute as operações)

-- Logar como user2 e executar operações de teste
-- (Logue no MySQL como user2 e execute as operações)

-- *********************************************************************************
-- *********************************************************************************
