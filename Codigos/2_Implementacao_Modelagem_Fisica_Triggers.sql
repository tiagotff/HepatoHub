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
