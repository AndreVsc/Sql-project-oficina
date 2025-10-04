-- SCRIPT DE INSERÇÃO DE DADOS PARA A OFICINA

USE `oficina_db`;

-- Inserindo Clientes
INSERT INTO `clientes` (`nome`, `cpf`, `telefone`, `endereco`) VALUES
('João Silva', '11122233344', '11987654321', 'Rua das Flores, 123'),
('Maria Oliveira', '55566677788', '21912345678', 'Avenida Principal, 456'),
('Carlos Pereira', '99988877766', '31998761234', 'Praça Central, 789');

-- Inserindo Veículos
INSERT INTO `veiculos` (`id_cliente`, `placa`, `marca`, `modelo`, `ano`) VALUES
(1, 'ABC1234', 'Volkswagen', 'Gol', 2020),
(2, 'DEF5678', 'Chevrolet', 'Onix', 2021),
(1, 'GHI9012', 'Ford', 'Ka', 2019),
(3, 'JKL3456', 'Fiat', 'Mobi', 2022);

-- Inserindo Mecânicos
INSERT INTO `mecanicos` (`nome`, `codigo_funcionario`, `especialidade`) VALUES
('Ricardo Alves', 'MEC001', 'Motor'),
('Fernanda Costa', 'MEC002', 'Freios e Suspensão'),
('Lucas Martins', 'MEC003', 'Elétrica'),
('Ana Beatriz', 'MEC004', 'Motor');

-- Inserindo Serviços no Catálogo
INSERT INTO `servicos` (`descricao`, `valor`) VALUES
('Troca de Óleo e Filtro', 150.00),
('Alinhamento e Balanceamento', 120.00),
('Revisão do Sistema de Freios', 250.00),
('Diagnóstico do Sistema Elétrico', 180.00);

-- Inserindo Peças no Catálogo
INSERT INTO `pecas` (`nome_peca`, `valor_unitario`) VALUES
('Óleo de Motor (Litro)', 45.00),
('Filtro de Óleo', 35.00),
('Pastilha de Freio (Par)', 95.00),
('Vela de Ignição', 25.00);

-- Criando Ordens de Serviço
INSERT INTO `ordens_servico` (`id_veiculo`, `data_emissao`, `data_conclusao`, `status`, `autorizacao_cliente`) VALUES
(1, '2025-10-01', '2025-10-02', 'Concluída', TRUE),
(2, '2025-10-03', NULL, 'Em Andamento', TRUE),
(3, '2025-10-04', NULL, 'Aguardando', FALSE);

-- Associando Serviços às Ordens de Serviço
INSERT INTO `os_servicos` (`id_ordem_servico`, `id_servico`) VALUES
(1, 1), -- OS 1: Troca de Óleo e Filtro
(2, 3), -- OS 2: Revisão do Sistema de Freios
(2, 2); -- OS 2: Alinhamento e Balanceamento

-- Associando Peças às Ordens de Serviço
INSERT INTO `os_pecas` (`id_ordem_servico`, `id_peca`, `quantidade`) VALUES
(1, 1, 4), -- OS 1: 4 Litros de Óleo
(1, 2, 1), -- OS 1: 1 Filtro de Óleo
(2, 3, 2); -- OS 2: 2 Pares de Pastilha de Freio

-- Associando Mecânicos às Ordens de Serviço (Equipe)
INSERT INTO `os_mecanicos` (`id_ordem_servico`, `id_mecanico`) VALUES
(1, 1), -- OS 1: Ricardo Alves
(2, 2), -- OS 2: Fernanda Costa
(2, 3); -- OS 2: Lucas Martins

-- Atualizando o valor total da OS 1 (Cálculo manual para exemplo)
-- (4 * 45) + (1 * 35) + 150 = 180 + 35 + 150 = 365
UPDATE `ordens_servico` SET `valor_total` = 365.00 WHERE `id_ordem_servico` = 1;

-- Atualizando o valor total da OS 2 (Cálculo manual para exemplo)
-- (2 * 95) + 250 + 120 = 190 + 250 + 120 = 560
UPDATE `ordens_servico` SET `valor_total` = 560.00 WHERE `id_ordem_servico` = 2;
