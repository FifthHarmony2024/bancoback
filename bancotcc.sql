CREATE DATABASE HOMMEI_FIFTHHARMONY_TCC;
USE HOMMEI_FIFTHHARMONY_TCC;

CREATE TABLE USUARIO (
    ID_USUARIO INT IDENTITY(1,1) PRIMARY KEY,
    NOME VARCHAR(35) NOT NULL,
    SOBRENOME VARCHAR(50) NOT NULL,
    SENHA VARCHAR(20) NOT NULL,
    EMAIL VARCHAR(64) NOT NULL,
    TELEFONE VARCHAR(15) NOT NULL,
    CPF CHAR(11) UNIQUE NOT NULL,
    ENDERECO VARCHAR(55) NOT NULL,
    N_RESIDENCIAL INT NOT NULL,
    BAIRRO VARCHAR(20) NOT NULL,
    COMPLEMENTO_RESI VARCHAR(15),
    CEP CHAR(8) NOT NULL,
    CIDADE VARCHAR(100) NOT NULL,
	ESTADO CHAR(25) NOT NULL,
    DATA_DE_NASCIMENTO DATE NOT NULL,
    SEXO CHAR(1) NOT NULL,
    CONF_SENHA VARCHAR(20) NOT NULL
);

CREATE TABLE CATEGORIA (
    ID_CATEGORIA INT IDENTITY(1,1) PRIMARY KEY,
    NOME_CATEGORIA VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE SERVICO (
    ID_SERV INT IDENTITY(1,1) PRIMARY KEY,
    NOME_SERVICO VARCHAR(45),
    DESCRICAO_SERVICO VARCHAR(60),
    ID_CATEGORIA INT NOT NULL,
    FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA(ID_CATEGORIA)
);

CREATE TABLE PRESTADOR (
    ID_PRESTADOR INT PRIMARY KEY IDENTITY (1,1),
    NOME_COMERCIAL VARCHAR(80) NOT NULL,
    CNPJ CHAR(14) NOT  NULL,
    ID_USUARIO INT NOT NULL,
	ID_CATEGORIA INT NOT NULL,
    ID_SERV INT NOT NULL,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
	FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA(ID_CATEGORIA),
	FOREIGN KEY ( ID_SERV) REFERENCES SERVICO(ID_SERV)
);


CREATE TABLE AGENDAMENTO (
    ID_AGENDAMENTO INT IDENTITY(1,1) PRIMARY KEY,
    DT_AGENDAMENTO DATE NOT NULL,
    HR_AGENDAMENTO TIME NOT NULL,
    VL_ORC DECIMAL(10, 2) NOT NULL
);

CREATE TABLE PEDIDO (
    ID_PEDIDO INT IDENTITY(1,1) PRIMARY KEY,
    STATUS_SERVICO VARCHAR(20) NOT NULL,
    CATEGORIA_PEDIDO VARCHAR(20) NOT NULL,
    DESCRICAO_PEDIDO VARCHAR(90) NOT NULL,
	ENDERECO VARCHAR(100) NOT NULL,
    ID_USUARIO INT NOT NULL,
    ID_AGENDAMENTO INT NOT NULL,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
    FOREIGN KEY (ID_AGENDAMENTO) REFERENCES AGENDAMENTO(ID_AGENDAMENTO)
);



CREATE TABLE AGENDA (
    ID_AGENDA INT IDENTITY(1,1) PRIMARY KEY,
    HR_DISPONIVEL TIME NOT NULL,
    HR_INDISPONIVEL TIME NOT NULL,
    DIA_SERV DATE NOT NULL,
    ID_USUARIO INT NOT NULL,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO)
);

CREATE TABLE AVALIACAO (
    ID_AVALIACAO INT IDENTITY(1,1) PRIMARY KEY,
    ID_PEDIDO INT NOT NULL,
    COMENTARIOS VARCHAR(70),
    NOTA INT NOT NULL CHECK (NOTA BETWEEN 0 AND 10),
    DT_AVALIACAO DATE NOT NULL,
    ID_USUARIO INT NOT NULL,
    FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDO(ID_PEDIDO),
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
);

CREATE TABLE CONTRATO (
    ID_CONTRATO INT IDENTITY(1,1) PRIMARY KEY,
    ID_USUARIO INT NOT NULL,
    PER_TAXA DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
);

CREATE TABLE PAGAMENTO (
    ID_PGT INT IDENTITY(1,1) PRIMARY KEY,
    VL_TAXA DECIMAL(10, 2) NOT NULL,
    FORMA_PGT VARCHAR(50) NOT NULL,
    DATA_PG DATE NOT NULL,
    VALOR DECIMAL(10, 2) NOT NULL,
    ID_CONTRATO INT NOT NULL,
    FOREIGN KEY (ID_CONTRATO) REFERENCES CONTRATO(ID_CONTRATO)
);

CREATE TABLE POSTAGEM (
    ID_POSTAGEM INT IDENTITY(1,1) PRIMARY KEY,
    URL VARCHAR(255) NOT NULL,
    DESCRICAO_POST VARCHAR(255),
    RESOLUCAO VARCHAR(50),
    TIPO_ARQUIVO VARCHAR(10),
    DT_POSTAGEM DATE NOT NULL,
    ID_USUARIO INT NOT NULL,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO)
);

CREATE TABLE PRESTADOR_SERV (
    ID_USUARIO INT,
    ID_SERV INT,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
    FOREIGN KEY (ID_SERV) REFERENCES SERVICO(ID_SERV)
);

CREATE TABLE CHAT (
    ID_CHAT INT IDENTITY(1,1) PRIMARY KEY,
	MESSAGEM_CHAT VARCHAR(255) NOT NULL,
    TIMESTAMP DATETIME DEFAULT GETDATE(),
    ID_USUARIO INT NOT NULL,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO)
);
