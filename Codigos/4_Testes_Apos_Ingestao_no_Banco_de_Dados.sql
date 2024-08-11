-- Testes após Ingestão de Dados no banco de dados 'hepatohub_bd'
use hepatohub_bd;

show tables;

select * from auditoria;
select * from endereco;
select * from estabelecimento_farmaceutico;
select * from estoque;
select * from medicamento;
select * from municipio;
select * from programa;
select * from programa_medicamento;
select * from uf;
select * from usuario;


-- Query de teste
-- Localizando medicamentos com palavra-chave 'METRONIDAZOL', no estado RO, onde a quantidade é MAIOR que 0.
SELECT 
    m.Cod_Catmat AS codigo_material,
    m.Desc_Produto AS descricao_produto,
    e.Logradouro AS logradouro,
    e.Numero AS numero,
    e.Bairro AS bairro,
    e.Cep AS cep,
    mu.Municipio AS cidade,
    u.Uf AS estado,
    ef.Nome_Fantasia_Estabelecimento AS nome_lugar,
    es.Qtde_Itens AS quantidade
FROM 
    Medicamento m
JOIN 
    Estoque es ON m.Id_Medicamento = es.Id_Medicamento
JOIN 
    Estabelecimento_Farmaceutico ef ON ef.Id_Estabelecimento = es.Id_Estoque
JOIN 
    Endereco e ON ef.Id_Endereco = e.Id_Endereco
JOIN 
    Municipio mu ON e.Id_Municipio = mu.Id_Municipio
JOIN 
    Uf u ON mu.Id_Uf = u.Id_Uf
WHERE 
    m.Desc_Produto LIKE '%METRONIDAZOL%'
    -- AND mu.Municipio = 'Ariquemes'
    AND u.Uf = 'RO'
    AND es.Qtde_Itens > 0;










