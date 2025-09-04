CREATE DATABASE creche_pet;
USE creche_pet;

-- Cadastro dos donos dos pets
CREATE TABLE dono (
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_dono INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(100),
    numero VARCHAR(20),
    bairro VARCHAR(100),
    cep VARCHAR(15)
);

-- Cadastro dos pets
CREATE TABLE pet (
    id_pet INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    especie ENUM('Cachorro', 'Gato', 'Outro') NOT NULL,
    raca VARCHAR(50),
    data_nascimento TIMESTAMP,
    peso DECIMAL(5,2) -- peso do pet em kg
,
    id_dono INT NOT NULL,
    observacoes VARCHAR(500),
    FOREIGN KEY (id_dono) REFERENCES dono(id_dono)
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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100),
    cpf CHAR(11) UNIQUE, -- somente números
    email VARCHAR(100),
    endereco VARCHAR(100),
    numero VARCHAR(20),
    bairro VARCHAR(100),
    cep VARCHAR(15)
    telefone VARCHAR(20),
    id_cargo INT,
    FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo)
        ON DELETE SET NULL ON UPDATE CASCADE
);

-- Turmas (agrupamentos de pets)
CREATE TABLE turma (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(500),
    hora_inicio TIME,
    hora_fim TIME,
    capacidade INT
);

-- Matrículas (pets em turmas)
CREATE TABLE matricula (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_pet INT NOT NULL,
    id_turma INT NOT NULL,
    data_matricula TIMESTAMP NOT NULL,
    ativo TINYINT(1) DEFAULT 1,
    FOREIGN KEY (id_pet) REFERENCES pet(id_pet)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_turma) REFERENCES turma(id_turma)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Serviços (banho, tosa, etc.)
CREATE TABLE servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR,
    preco DECIMAL(10,2) NOT NULL
);

-- Agendamentos de serviços
CREATE TABLE agendamento (
    id_agendamento INT AUTO_INCREMENT PRIMARY KEY,
    id_pet INT NOT NULL,
    id_servico INT NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    observacoes VARCHAR,
    FOREIGN KEY (id_pet) REFERENCES pet(id_pet)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_servico) REFERENCES servico(id_servico)
        ON DELETE CASCADE ON UPDATE CASCADE
);
