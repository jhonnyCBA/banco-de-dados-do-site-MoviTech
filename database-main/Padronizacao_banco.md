modelo conceitual

1. Entendimento do Domínio:
Com base na descrição do problema, o sistema é voltado para o gerenciamento de frotas de veículos em uma organização. O objetivo principal é controlar motoristas, veículos, multas, empréstimos de veículos, manutenção e relatórios de uso, garantindo a eficiência e organização da frota.
2. Identificação de Entidades:
As principais entidades identificadas no domínio do problema são:
usuario
funcionario
cargo
veiculo
servico
despesa_extra

aprovacao_de_emprestimo
manutencao_de_veiculo
relatorio_de_uso
reserva_de_veiculo
status
permissao_usuario
permissao
devolucao_emprestimo
3. Definição de Atributos:
Cada entidade possui atributos que descrevem suas características. Aqui estão os atributos para cada uma:
usuario:
id_usuario INT (PRIMARY KEY)
nome VARCHAR(30)
apelido VARCHAR(60)
senha VARCHAR(50)
id_funcionario INT (FOREIGN KEY)
funcionario:
id_funcionario (PRIMARY KEY)
Nome VARCHAR(60)
Sobrenome VARCHAR(100)
cnh VARCHAR(15)
status_disponibilidade INT (FOREIGN KEY)
email VARCHAR(100) 
telefone  VARCHAR(15)
id_cargo INT (FOREIGN KEY)
cargo:
id_cargo INT (PRIMARY KEY)
nome VARCHAR(60)
serviço:
id_servico (PRIMARY KEY)
dt_inicio DATE
dt_fim DATE
valor_total FLOAT(10,2)
veiculo:
id_veiculo INT (PRIMARY KEY)
placa VARCHAR(12)
num_chassi VARCHAR(30)
id_status_dispo INT (FOREIGN KEY)
despesa_extra:
id_despesa INT (PRIMARY KEY)
id_veiculo INT (FOREIGN KEY)
motivo_despesa SMALLTEXT
valor FLOAT(10,2) 
data DATE
aprovacao_emprestimo:
id_aprovacao_emprestimo (PRIMARY KEY)
id_reserva (FOREIGN KEY)
id_funcionario_aprovacao (FOREIGN KEY)
id_status_aprovacao (FOREIGN KEY)
data DATE
hora TIME

manutencao_de_veiculo:
id_manutencao INT (PRIMARY KEY)
id_veiculo INT (FOREIGN KEY)
data_manutencao DATE
descricao_do_servico SAMALLTEXT
valor_servico FLOAT(10,2)
relatorio_de_uso:
id_relatorio_de_uso INT (PRIMARY KEY)
id_servico INT (FOREIGN KEY)
data_hora_entrega DATETIME 
id_status INT (FOREIGN KEY)
reserva:
id_reserva INT (PRIMARY KEY)
id_veiculo INT (FOREIGN KEY)
id_motorista INT (FOREIGN KEY)
data_reserva DATE
id_servico INT (FOREIGN KEY)
permissao:
id_permissao INT (PRIMARY KEY)
nome 	VARCHAR(60)
permicao_usuario:
id_permissao_usuario INT (PRIMARY KEY)
id_usuario	INT (FOREIGN KEY)
id_permissao INT (FOREIGN KEY)
status:
id_status INT
nome VARCHAR(100)
devolucao_emprestimo:
id_devolucao_entrega INT (PRIMARY KEY)
dt_entrega DATE
id_funcionario_aprovar INT(FOREIGN KEY)
id_servico INT (FOREIGN KEY)
id_status_cheklist INT(FOREIGN KEY)
