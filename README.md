# Banco de Dados do Site MoviTech

## Padrões – Equipe de DBA

A equipe de **DBA (Database Administration)** do projeto MoviTech é responsável pela **modelagem, criação e manutenção das tabelas e views** do sistema, garantindo desempenho, integridade e segurança das informações armazenadas.

## Objetivo do Banco de Dados

O sistema tem como objetivo **organizar e gerenciar informações relacionadas à frota**, incluindo:
- Veículos  
- Motoristas  
- Multas  
- Manutenções  
- Empréstimos  

A estrutura do banco de dados foi projetada para **facilitar consultas**, **otimizar o controle das informações** e **permitir a geração de relatórios** sobre a utilização da frota de forma prática e eficiente.

## Boas Práticas Adotadas

### Organização dos Dados (Normalização)
As tabelas são estruturadas seguindo princípios de normalização, garantindo que cada informação seja armazenada em um local específico, evitando redundâncias e inconsistências.

### Relacionamento entre Tabelas
São utilizadas **chaves primárias e estrangeiras** para relacionar dados de motoristas, veículos, multas, manutenções e empréstimos, assegurando a integridade referencial do sistema.

### Índices para Pesquisa Rápida
São criados **índices em campos frequentemente consultados**, como identificadores de motoristas e veículos, com o objetivo de melhorar o desempenho das buscas e consultas no banco de dados.

### Segurança e Controle de Acesso
O sistema define **níveis de acesso** para os usuários, garantindo que apenas pessoas autorizadas possam visualizar ou modificar determinados dados, conforme o perfil (ex.: administradores e gerentes).

## Modelo Conceitual

O banco de dados foi desenvolvido com base em um **modelo conceitual**, que representa as entidades do sistema, seus atributos e os relacionamentos entre elas, servindo como base para a criação do modelo lógico e físico.