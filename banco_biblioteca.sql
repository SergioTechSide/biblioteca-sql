-- DDL: Estrutura do Banco
CREATE TABLE Usuario (
    id_usuario INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(150),
    cic VARCHAR(20) NOT NULL,
    idade INTEGER,
    escolaridade VARCHAR(50)
);

CREATE TABLE Livro (
    id_livro INTEGER PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    editora VARCHAR(50),
    ano INTEGER,
    status VARCHAR(30) NOT NULL
);

CREATE TABLE Periodico (
    id_periodico INTEGER PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    editora VARCHAR(100),
    ano INTEGER,
    status VARCHAR(30) NOT NULL
);

CREATE TABLE Emprestimo (
    id_emprestimo INTEGER PRIMARY KEY,
    data_emprestimo DATE NOT NULL,
    data_devolucao_prevista DATE NOT NULL,
    data_devolucao_real DATE,
    id_usuario INTEGER NOT NULL,
    id_livro INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES Livro(id_livro)
);

CREATE TABLE Consulta (
    id_consulta INTEGER PRIMARY KEY,
    data_consulta DATE NOT NULL,
    hora_inicio VARCHAR(10),
    hora_fim VARCHAR(10),
    id_usuario INTEGER NOT NULL,
    id_livro INTEGER,
    id_periodico INTEGER,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_livro) REFERENCES Livro(id_livro),
    FOREIGN KEY (id_periodico) REFERENCES Periodico(id_periodico)
);

-- DML: Inserção dos dados
INSERT INTO Usuario VALUES 
(1, 'Maria Silva', 'Rua A, 123', '11122233344', 20, 'Ensino Superior'),
(2, 'João Pereira', 'Av. B, 456', '22233344455', 22, 'Ensino Superior'),
(3, 'Carlos Souza', 'Rua C, 789', '33344455566', 21, 'Ensino Superior'),
(4, 'Ana Oliveira', 'Av. D, 101', '44455566677', 35, 'Pós-Graduação'),
(5, 'Bruno Lima', 'Rua E, 202', '55566677788', 40, 'Doutorado');

INSERT INTO Livro VALUES 
(1, 'Sistemas de Banco de Dados', 'Elmasri & Navathe', 'Pearson', 2010, 'Emprestado'),
(2, 'Engenharia de Software', 'Roger Pressman', 'McGraw-Hill', 2011, 'Disponível'),
(3, 'Java: Como Programar', 'Deitel & Deitel', 'Pearson', 2016, 'Disponível'),
(4, 'Estruturas de Dados', 'Cormen et al.', 'Campus', 2012, 'Disponível'),
(5, 'Clean Code', 'Robert C. Martin', 'Alta Books', 2009, 'Disponível');

INSERT INTO Periodico VALUES 
(1, 'IEEE Computer Graphics', 'IEEE', 2023, 'Disponível'),
(2, 'ACM Computing Surveys', 'ACM', 2022, 'Em Consulta'),
(3, 'Revista Brasileira de Computação', 'SBC', 2024, 'Disponível'),
(4, 'Communications of the ACM', 'ACM', 2021, 'Disponível'),
(5, 'Journal of Systems and Software', 'Elsevier', 2023, 'Disponível');

INSERT INTO Emprestimo VALUES 
(1, '2026-08-01', '2026-08-15', '2026-08-10', 1, 2),
(2, '2026-08-05', '2026-08-19', NULL, 2, 1),
(3, '2026-08-10', '2026-08-24', '2026-08-18', 3, 3),
(4, '2026-08-12', '2026-08-26', NULL, 4, 4),
(5, '2026-08-15', '2026-08-29', NULL, 5, 5);

INSERT INTO Consulta VALUES 
(1, '2026-08-02', '09:00', '10:30', 1, NULL, 1),
(2, '2026-08-06', '14:00', '15:00', 2, 2, NULL),
(3, '2026-08-11', '10:00', '11:30', 3, NULL, 2),
(4, '2026-08-13', '16:00', '17:00', 4, 3, NULL),
(5, '2026-08-16', '11:00', '12:00', 5, NULL, 3);
