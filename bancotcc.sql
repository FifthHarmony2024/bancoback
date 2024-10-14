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

ALTER TABLE USUARIO ALTER COLUMN CPF CHAR(11) NULL;

ALTER TABLE PRESTADOR
ALTER COLUMN CNPJ CHAR(14) NULL;

ALTER TABLE USUARIO
ALTER COLUMN SENHA VARCHAR(200) NOT NULL;

ALTER TABLE USUARIO
ALTER COLUMN EMAIL_LOGIN VARCHAR(64) NOT NULL;


ALTER TABLE USUARIO
ALTER COLUMN N_RESIDENCIAL INT;


select * from USUARIO;

-- Insert das categorias

INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Assistência Técnica');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Aulas');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Reformas e Reparos');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Serviços Domésticos');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Eventos');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Saúde');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Serviços Gerais');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Transporte');
INSERT INTO CATEGORIA (NOME_CATEGORIA) VALUES ('Moda e Beleza');

select * from CATEGORIA;

select * from SERVICO;


--assistencia tecnica 
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Televisão', 'Conserto e instalação de televisores.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Ar Condicionado', 'Instalação e manutenção de ar condicionados.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aparelho de Som', 'Conserto e instalação de sistemas de som.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('DVD / Blu-Ray', 'Conserto e instalação de players de DVD e Blu-Ray.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Home Theater', 'Instalação e conserto de sistemas de home theater.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Vídeo Game', 'Conserto de consoles de videogame.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Câmera', 'Conserto de câmeras fotográficas e filmadoras.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aquecedor a Gás', 'Instalação e conserto de aquecedores a gás.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Lava Roupa', 'Serviço de conserto e instalação de máquinas de lavar roupa.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Geladeira e Freezer', 'Manutenção e instalação de geladeiras e freezers.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Fogão e Cooktop', 'Conserto e instalação de fogões e cooktops.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Micro-ondas', 'Conserto e instalação de micro-ondas.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Lava-Louça', 'Conserto e instalação de máquinas de lavar louça.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Máquina de Costura', 'Conserto e instalação de máquinas de costura.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Adega Climatizada', 'Conserto e instalação de adegas climatizadas.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Secadora de Roupas', 'Instalação e conserto de secadoras de roupas.', 10);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Cabeamento de Redes', 'Manutenção e instalação de cabeamentos de redes.', 10);

-- AULAS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aulas', 'Aulas de diversos conteúdos para aprendizado.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Idiomas', 'Aulas de idiomas como inglês, espanhol, entre outros.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Escolares e Reforço', 'Aulas de reforço para estudantes de várias disciplinas.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Concursos', 'Preparação para concursos públicos e exames de seleção.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pré-Vestibular', 'Aulas para preparar candidatos para vestibulares.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Ensino Superior', 'Aulas de disciplinas de nível superior.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Educação Especial', 'Aulas adaptadas para alunos com necessidades especiais.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Ensino Profissionalizante', 'Cursos profissionalizantes e técnico.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Saúde', 'Aulas sobre saúde e bem-estar.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Tarefas', 'Auxílio em tarefas escolares e acadêmicas.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Música', 'Aulas de música e instrumentos.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Artes', 'Aulas de várias formas de arte.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Bem-Estar', 'Atividades que promovem o bem-estar.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Artesanato', 'Aulas de técnicas de artesanato.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('TV e Teatro', 'Aulas sobre atuação e produção audiovisual.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Circo', 'Aulas sobre técnicas circenses.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Beleza', 'Aulas sobre estética e cuidados pessoais.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Paisagismo', 'Aulas sobre design de jardins e espaços externos.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Moda', 'Aulas sobre moda e tendências.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Fotografia', 'Aulas sobre técnicas de fotografia.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Esportes', 'Aulas de diferentes modalidades esportivas.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Dança', 'Aulas de dança de diferentes estilos.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Luta', 'Aulas de artes marciais e defesa pessoal.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Lazer', 'Atividades de lazer e recreação.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Jogos', 'Aulas sobre jogos e dinâmicas.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Informática', 'Aulas de informática e tecnologia.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Esportes Eletrônicos', 'Aulas sobre jogos eletrônicos competitivos.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Desenvolvimento Web', 'Aulas sobre criação e desenvolvimento de sites.', 11);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marketing Digital', 'Aulas sobre estratégias de marketing online.', 11);

-- REFORMAS E REPAROS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aluguel de Maquinário', 'Serviço de locação de maquinário para construção e reformas.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pedreiro', 'Serviços de construção e reforma feitos por pedreiro.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Arquiteto', 'Consultoria e serviços de arquitetura para projetos.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Limpeza Pós Obra', 'Serviço de limpeza após conclusão de obras e reformas.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Engenheiro', 'Consultoria e serviços de engenharia para construção e reformas.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marmoraria e Granitos', 'Serviços de instalação e manutenção de marmoraria e granitos.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Poço Artesiano', 'Serviços de perfuração e instalação de poços artesianos.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Remoção de Entulho', 'Serviço de remoção de entulho e resíduos de construção.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Empreiteiro', 'Serviços de gestão e execução de obras e reformas.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Design de Interiores', 'Consultoria e execução de projetos de design de interiores.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Segurança Eletrônica', 'Instalação e manutenção de sistemas de segurança eletrônica.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Automação Residencial', 'Serviços de automação e controle de residências.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Antenista', 'Instalação e manutenção de antenas.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Toldos e Coberturas', 'Instalação de toldos e coberturas para proteção e estética.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Decorador', 'Serviços de decoração de ambientes residenciais e comerciais.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Montador de Móveis', 'Serviço de montagem e instalação de móveis.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Paisagista', 'Consultoria e execução de projetos paisagísticos.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Jardinagem', 'Serviços de jardinagem e manutenção de jardins.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Piscina', 'Instalação e manutenção de piscinas.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Redes de Proteção', 'Instalação de redes de proteção para segurança.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Coifas e Exaustores', 'Instalação de coifas e exaustores para cozinhas.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Instalação de Papel de Parede', 'Serviço de instalação de papel de parede.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Banheira', 'Instalação e manutenção de banheiras.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Eletricista', 'Serviços de eletricidade e instalações elétricas.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Gesso e DryWall', 'Instalação de gesso e sistemas de DryWall.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pintor', 'Serviço de pintura de interiores e exteriores.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Vidraceiro', 'Serviços de instalação e manutenção de vidros.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Serralheria e Solda', 'Serviços de serralheria e soldagem de metais.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Encanador', 'Serviços de encanamento e instalações hidráulicas.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Gás', 'Instalação e manutenção de sistemas a gás.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pavimentação', 'Serviços de pavimentação de pisos e calçadas.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Dedetizador', 'Serviços de dedetização e controle de pragas.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Desentupidor', 'Serviços de desentupimento de esgotos e ralos.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marceneiro', 'Serviços de marcenaria e fabricação de móveis sob medida.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marido de Aluguel', 'Serviços gerais de manutenção e pequenas reparações.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Chaveiro', 'Serviços de chaveiro para cópias e abertura de fechaduras.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Mudanças e Carretos', 'Serviços de transporte e mudanças de móveis.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Tapeceiro', 'Serviços de tapeçaria e estofamento.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Impermeabilizador', 'Serviços de impermeabilização de superfícies.', 12);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Desinfecção', 'Serviços de desinfecção de ambientes e superfícies.', 12);

-- SERVICOS DOMESTICOS 
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Diarista', 'Serviço de limpeza e organização de residências.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Limpeza de Piscina', 'Serviço de manutenção e limpeza de piscinas.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Passadeira', 'Serviço de passar roupas.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Shopper', 'Serviço de compras assistidas e consultoria de moda.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Lavadeira', 'Serviço de lavagem de roupas e cuidados com tecidos.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Babá', 'Serviço de cuidado e supervisão de crianças.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Cozinheira', 'Serviço de preparação de refeições.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Motorista', 'Serviço de transporte de pessoas e cargas.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Organizer', 'Serviço de organização de espaços e ambientes.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Entregador', 'Serviço de entrega de produtos e correspondências.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Segurança Particular', 'Serviço de segurança pessoal e patrimonial.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Adestrador de Cães', 'Serviço de adestramento e treinamento de cães.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Passeador de Cães', 'Serviço de passeios e cuidados para cães.', 13);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Serviços para Pets em Geral', 'Serviços diversos para cuidados de animais de estimação.', 13);

--EVENTOS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Buffet Completo', 'Serviço de fornecimento de alimentação para eventos.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Churrasqueiro', 'Profissional especializado em preparar churrasco para festas.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Bartenders', 'Profissionais que servem bebidas e coquetéis em eventos.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Confeiteira', 'Profissional que prepara doces e sobremesas para festas.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Chocolateiro', 'Especialista em fazer produtos de chocolate para eventos.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Recepcionistas e Cerimonialistas', 'Profissionais que cuidam da recepção e organização do evento.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Equipamentos para Festas', 'Aluguel de equipamentos e materiais para eventos.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Garçons e Copeiras', 'Profissionais que servem alimentos e bebidas durante a festa.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Segurança', 'Profissionais responsáveis pela segurança do evento.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Celebrantes', 'Pessoas que realizam cerimônias e celebrações.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Manobristas', 'Profissionais que cuidam do estacionamento dos veículos dos convidados.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Organização de Eventos', 'Serviço completo de planejamento e execução de eventos.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Bandas e Cantores', 'Música ao vivo para animar festas.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Animação de Festas', 'Atividades e entretenimento para eventos.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Djs', 'Profissionais que tocam músicas e animam festas.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Gravação de Vídeos', 'Serviço de filmagem e produção de vídeos para eventos.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Fotografia', 'Registro fotográfico de eventos e festas.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Floristas', 'Profissionais que fornecem e arranjam flores para decoração.', 14);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Brindes e Lembrancinhas', 'Fornecimento de brindes e lembranças personalizadas para eventos.', 14);

--SAUDE 
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Cuidador de Pessoas', 'Profissional que cuida de pessoas que necessitam de assistência.', 15);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Enfermeira', 'Profissional da saúde que presta cuidados médicos a pacientes.', 15);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Psicólogo', 'Especialista em saúde mental que ajuda na compreensão de problemas emocionais e comportamentais.', 15);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Psicanalista', 'Profissional que trabalha com técnicas de psicanálise para tratar questões psicológicas.', 15);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Coach', 'Profissional que auxilia no desenvolvimento pessoal e profissional.', 15);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Doula', 'Profissional que oferece suporte emocional e físico a mulheres durante a gravidez, parto e pós-parto.', 15);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aconselhamento Conjugal e Familiar', 'Orientação para resolver conflitos e melhorar relacionamentos familiares.', 15);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Fisioterapeuta', 'Profissional que ajuda na recuperação de movimentos e na reabilitação de pacientes.', 15);

--MODA E BELEZA
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Cabeleireiros', 'Profissionais que cortam, penteiam e tratam cabelos.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Corte e costura', 'Serviços de confecção e alteração de roupas.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Design de Sobrancelhas', 'Especialista que modela e cuida das sobrancelhas.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Design de Cílios', 'Profissional que aplica extensões ou maquiagem nos cílios.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Podólogo', 'Especialista em cuidar da saúde dos pés.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Trancistas', 'Profissional que faz tranças e penteados.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Nail Design', 'Artista que cria designs decorativos em unhas.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Maquiadores', 'Profissional que aplica maquiagem em clientes.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Barbeiro', 'Especialista em cortes e cuidados de barba e cabelo masculino.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Artesanato', 'Criador de peças decorativas ou funcionais feitas à mão.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Depilação', 'Profissional que realiza a remoção de pelos do corpo.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Manicure e Pedicure', 'Especialista em cuidar das unhas das mãos e dos pés.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Micropigmentação', 'Técnica que utiliza pigmentos para corrigir falhas na pele ou nos cabelos.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Stylist', 'Consultor de imagem que ajuda a escolher roupas e acessórios.', 18);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Sapateiro', 'Profissional que faz reparos em calçados.', 18);

--TRANSPORTE 
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Mudanças', 'Serviço de transporte de móveis e pertences durante mudanças residenciais ou comerciais.', 17);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Carretos', 'Transporte de cargas menores e itens diversos.', 17);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Serviço de Motoboy', 'Entregas rápidas de documentos e pequenas encomendas por motocicleta.', 17);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Animais', 'Transporte seguro de animais de estimação.', 17);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Motorista Particular', 'Serviço de transporte pessoal com motorista.', 17);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte para Consultas/Compras', 'Serviço de transporte para levar pessoas a consultas médicas ou compras.', 17);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte Escolar', 'Transporte de estudantes para a escola.', 17);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Lixo/Entulho', 'Coleta e transporte de lixo ou entulho.', 17);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Veículos (Guincho)', 'Serviço de guincho para transporte de veículos.', 17);

--SERVICO GERAIS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Chaveiro', 'Serviço de abertura de portas, troca de fechaduras e confecção de chaves.', 16);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marido de Aluguel', 'Serviço geral de reparos e manutenção em residências.', 16);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Dedetizador', 'Serviço de controle de pragas e desinfecção de ambientes.', 16);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Lavagem de Tapetes e Sofás', 'Limpeza especializada de tapetes e sofás.', 16);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Reparação de Eletrodomésticos', 'Conserto de eletrodomésticos como geladeiras, fogões e micro-ondas.', 16);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Reparação de Aparelhos Eletrônicos', 'Conserto de aparelhos eletrônicos como TVs e sistemas de som.', 16);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Assistência Técnica de Aparelhos de Gás', 'Conserto e manutenção de equipamentos a gás.', 16);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Organizer', 'Serviço de organização de ambientes residenciais ou comerciais.', 16);

SELECT s.NOME_SERVICO 
FROM SERVICO s
JOIN CATEGORIA c ON s.ID_CATEGORIA = c.ID_CATEGORIA
WHERE c.NOME_CATEGORIA = 'Moda e Beleza';

select * from SERVICO;