-- CRIAÇÃO DO ESQUEMA LÓGICO PARA O BANCO DE DADOS DA OFICINA

CREATE SCHEMA IF NOT EXISTS `oficina_db`;
USE `oficina_db`;

-- Tabela de Clientes
CREATE TABLE `clientes` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `telefone` VARCHAR(20) NULL,
  `endereco` VARCHAR(255) NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE (`cpf`)
);

-- Tabela de Veículos
CREATE TABLE `veiculos` (
  `id_veiculo` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `placa` CHAR(7) NOT NULL,
  `marca` VARCHAR(50) NOT NULL,
  `modelo` VARCHAR(50) NOT NULL,
  `ano` INT NULL,
  PRIMARY KEY (`id_veiculo`),
  UNIQUE (`placa`),
  FOREIGN KEY (`id_cliente`) REFERENCES `clientes`(`id_cliente`)
);

-- Tabela de Mecânicos
CREATE TABLE `mecanicos` (
  `id_mecanico` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `codigo_funcionario` VARCHAR(20) NOT NULL,
  `especialidade` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_mecanico`),
  UNIQUE (`codigo_funcionario`)
);

-- Tabela de Ordens de Serviço
CREATE TABLE `ordens_servico` (
  `id_ordem_servico` INT NOT NULL AUTO_INCREMENT,
  `id_veiculo` INT NOT NULL,
  `data_emissao` DATE NOT NULL,
  `data_conclusao` DATE NULL,
  `status` ENUM('Aguardando', 'Em Andamento', 'Concluída', 'Cancelada') NOT NULL DEFAULT 'Aguardando',
  `valor_total` DECIMAL(10, 2) NULL,
  `autorizacao_cliente` BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`id_ordem_servico`),
  FOREIGN KEY (`id_veiculo`) REFERENCES `veiculos`(`id_veiculo`)
);

-- Tabela de Serviços (Catálogo)
CREATE TABLE `servicos` (
  `id_servico` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  `valor` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`id_servico`)
);

-- Tabela de Peças (Catálogo)
CREATE TABLE `pecas` (
  `id_peca` INT NOT NULL AUTO_INCREMENT,
  `nome_peca` VARCHAR(100) NOT NULL,
  `valor_unitario` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`id_peca`)
);

-- Tabela de Associação: Mecânicos em uma Ordem de Serviço (Equipe)
CREATE TABLE `os_mecanicos` (
  `id_ordem_servico` INT NOT NULL,
  `id_mecanico` INT NOT NULL,
  PRIMARY KEY (`id_ordem_servico`, `id_mecanico`),
  FOREIGN KEY (`id_ordem_servico`) REFERENCES `ordens_servico`(`id_ordem_servico`),
  FOREIGN KEY (`id_mecanico`) REFERENCES `mecanicos`(`id_mecanico`)
);

-- Tabela de Associação: Serviços realizados em uma Ordem de Serviço
CREATE TABLE `os_servicos` (
  `id_ordem_servico` INT NOT NULL,
  `id_servico` INT NOT NULL,
  PRIMARY KEY (`id_ordem_servico`, `id_servico`),
  FOREIGN KEY (`id_ordem_servico`) REFERENCES `ordens_servico`(`id_ordem_servico`),
  FOREIGN KEY (`id_servico`) REFERENCES `servicos`(`id_servico`)
);

-- Tabela de Associação: Peças utilizadas em uma Ordem de Serviço
CREATE TABLE `os_pecas` (
  `id_ordem_servico` INT NOT NULL,
  `id_peca` INT NOT NULL,
  `quantidade` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_ordem_servico`, `id_peca`),
  FOREIGN KEY (`id_ordem_servico`) REFERENCES `ordens_servico`(`id_ordem_servico`),
  FOREIGN KEY (`id_peca`) REFERENCES `pecas`(`id_peca`)
);