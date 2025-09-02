CREATE DATABASE creche_pet;
USE creche_pet;

-- Cadastro dos donos dos pets
CREATE TABLE dono (
    id_dono INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR,
    numero VARCHAR,
    bairro VARCHAR,
    cep VARCHAR
);

-- Cadastro dos pets
CREATE TABLE pet (
    id_pet INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    especie ENUM('Cachorro', 'Gato', 'Outro') NOT NULL,
    raca VARCHAR(50),
    data_nascimento DATE,
    peso DECIMAL(5,2),
    id_dono INT NOT NULL,
    observacoes VARCHAR,
    FOREIGN KEY (id_dono) REFERENCES donos(id_dono)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Cargos dos funcionários
CREATE TABLE cargo (
    id_cargo INT AUTO_INCREMENT PRIMARY KEY,
    funcao VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2) NOT NULL
);

-- Funcionários da creche
CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100),
    cpf CHAR(11) UNIQUE, -- somente números
    email VARCHAR(100),
    endereco VARCHAR,
    numero VARCHAR,
    bairro VARCHAR,
    cep CHAR(8),
    telefone VARCHAR(20),
    id_cargo INT,
    FOREIGN KEY (id_cargo) REFERENCES cargos(id_cargo)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Turmas (agrupamentos de pets)
CREATE TABLE turma (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR,
    hora_inicio TIME,
    hora_fim TIME,
    capacidade INT
);

-- Matrículas (pets em turmas)
CREATE TABLE matricula (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_pet INT NOT NULL,
    id_turma INT NOT NULL,
    data_matricula DATE NOT NULL,
    ativo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_pet) REFERENCES pets(id_pet)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Mensalidades (pagamentos das matrículas)
CREATE TABLE mensalidade (
    id_mensalidade INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE, -- se NULL => pendente
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Frequência (controle de presença dos pets nas turmas)
CREATE TABLE frequencia (
    id_frequencia INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT NOT NULL,
    data DATE NOT NULL,
    status ENUM('Presente','Faltou','Justificado') NOT NULL DEFAULT 'Presente',
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Serviços oferecidos (banho, tosa, recreação, etc.)
CREATE TABLE servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR,
    preco DECIMAL(8,2)
);

-- Registro de atividades/diárias dos pets
CREATE TABLE atividade (
    id_atividade INT AUTO_INCREMENT PRIMARY KEY,
    id_pet INT NOT NULL,
    id_funcionario INT,
    id_servico INT,
    data DATE NOT NULL,
    observacoes VARCHAR,
    FOREIGN KEY (id_pet) REFERENCES pets(id_pet)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Histórico de saúde e vacinas
CREATE TABLE saude (
    id_saude INT AUTO_INCREMENT PRIMARY KEY,
    id_pet INT NOT NULL,
    tipo_registro ENUM('Vacina', 'Doença', 'Consulta', 'Outro'),
    descricao VARCHAR,
    data DATE,
    FOREIGN KEY (id_pet) REFERENCES pets(id_pet)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Índices úteis (performance em consultas)
CREATE INDEX idx_pet_dono ON pets(id_dono);
CREATE INDEX idx_matricula_pet ON matriculas(id_pet);
CREATE INDEX idx_matricula_turma ON matriculas(id_turma);
CREATE INDEX idx_mensalidade_matricula ON mensalidades(id_matricula);