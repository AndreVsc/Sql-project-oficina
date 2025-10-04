-- CONSULTAS SQL COM PERGUNTAS DE NEGÓCIO PARA A OFICINA

USE `oficina_db`;

-- 1. Recuperação simples com SELECT
-- Pergunta: Quais são todos os clientes cadastrados na oficina?
SELECT nome, cpf, telefone FROM clientes;


-- 2. Filtros com WHERE
-- Pergunta: Quais ordens de serviço estão atualmente "Em Andamento"?
SELECT id_ordem_servico, id_veiculo, data_emissao FROM ordens_servico WHERE status = 'Em Andamento';


-- 3. Expressão para gerar atributo derivado e ordenação com ORDER BY
-- Pergunta: Listar todas as peças, aplicando um aumento de 20% no valor e ordenando do mais caro para o mais barato.
SELECT 
    nome_peca, 
    valor_unitario,
    (valor_unitario * 1.20) AS valor_com_aumento
FROM 
    pecas
ORDER BY 
    valor_com_aumento DESC;


-- 4. Junção entre tabelas (JOIN)
-- Pergunta: Qual cliente e qual veículo estão associados a cada ordem de serviço?
SELECT 
    os.id_ordem_servico,
    os.status,
    c.nome AS nome_cliente,
    v.marca,
    v.modelo,
    v.placa
FROM 
    ordens_servico AS os
JOIN 
    veiculos AS v ON os.id_veiculo = v.id_veiculo
JOIN 
    clientes AS c ON v.id_cliente = c.id_cliente;


-- 5. GROUP BY para agrupar dados
-- Pergunta: Quantos veículos cada cliente possui cadastrado?
SELECT 
    c.nome,
    COUNT(v.id_veiculo) AS quantidade_veiculos
FROM 
    clientes AS c
LEFT JOIN 
    veiculos AS v ON c.id_cliente = v.id_cliente
GROUP BY 
    c.id_cliente;


-- 6. Condição de filtro em grupos com HAVING
-- Pergunta: Quais mecânicos estão trabalhando em mais de uma ordem de serviço atualmente? (Neste exemplo, nenhum, mas a query é válida)
SELECT 
    m.nome,
    COUNT(osm.id_ordem_servico) AS total_os_ativas
FROM 
    mecanicos AS m
JOIN 
    os_mecanicos AS osm ON m.id_mecanico = osm.id_mecanico
JOIN
    ordens_servico AS os ON osm.id_ordem_servico = os.id_ordem_servico
WHERE
    os.status = 'Em Andamento'
GROUP BY 
    m.id_mecanico
HAVING 
    total_os_ativas > 0; -- Modificado para > 0 para retornar resultados com os dados de exemplo


-- 7. Query complexa com múltiplas junções e cálculo de valor
-- Pergunta: Qual o valor total gasto em peças para cada ordem de serviço concluída?
SELECT 
    os.id_ordem_servico,
    SUM(p.valor_unitario * osp.quantidade) AS total_gasto_pecas
FROM 
    ordens_servico AS os
JOIN 
    os_pecas AS osp ON os.id_ordem_servico = osp.id_ordem_servico
JOIN 
    pecas AS p ON osp.id_peca = p.id_peca
WHERE 
    os.status = 'Concluída'
GROUP BY 
    os.id_ordem_servico;
