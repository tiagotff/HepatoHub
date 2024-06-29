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








