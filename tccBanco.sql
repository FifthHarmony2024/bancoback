CREATE DATABASE tccHOMMEI;
USE tccHOMMEI;

CREATE TABLE USUARIO (
    ID_USUARIO INT IDENTITY(1,1) PRIMARY KEY,
    NOME VARCHAR(35) NOT NULL,
    SOBRENOME VARCHAR(50) NOT NULL,
    SENHA VARCHAR(200) NOT NULL,
    EMAIL_LOGIN VARCHAR(64) NOT NULL,
    TELEFONE VARCHAR(15) NOT NULL,
    CPF CHAR(11) NULL,
    ENDERECO VARCHAR(55) NOT NULL,
    N_RESIDENCIAL INT NOT NULL,
    BAIRRO VARCHAR(20) NOT NULL,
    COMPLEMENTO_RESI VARCHAR(15),
    CEP CHAR(8) NOT NULL,
    CIDADE VARCHAR(100) NOT NULL,
    ESTADO CHAR(25) NOT NULL,
    DATA_DE_NASCIMENTO DATE NOT NULL,
    SEXO VARCHAR(20) NOT NULL,
    CONF_SENHA VARCHAR(200) NOT NULL
);


ALTER TABLE USUARIO 
ALTER COLUMN CONF_SENHA VARCHAR(200) NOT NULL;


ALTER TABLE USUARIO 
ALTER COLUMN SEXO VARCHAR(25) NULL;

CREATE TABLE CATEGORIA (
    ID_CATEGORIA INT IDENTITY(1,1) PRIMARY KEY,
    NOME_CATEGORIA VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE SERVICO (
    ID_SERV INT IDENTITY(1,1) PRIMARY KEY,
    NOME_SERVICO VARCHAR(45),
    DESCRICAO_SERVICO VARCHAR(200),
    ID_CATEGORIA INT NOT NULL,
    FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA(ID_CATEGORIA)
);

CREATE TABLE PRESTADOR (
    NOME_COMERCIAL VARCHAR(80) NOT NULL,
    CNPJ CHAR(14)  NULL,
    ID_USUARIO INT NOT NULL,
	ID_CATEGORIA INT NOT NULL,
    ID_SERV INT NOT NULL,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
	FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA(ID_CATEGORIA),
	FOREIGN KEY ( ID_SERV) REFERENCES SERVICO(ID_SERV)
);

ALTER TABLE PRESTADOR
ALTER COLUMN CNPJ VARCHAR(18) NULL; --para poder armazenar caracteres juntos


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
    NOTA INT NOT NULL CHECK (NOTA BETWEEN 0 AND 5), 
    DT_AVALIACAO DATE NOT NULL,
    ID_USUARIO INT NOT NULL,
    FOREIGN KEY (ID_PEDIDO) REFERENCES PEDIDO(ID_PEDIDO),
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
);

ALTER TABLE AVALIACAO
ADD NOTA INT NOT NULL CHECK (NOTA BETWEEN 1 AND 5);


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
    ID_CONTRATO INT NOT NULL,
    FOREIGN KEY (ID_CONTRATO) REFERENCES CONTRATO(ID_CONTRATO)
);

ALTER TABLE PAGAMENTO
ALTER COLUMN DATA_PG DATETIME NOT NULL;

ALTER TABLE PAGAMENTO
DROP COLUMN VALOR;


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

ALTER TABLE POSTAGEM
ALTER COLUMN DT_POSTAGEM DATETIME NOT NULL;

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

select * from USUARIO;


-- Insert das categorias

INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Assist ncia T cnica');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Aulas');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Reformas e Reparos');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Servi os Dom sticos');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Eventos');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Sa de');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Servi os Gerais');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Transporte');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Moda e Beleza');

select * from CATEGORIA;

select * from SERVICO;


--assistencia tecnica 
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Televis o', 'Conserto e instala  o de televisores.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Ar Condicionado', 'Instala  o e manuten  o de ar condicionados.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aparelho de Som', 'Conserto e instala  o de sistemas de som.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('DVD / Blu-Ray', 'Conserto e instala  o de players de DVD e Blu-Ray.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Home Theater', 'Instala  o e conserto de sistemas de home theater.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('V deo Game', 'Conserto de consoles de videogame.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('C mera', 'Conserto de c meras fotogr ficas e filmadoras.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aquecedor a G s', 'Instala  o e conserto de aquecedores a g s.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instala  o de Lava Roupa', 'Servi o de conserto e instala  o de m quinas de lavar roupa.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instala  o de Geladeira e Freezer', 'Manuten  o e instala  o de geladeiras e freezers.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instala  o de Fog o e Cooktop', 'Conserto e instala  o de fog es e cooktops.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instala  o de Micro-ondas', 'Conserto e instala  o de micro-ondas.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instala  o de Lava-Lou a', 'Conserto e instala  o de m quinas de lavar lou a.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instala  o de M quina de Costura', 'Conserto e instala  o de m quinas de costura.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instala  o de Adega Climatizada', 'Conserto e instala  o de adegas climatizadas.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instala  o de Secadora de Roupas', 'Instala  o e conserto de secadoras de roupas.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instala  o de Cabeamento de Redes', 'Manuten  o e instala  o de cabeamentos de redes.', 1);

-- AULAS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Idiomas', 'Aulas de idiomas como ingl s, espanhol, entre outros.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Escolares e Refor o', 'Aulas de refor o para estudantes de v rias disciplinas.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Concursos', 'Prepara  o para concursos p blicos e exames de sele  o.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pr -Vestibular', 'Aulas para preparar candidatos para vestibulares.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Ensino Superior', 'Aulas de disciplinas de n vel superior.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Educa  o Especial', 'Aulas adaptadas para alunos com necessidades especiais.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Ensino Profissionalizante', 'Cursos profissionalizantes e t cnico.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Sa de', 'Aulas sobre sa de e bem-estar.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Tarefas', 'Aux lio em tarefas escolares e acad micas.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('M sica', 'Aulas de m sica e instrumentos.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Artes', 'Aulas de v rias formas de arte.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Bem-Estar', 'Atividades que promovem o bem-estar.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Artesanato', 'Aulas de t cnicas de artesanato.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('TV e Teatro', 'Aulas sobre atua  o e produ  o audiovisual.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Circo', 'Aulas sobre t cnicas circenses.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Beleza', 'Aulas sobre est tica e cuidados pessoais.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Paisagismo', 'Aulas sobre design de jardins e espa os externos.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Moda', 'Aulas sobre moda e tend ncias.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Fotografia', 'Aulas sobre t cnicas de fotografia.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Esportes', 'Aulas de diferentes modalidades esportivas.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Dan a', 'Aulas de dan a de diferentes estilos.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Luta', 'Aulas de artes marciais e defesa pessoal.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Lazer', 'Atividades de lazer e recrea  o.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Jogos', 'Aulas sobre jogos e din micas.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Inform tica', 'Aulas de inform tica e tecnologia.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Esportes Eletr nicos', 'Aulas sobre jogos eletr nicos competitivos.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Desenvolvimento Web', 'Aulas sobre cria  o e desenvolvimento de sites.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marketing Digital', 'Aulas sobre estrat gias de marketing online.', 2);

DELETE FROM SERVICO 
WHERE NOME_SERVICO = 'Aulas' 
AND DESCRICAO_SERVICO = 'Aulas de diversos conte dos para aprendizado.' 
AND ID_CATEGORIA = 2;



-- REFORMAS E REPAROS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aluguel de Maquin rio', 'Servi o de loca  o de maquin rio para constru  o e reformas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pedreiro', 'Servi os de constru  o e reforma feitos por pedreiro.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Arquiteto', 'Consultoria e servi os de arquitetura para projetos.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Limpeza P s Obra', 'Servi o de limpeza ap s conclus o de obras e reformas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Engenheiro', 'Consultoria e servi os de engenharia para constru  o e reformas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marmoraria e Granitos', 'Servi os de instala  o e manuten  o de marmoraria e granitos.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Po o Artesiano', 'Servi os de perfura  o e instala  o de po os artesianos.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Remo  o de Entulho', 'Servi o de remo  o de entulho e res duos de constru  o.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Empreiteiro', 'Servi os de gest o e execu  o de obras e reformas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Design de Interiores', 'Consultoria e execu  o de projetos de design de interiores.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Seguran a Eletr nica', 'Instala  o e manuten  o de sistemas de seguran a eletr nica.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Automa  o Residencial', 'Servi os de automa  o e controle de resid ncias.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Antenista', 'Instala  o e manuten  o de antenas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Toldos e Coberturas', 'Instala  o de toldos e coberturas para prote  o e est tica.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Decorador', 'Servi os de decora  o de ambientes residenciais e comerciais.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Montador de M veis', 'Servi o de montagem e instala  o de m veis.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Paisagista', 'Consultoria e execu  o de projetos paisag sticos.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Jardinagem', 'Servi os de jardinagem e manuten  o de jardins.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Piscina', 'Instala  o e manuten  o de piscinas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Redes de Prote  o', 'Instala  o de redes de prote  o para seguran a.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Coifas e Exaustores', 'Instala  o de coifas e exaustores para cozinhas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Instala  o de Papel de Parede', 'Servi o de instala  o de papel de parede.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Banheira', 'Instala  o e manuten  o de banheiras.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Eletricista', 'Servi os de eletricidade e instala  es el tricas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Gesso e DryWall', 'Instala  o de gesso e sistemas de DryWall.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pintor', 'Servi o de pintura de interiores e exteriores.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Vidraceiro', 'Servi os de instala  o e manuten  o de vidros.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Serralheria e Solda', 'Servi os de serralheria e soldagem de metais.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Encanador', 'Servi os de encanamento e instala  es hidr ulicas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('G s', 'Instala  o e manuten  o de sistemas a g s.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pavimenta  o', 'Servi os de pavimenta  o de pisos e cal adas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Dedetizador', 'Servi os de dedetiza  o e controle de pragas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Desentupidor', 'Servi os de desentupimento de esgotos e ralos.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marceneiro', 'Servi os de marcenaria e fabrica  o de m veis sob medida.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marido de Aluguel', 'Servi os gerais de manuten  o e pequenas repara  es.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Chaveiro', 'Servi os de chaveiro para c pias e abertura de fechaduras.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Mudan as e Carretos', 'Servi os de transporte e mudan as de m veis.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Tapeceiro', 'Servi os de tape aria e estofamento.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Impermeabilizador', 'Servi os de impermeabiliza  o de superf cies.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Desinfec  o', 'Servi os de desinfec  o de ambientes e superf cies.', 3);

-- SERVICOS DOMESTICOS 
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Diarista', 'Servi o de limpeza e organiza  o de resid ncias.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Limpeza de Piscina', 'Servi o de manuten  o e limpeza de piscinas.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Passadeira', 'Servi o de passar roupas.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Shopper', 'Servi o de compras assistidas e consultoria de moda.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Lavadeira', 'Servi o de lavagem de roupas e cuidados com tecidos.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Bab ', 'Servi o de cuidado e supervis o de crian as.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Cozinheira', 'Servi o de prepara  o de refei  es.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Motorista', 'Servi o de transporte de pessoas e cargas.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Organizer', 'Servi o de organiza  o de espa os e ambientes.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Entregador', 'Servi o de entrega de produtos e correspond ncias.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Seguran a Particular', 'Servi o de seguran a pessoal e patrimonial.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Adestrador de C es', 'Servi o de adestramento e treinamento de c es.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Passeador de C es', 'Servi o de passeios e cuidados para c es.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Servi os para Pets em Geral', 'Servi os diversos para cuidados de animais de estima  o.', 4);

--EVENTOS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Buffet Completo', 'Servi o de fornecimento de alimenta  o para eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Churrasqueiro', 'Profissional especializado em preparar churrasco para festas.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Bartenders', 'Profissionais que servem bebidas e coquet is em eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Confeiteira', 'Profissional que prepara doces e sobremesas para festas.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Chocolateiro', 'Especialista em fazer produtos de chocolate para eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Recepcionistas e Cerimonialistas', 'Profissionais que cuidam da recep  o e organiza  o do evento.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Equipamentos para Festas', 'Aluguel de equipamentos e materiais para eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Gar ons e Copeiras', 'Profissionais que servem alimentos e bebidas durante a festa.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Seguran a', 'Profissionais respons veis pela seguran a do evento.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Celebrantes', 'Pessoas que realizam cerim nias e celebra  es.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Manobristas', 'Profissionais que cuidam do estacionamento dos ve culos dos convidados.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Organiza  o de Eventos', 'Servi o completo de planejamento e execu  o de eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Bandas e Cantores', 'M sica ao vivo para animar festas.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Anima  o de Festas', 'Atividades e entretenimento para eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Djs', 'Profissionais que tocam m sicas e animam festas.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Grava  o de V deos', 'Servi o de filmagem e produ  o de v deos para eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Fotografia', 'Registro fotogr fico de eventos e festas.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Floristas', 'Profissionais que fornecem e arranjam flores para decora  o.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Brindes e Lembrancinhas', 'Fornecimento de brindes e lembran as personalizadas para eventos.', 5);

--SAUDE 
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Cuidador de Pessoas', 'Profissional que cuida de pessoas que necessitam de assist ncia.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Enfermeira', 'Profissional da sa de que presta cuidados m dicos a pacientes.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Psic logo', 'Especialista em sa de mental que ajuda na compreens o de problemas emocionais e comportamentais.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Psicanalista', 'Profissional que trabalha com t cnicas de psican lise para tratar quest es psicol gicas.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Coach', 'Profissional que auxilia no desenvolvimento pessoal e profissional.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Doula', 'Profissional que oferece suporte emocional e f sico a mulheres durante a gravidez, parto e p s-parto.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aconselhamento Conjugal e Familiar', 'Orienta  o para resolver conflitos e melhorar relacionamentos familiares.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Fisioterapeuta', 'Profissional que ajuda na recupera  o de movimentos e na reabilita  o de pacientes.', 6);

--MODA E BELEZA
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Cabeleireiros', 'Profissionais que cortam, penteiam e tratam cabelos.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Corte e costura', 'Servi os de confec  o e altera  o de roupas.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Design de Sobrancelhas', 'Especialista que modela e cuida das sobrancelhas.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Design de C lios', 'Profissional que aplica extens es ou maquiagem nos c lios.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pod logo', 'Especialista em cuidar da sa de dos p s.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Trancistas', 'Profissional que faz tran as e penteados.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Nail Design', 'Artista que cria designs decorativos em unhas.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Maquiadores', 'Profissional que aplica maquiagem em clientes.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Barbeiro', 'Especialista em cortes e cuidados de barba e cabelo masculino.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Artesanato', 'Criador de pe as decorativas ou funcionais feitas   m o.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Depila  o', 'Profissional que realiza a remo  o de pelos do corpo.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Manicure e Pedicure', 'Especialista em cuidar das unhas das m os e dos p s.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Micropigmenta  o', 'T cnica que utiliza pigmentos para corrigir falhas na pele ou nos cabelos.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Stylist', 'Consultor de imagem que ajuda a escolher roupas e acess rios.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Sapateiro', 'Profissional que faz reparos em cal ados.', 9);

--TRANSPORTE 
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Mudan as', 'Servi o de transporte de m veis e pertences durante mudan as residenciais ou comerciais.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Carretos', 'Transporte de cargas menores e itens diversos.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Servi o de Motoboy', 'Entregas r pidas de documentos e pequenas encomendas por motocicleta.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Animais', 'Transporte seguro de animais de estima  o.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Motorista Particular', 'Servi o de transporte pessoal com motorista.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte para Consultas/Compras', 'Servi o de transporte para levar pessoas a consultas m dicas ou compras.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte Escolar', 'Transporte de estudantes para a escola.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Lixo/Entulho', 'Coleta e transporte de lixo ou entulho.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Ve culos (Guincho)', 'Servi o de guincho para transporte de ve culos.', 8);

--SERVICO GERAIS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Chaveiro', 'Servi o de abertura de portas, troca de fechaduras e confec  o de chaves.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marido de Aluguel', 'Servi o geral de reparos e manuten  o em resid ncias.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Dedetizador', 'Servi o de controle de pragas e desinfec  o de ambientes.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Lavagem de Tapetes e Sof s', 'Limpeza especializada de tapetes e sof s.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Repara  o de Eletrodom sticos', 'Conserto de eletrodom sticos como geladeiras, fog es e micro-ondas.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Repara  o de Aparelhos Eletr nicos', 'Conserto de aparelhos eletr nicos como TVs e sistemas de som.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Assist ncia T cnica de Aparelhos de G s', 'Conserto e manuten  o de equipamentos a g s.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Organizer', 'Servi o de organiza  o de ambientes residenciais ou comerciais.', 7);


select * from PRESTADOR;
