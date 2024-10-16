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
    CONF_SENHA VARCHAR(20) NOT NULL
);

ALTER TABLE USUARIO 
ALTER COLUMN CONF_SENHA VARCHAR(200) NOT NULL;


ALTER TABLE USUARIO 
ALTER COLUMN SEXO VARCHAR(25);

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
    ID_PRESTADOR INT PRIMARY KEY IDENTITY (1,1),
    NOME_COMERCIAL VARCHAR(80) NOT NULL,
    CNPJ CHAR(14)  NULL,
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
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Televisão', 'Conserto e instalação de televisores.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Ar Condicionado', 'Instalação e manutenção de ar condicionados.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aparelho de Som', 'Conserto e instalação de sistemas de som.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('DVD / Blu-Ray', 'Conserto e instalação de players de DVD e Blu-Ray.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Home Theater', 'Instalação e conserto de sistemas de home theater.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Vídeo Game', 'Conserto de consoles de videogame.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Câmera', 'Conserto de câmeras fotográficas e filmadoras.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aquecedor a Gás', 'Instalação e conserto de aquecedores a gás.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Lava Roupa', 'Serviço de conserto e instalação de máquinas de lavar roupa.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Geladeira e Freezer', 'Manutenção e instalação de geladeiras e freezers.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Fogão e Cooktop', 'Conserto e instalação de fogões e cooktops.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Micro-ondas', 'Conserto e instalação de micro-ondas.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Lava-Louça', 'Conserto e instalação de máquinas de lavar louça.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Máquina de Costura', 'Conserto e instalação de máquinas de costura.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Adega Climatizada', 'Conserto e instalação de adegas climatizadas.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Secadora de Roupas', 'Instalação e conserto de secadoras de roupas.', 1);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Conserto/Instalação de Cabeamento de Redes', 'Manutenção e instalação de cabeamentos de redes.', 1);

-- AULAS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aulas', 'Aulas de diversos conteúdos para aprendizado.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Idiomas', 'Aulas de idiomas como inglês, espanhol, entre outros.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Escolares e Reforço', 'Aulas de reforço para estudantes de várias disciplinas.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Concursos', 'Preparação para concursos públicos e exames de seleção.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pré-Vestibular', 'Aulas para preparar candidatos para vestibulares.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Ensino Superior', 'Aulas de disciplinas de nível superior.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Educação Especial', 'Aulas adaptadas para alunos com necessidades especiais.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Ensino Profissionalizante', 'Cursos profissionalizantes e técnico.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Saúde', 'Aulas sobre saúde e bem-estar.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Tarefas', 'Auxílio em tarefas escolares e acadêmicas.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Música', 'Aulas de música e instrumentos.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Artes', 'Aulas de várias formas de arte.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Bem-Estar', 'Atividades que promovem o bem-estar.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Artesanato', 'Aulas de técnicas de artesanato.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('TV e Teatro', 'Aulas sobre atuação e produção audiovisual.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Circo', 'Aulas sobre técnicas circenses.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Beleza', 'Aulas sobre estética e cuidados pessoais.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Paisagismo', 'Aulas sobre design de jardins e espaços externos.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Moda', 'Aulas sobre moda e tendências.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Fotografia', 'Aulas sobre técnicas de fotografia.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Esportes', 'Aulas de diferentes modalidades esportivas.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Dança', 'Aulas de dança de diferentes estilos.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Luta', 'Aulas de artes marciais e defesa pessoal.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Lazer', 'Atividades de lazer e recreação.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Jogos', 'Aulas sobre jogos e dinâmicas.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Informática', 'Aulas de informática e tecnologia.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Esportes Eletrônicos', 'Aulas sobre jogos eletrônicos competitivos.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Desenvolvimento Web', 'Aulas sobre criação e desenvolvimento de sites.', 2);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marketing Digital', 'Aulas sobre estratégias de marketing online.', 2);

-- REFORMAS E REPAROS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aluguel de Maquinário', 'Serviço de locação de maquinário para construção e reformas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pedreiro', 'Serviços de construção e reforma feitos por pedreiro.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Arquiteto', 'Consultoria e serviços de arquitetura para projetos.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Limpeza Pós Obra', 'Serviço de limpeza após conclusão de obras e reformas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Engenheiro', 'Consultoria e serviços de engenharia para construção e reformas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marmoraria e Granitos', 'Serviços de instalação e manutenção de marmoraria e granitos.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Poço Artesiano', 'Serviços de perfuração e instalação de poços artesianos.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Remoção de Entulho', 'Serviço de remoção de entulho e resíduos de construção.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Empreiteiro', 'Serviços de gestão e execução de obras e reformas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Design de Interiores', 'Consultoria e execução de projetos de design de interiores.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Segurança Eletrônica', 'Instalação e manutenção de sistemas de segurança eletrônica.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Automação Residencial', 'Serviços de automação e controle de residências.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Antenista', 'Instalação e manutenção de antenas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Toldos e Coberturas', 'Instalação de toldos e coberturas para proteção e estética.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Decorador', 'Serviços de decoração de ambientes residenciais e comerciais.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Montador de Móveis', 'Serviço de montagem e instalação de móveis.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Paisagista', 'Consultoria e execução de projetos paisagísticos.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Jardinagem', 'Serviços de jardinagem e manutenção de jardins.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Piscina', 'Instalação e manutenção de piscinas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Redes de Proteção', 'Instalação de redes de proteção para segurança.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Coifas e Exaustores', 'Instalação de coifas e exaustores para cozinhas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Instalação de Papel de Parede', 'Serviço de instalação de papel de parede.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Banheira', 'Instalação e manutenção de banheiras.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Eletricista', 'Serviços de eletricidade e instalações elétricas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Gesso e DryWall', 'Instalação de gesso e sistemas de DryWall.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pintor', 'Serviço de pintura de interiores e exteriores.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Vidraceiro', 'Serviços de instalação e manutenção de vidros.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Serralheria e Solda', 'Serviços de serralheria e soldagem de metais.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Encanador', 'Serviços de encanamento e instalações hidráulicas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Gás', 'Instalação e manutenção de sistemas a gás.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Pavimentação', 'Serviços de pavimentação de pisos e calçadas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Dedetizador', 'Serviços de dedetização e controle de pragas.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Desentupidor', 'Serviços de desentupimento de esgotos e ralos.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marceneiro', 'Serviços de marcenaria e fabricação de móveis sob medida.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marido de Aluguel', 'Serviços gerais de manutenção e pequenas reparações.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Chaveiro', 'Serviços de chaveiro para cópias e abertura de fechaduras.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Mudanças e Carretos', 'Serviços de transporte e mudanças de móveis.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Tapeceiro', 'Serviços de tapeçaria e estofamento.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Impermeabilizador', 'Serviços de impermeabilização de superfícies.', 3);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Desinfecção', 'Serviços de desinfecção de ambientes e superfícies.', 3);

-- SERVICOS DOMESTICOS 
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Diarista', 'Serviço de limpeza e organização de residências.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Limpeza de Piscina', 'Serviço de manutenção e limpeza de piscinas.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Passadeira', 'Serviço de passar roupas.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Shopper', 'Serviço de compras assistidas e consultoria de moda.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Lavadeira', 'Serviço de lavagem de roupas e cuidados com tecidos.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Babá', 'Serviço de cuidado e supervisão de crianças.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Cozinheira', 'Serviço de preparação de refeições.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Motorista', 'Serviço de transporte de pessoas e cargas.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Organizer', 'Serviço de organização de espaços e ambientes.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Entregador', 'Serviço de entrega de produtos e correspondências.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Segurança Particular', 'Serviço de segurança pessoal e patrimonial.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Adestrador de Cães', 'Serviço de adestramento e treinamento de cães.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Passeador de Cães', 'Serviço de passeios e cuidados para cães.', 4);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Serviços para Pets em Geral', 'Serviços diversos para cuidados de animais de estimação.', 4);

--EVENTOS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Buffet Completo', 'Serviço de fornecimento de alimentação para eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Churrasqueiro', 'Profissional especializado em preparar churrasco para festas.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Bartenders', 'Profissionais que servem bebidas e coquetéis em eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Confeiteira', 'Profissional que prepara doces e sobremesas para festas.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Chocolateiro', 'Especialista em fazer produtos de chocolate para eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Recepcionistas e Cerimonialistas', 'Profissionais que cuidam da recepção e organização do evento.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Equipamentos para Festas', 'Aluguel de equipamentos e materiais para eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Garçons e Copeiras', 'Profissionais que servem alimentos e bebidas durante a festa.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Segurança', 'Profissionais responsáveis pela segurança do evento.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Celebrantes', 'Pessoas que realizam cerimônias e celebrações.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Manobristas', 'Profissionais que cuidam do estacionamento dos veículos dos convidados.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Organização de Eventos', 'Serviço completo de planejamento e execução de eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Bandas e Cantores', 'Música ao vivo para animar festas.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Animação de Festas', 'Atividades e entretenimento para eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Djs', 'Profissionais que tocam músicas e animam festas.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Gravação de Vídeos', 'Serviço de filmagem e produção de vídeos para eventos.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Fotografia', 'Registro fotográfico de eventos e festas.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Floristas', 'Profissionais que fornecem e arranjam flores para decoração.', 5);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Brindes e Lembrancinhas', 'Fornecimento de brindes e lembranças personalizadas para eventos.', 5);

--SAUDE 
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Cuidador de Pessoas', 'Profissional que cuida de pessoas que necessitam de assistência.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Enfermeira', 'Profissional da saúde que presta cuidados médicos a pacientes.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Psicólogo', 'Especialista em saúde mental que ajuda na compreensão de problemas emocionais e comportamentais.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Psicanalista', 'Profissional que trabalha com técnicas de psicanálise para tratar questões psicológicas.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Coach', 'Profissional que auxilia no desenvolvimento pessoal e profissional.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Doula', 'Profissional que oferece suporte emocional e físico a mulheres durante a gravidez, parto e pós-parto.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Aconselhamento Conjugal e Familiar', 'Orientação para resolver conflitos e melhorar relacionamentos familiares.', 6);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Fisioterapeuta', 'Profissional que ajuda na recuperação de movimentos e na reabilitação de pacientes.', 6);

--MODA E BELEZA
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Cabeleireiros', 'Profissionais que cortam, penteiam e tratam cabelos.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Corte e costura', 'Serviços de confecção e alteração de roupas.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Design de Sobrancelhas', 'Especialista que modela e cuida das sobrancelhas.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Design de Cílios', 'Profissional que aplica extensões ou maquiagem nos cílios.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Podólogo', 'Especialista em cuidar da saúde dos pés.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Trancistas', 'Profissional que faz tranças e penteados.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Nail Design', 'Artista que cria designs decorativos em unhas.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Maquiadores', 'Profissional que aplica maquiagem em clientes.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Barbeiro', 'Especialista em cortes e cuidados de barba e cabelo masculino.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Artesanato', 'Criador de peças decorativas ou funcionais feitas à mão.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Depilação', 'Profissional que realiza a remoção de pelos do corpo.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Manicure e Pedicure', 'Especialista em cuidar das unhas das mãos e dos pés.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Micropigmentação', 'Técnica que utiliza pigmentos para corrigir falhas na pele ou nos cabelos.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Stylist', 'Consultor de imagem que ajuda a escolher roupas e acessórios.', 9);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Sapateiro', 'Profissional que faz reparos em calçados.', 9);

--TRANSPORTE 
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Mudanças', 'Serviço de transporte de móveis e pertences durante mudanças residenciais ou comerciais.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Carretos', 'Transporte de cargas menores e itens diversos.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Serviço de Motoboy', 'Entregas rápidas de documentos e pequenas encomendas por motocicleta.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Animais', 'Transporte seguro de animais de estimação.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Motorista Particular', 'Serviço de transporte pessoal com motorista.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte para Consultas/Compras', 'Serviço de transporte para levar pessoas a consultas médicas ou compras.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte Escolar', 'Transporte de estudantes para a escola.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Lixo/Entulho', 'Coleta e transporte de lixo ou entulho.', 8);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Transporte de Veículos (Guincho)', 'Serviço de guincho para transporte de veículos.', 8);

--SERVICO GERAIS
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Chaveiro', 'Serviço de abertura de portas, troca de fechaduras e confecção de chaves.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Marido de Aluguel', 'Serviço geral de reparos e manutenção em residências.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Dedetizador', 'Serviço de controle de pragas e desinfecção de ambientes.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Lavagem de Tapetes e Sofás', 'Limpeza especializada de tapetes e sofás.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Reparação de Eletrodomésticos', 'Conserto de eletrodomésticos como geladeiras, fogões e micro-ondas.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Reparação de Aparelhos Eletrônicos', 'Conserto de aparelhos eletrônicos como TVs e sistemas de som.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Assistência Técnica de Aparelhos de Gás', 'Conserto e manutenção de equipamentos a gás.', 7);
INSERT INTO SERVICO (NOME_SERVICO, DESCRICAO_SERVICO, ID_CATEGORIA) VALUES ('Personal Organizer', 'Serviço de organização de ambientes residenciais ou comerciais.', 7);

SELECT s.NOME_SERVICO 
FROM SERVICO s
JOIN CATEGORIA c ON s.ID_CATEGORIA = c.ID_CATEGORIA
WHERE c.NOME_CATEGORIA = 'Moda e Beleza';

select * from USUARIO;

