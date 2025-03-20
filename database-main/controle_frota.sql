CREATE SCHEMA IF NOT EXISTS `controle_frota` DEFAULT CHARACTER SET utf8;
USE `controle_frota`;

CREATE TABLE IF NOT EXISTS `cargo` (
  `id_cargo` INT AUTO_INCREMENT,
  `nome` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`id_cargo`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `status` (
  `id_status` INT AUTO_INCREMENT,
  `identificador` INT DEFAULT NULL,
  `nome` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`id_status`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `funcionario` (
  `id_funcionario` INT AUTO_INCREMENT,
  `nome` VARCHAR(60) DEFAULT NULL,
  `sobrenome` VARCHAR(100) DEFAULT NULL,
  `cnh` VARCHAR(15) DEFAULT NULL,
  `status_disponibilidade` INT DEFAULT NULL,
  `id_cargo` INT DEFAULT NULL,
  `telefone` VARCHAR(15) DEFAULT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `status_id_status` INT NOT NULL,
  PRIMARY KEY (`id_funcionario`),
  INDEX (`id_cargo`),
  INDEX `fk_Funcionario_status1_idx` (`status_id_status`),
  FOREIGN KEY (`id_cargo`) REFERENCES `cargo` (`id_cargo`),
  FOREIGN KEY (`status_id_status`) REFERENCES `status` (`id_status`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` INT AUTO_INCREMENT,
  `nome` VARCHAR(100) DEFAULT NULL,
  `apelido` VARCHAR(45) DEFAULT NULL,
  `senha` VARCHAR(255) DEFAULT NULL,
  `id_funcionario` INT DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX (`id_funcionario`),
  FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_funcionario`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `veiculo` (
  `id_veiculo` INT AUTO_INCREMENT,
  `placa` VARCHAR(10) DEFAULT NULL,
  `numero_chassi` VARCHAR(20) DEFAULT NULL,
  `status_disponibilidade` TINYINT DEFAULT NULL,
  `modelo` VARCHAR(60) DEFAULT NULL,
  `marca` VARCHAR(50) DEFAULT NULL,
  `cor` VARCHAR(45) DEFAULT NULL,
  `id_status_dispo` INT NOT NULL,
  PRIMARY KEY (`id_veiculo`),
  UNIQUE INDEX (`placa`),
  UNIQUE INDEX (`numero_chassi`),
  INDEX `fk_veiculo_status1_idx` (`id_status_dispo`),
  FOREIGN KEY (`id_status_dispo`) REFERENCES `status` (`id_status`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `servico` (
  `id_servico` INT AUTO_INCREMENT,
  `dt_inicio` DATETIME DEFAULT NULL,
  `dt_fim` DATETIME DEFAULT NULL,
  `valor_total` DECIMAL(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_servico`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `despesa_extra` (
  `id_despesa_extra` INT AUTO_INCREMENT,
  `id_veiculo` INT DEFAULT NULL,
  `id_motorista` INT DEFAULT NULL,
  `motivo_multa` VARCHAR(255) DEFAULT NULL,
  `valor_multa` DECIMAL(10,2) DEFAULT NULL,
  `data_infracao` DATE DEFAULT NULL,
  PRIMARY KEY (`id_despesa_extra`),
  INDEX (`id_veiculo`),
  INDEX (`id_motorista`),
  FOREIGN KEY (`id_veiculo`) REFERENCES `veiculo` (`id_veiculo`),
  FOREIGN KEY (`id_motorista`) REFERENCES `funcionario` (`id_funcionario`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `reserva` (
  `id_reserva` INT AUTO_INCREMENT,
  `data_reserva` DATE DEFAULT NULL,
  `dt_reserva` DATE DEFAULT NULL,
  `Funcionario_id` INT NOT NULL,
  `Veiculo_id` INT NOT NULL,
  `Servico_id` INT NOT NULL,
  PRIMARY KEY (`id_reserva`),
  INDEX `fk_reserva_Funcionario1_idx` (`Funcionario_id`),
  INDEX `fk_reserva_Veiculo1_idx` (`Veiculo_id`),
  INDEX `fk_reserva_Servico1_idx` (`Servico_id`),
  FOREIGN KEY (`Funcionario_id`) REFERENCES `funcionario` (`id_funcionario`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (`Veiculo_id`) REFERENCES `veiculo` (`id_veiculo`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (`Servico_id`) REFERENCES `servico` (`id_servico`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `aprovacao_emprestimo` (
  `id` INT AUTO_INCREMENT,
  `id_reserva` INT DEFAULT NULL,
  `data_aprovacao` DATE DEFAULT NULL,
  `hora_aprovacao` TIME DEFAULT NULL,
  `id_status_apro_negado` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX (`id_reserva`),
  INDEX `fk_AprovacaoEmprestimo_status1_idx` (`id_status_apro_negado`),
  FOREIGN KEY (`id_reserva`) REFERENCES `reserva` (`id_reserva`),
  FOREIGN KEY (`id_status_apro_negado`) REFERENCES `status` (`id_status`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `devolucao_emprestimo` (
  `id_devolucao_emprestimo` INT AUTO_INCREMENT,
  `dt_entrega` DATE DEFAULT NULL,
  `id_funcionario_aprovar` INT DEFAULT NULL,
  `id_servico` INT NOT NULL,
  `id_status_chelist` INT NOT NULL,
  PRIMARY KEY (`id_devolucao_emprestimo`),
  INDEX (`id_funcionario_aprovar`),
  INDEX `fk_DevolucaoEmprestimo_Servico1_idx` (`id_servico`),
  INDEX `fk_DevolucaoEmprestimo_status1_idx` (`id_status_chelist`),
  FOREIGN KEY (`id_funcionario_aprovar`) REFERENCES `funcionario` (`id_funcionario`),
  FOREIGN KEY (`id_servico`) REFERENCES `servico` (`id_servico`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (`id_status_chelist`) REFERENCES `status` (`id_status`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `manutencao_veiculo` (
  `id_manutencao` INT AUTO_INCREMENT,
  `id_veiculo` INT DEFAULT NULL,
  `data_manutencao` DATE DEFAULT NULL,
  `descricao_servico` TEXT DEFAULT NULL,
  `valor_servico` DECIMAL(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_manutencao`),
  INDEX (`id_veiculo`),
  FOREIGN KEY (`id_veiculo`) REFERENCES `veiculo` (`id_veiculo`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `relatorio_de_uso` (
  `id_relatorio_de_uso` INT AUTO_INCREMENT,
  `id_veiculo` INT DEFAULT NULL,
  `id_motorista` INT DEFAULT NULL,
  `data_inicio` DATETIME DEFAULT NULL,
  `data_fim` DATETIME DEFAULT NULL,
  `status_checklist` TINYINT DEFAULT NULL,
  PRIMARY KEY (`id_relatorio_de_uso`),
  INDEX (`id_veiculo`),
  INDEX (`id_motorista`),
  FOREIGN KEY (`id_veiculo`) REFERENCES `veiculo` (`id_veiculo`),
  FOREIGN KEY (`id_motorista`) REFERENCES `funcionario` (`id_funcionario`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `permissao` (
  `id` INT AUTO_INCREMENT,
  `nome` VARCHAR(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `permissao_usuario` (
  `id_permissao_usuario` INT AUTO_INCREMENT,
  `Permissao_id` INT NOT NULL,
  `Usuario_id` INT NOT NULL,
  PRIMARY KEY (`id_permissao_usuario`),
  INDEX `fk_permissao_usuario_Permissao1_idx` (`Permissao_id`),
  INDEX `fk_permissao_usuario_Usuario1_idx` (`Usuario_id`),
  FOREIGN KEY (`Permissao_id`) REFERENCES `permissao` (`id`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (`Usuario_id`) REFERENCES `usuario` (`id_usuario`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- View para a tabela `cargo`
CREATE VIEW `vw_cargo` AS
SELECT `id_cargo`, `nome`
FROM `cargo`;

-- View para a tabela `status`
CREATE VIEW `vw_status` AS
SELECT `id_status`, `identificador`, `nome`
FROM `status`;

-- View para a tabela `funcionario`
CREATE VIEW `vw_funcionario` AS
SELECT `id_funcionario`, `nome`, `sobrenome`, `cnh`, `status_disponibilidade`, `id_cargo`, `telefone`, `email`, `status_id_status`
FROM `funcionario`;

-- View para a tabela `usuario`
CREATE VIEW `vw_usuario` AS
SELECT `id_usuario`, `nome`, `apelido`, `id_funcionario`
FROM `usuario`;

-- View para a tabela `veiculo`
CREATE VIEW `vw_veiculo` AS
SELECT `id_veiculo`, `placa`, `numero_chassi`, `status_disponibilidade`, `modelo`, `marca`, `cor`, `id_status_dispo`
FROM `veiculo`;

-- View para a tabela `servico`
CREATE VIEW `vw_servico` AS
SELECT `id_servico`, `dt_inicio`, `dt_fim`, `valor_total`
FROM `servico`;

-- View para a tabela `despesa_extra`
CREATE VIEW `vw_despesa_extra` AS
SELECT `id_despesa_extra`, `id_veiculo`, `id_motorista`, `motivo_multa`, `valor_multa`, `data_infracao`
FROM `despesa_extra`;

-- View para a tabela `reserva`
CREATE VIEW `vw_reserva` AS
SELECT `id_reserva`, `data_reserva`, `dt_reserva`, `Funcionario_id`, `Veiculo_id`, `Servico_id`
FROM `reserva`;

-- View para a tabela `aprovacao_emprestimo`
CREATE VIEW `vw_aprovacao_emprestimo` AS
SELECT `id`, `id_reserva`, `data_aprovacao`, `hora_aprovacao`, `id_status_apro_negado`
FROM `aprovacao_emprestimo`;

-- View para a tabela `devolucao_emprestimo`
CREATE VIEW `vw_devolucao_emprestimo` AS
SELECT `id_devolucao_emprestimo`, `dt_entrega`, `id_funcionario_aprovar`, `id_servico`, `id_status_chelist`
FROM `devolucao_emprestimo`;

-- View para a tabela `manutencao_veiculo`
CREATE VIEW `vw_manutencao_veiculo` AS
SELECT `id_manutencao`, `id_veiculo`, `data_manutencao`, `descricao_servico`, `valor_servico`
FROM `manutencao_veiculo`;

-- View para a tabela `relatorio_de_uso`
CREATE VIEW `vw_relatorio_de_uso` AS
SELECT `id_relatorio_de_uso`, `id_veiculo`, `id_motorista`, `data_inicio`, `data_fim`, `status_checklist`
FROM `relatorio_de_uso`;

-- View para a tabela `permissao`
CREATE VIEW `vw_permissao` AS
SELECT `id`, `nome`
FROM `permissao`;

-- View para a tabela `permissao_usuario`
CREATE VIEW `vw_permissao_usuario` AS
SELECT `id_permissao_usuario`, `Permissao_id`, `Usuario_id`
FROM `permissao_usuario`;

