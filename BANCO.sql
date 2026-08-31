/*DROP DATABASE IF EXISTS soundwave;*/
CREATE DATABASE soundwave;
USE soundwave;

-- =========================================
-- TABELA: usuario
-- =========================================
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE),
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

-- =========================================
-- TABELA: assinatura
-- Relacionamento 1:1 com usuario
-- =========================================
CREATE TABLE assinatura (
    id_assinatura INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    tipo_plano VARCHAR(20) NOT NULL,
    valor_mensal DECIMAL(8,2) NOT NULL,
    data_inicio DATE NOT NULL,
    status_assinatura VARCHAR(20) NOT NULL DEFAULT 'ATIVA',

    CONSTRAINT chk_valor_assinatura
        CHECK (valor_mensal >= 0),

    CONSTRAINT fk_assinatura_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

-- =========================================
-- TABELA: artista
-- =========================================
CREATE TABLE artista (
    id_artista INT AUTO_INCREMENT PRIMARY KEY,
    nome_artista VARCHAR(150) NOT NULL UNIQUE,
    pais_origem VARCHAR(80),
    data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- =========================================
-- TABELA: genero
-- =========================================
CREATE TABLE genero (
    id_genero INT AUTO_INCREMENT PRIMARY KEY,
    nome_genero VARCHAR(50) NOT NULL UNIQUE
);

-- =========================================
-- TABELA: album
-- =========================================
CREATE TABLE album (
    id_album INT AUTO_INCREMENT PRIMARY KEY,
    id_artista INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    data_lancamento DATE,

    CONSTRAINT fk_album_artista
        FOREIGN KEY (id_artista)
        REFERENCES artista(id_artista)
);

-- =========================================
-- TABELA: musica
-- =========================================
CREATE TABLE musica (
    id_musica INT AUTO_INCREMENT PRIMARY KEY,
    id_album INT NOT NULL,
    id_genero INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    duracao_segundos INT NOT NULL,

    CONSTRAINT chk_duracao
        CHECK (duracao_segundos > 0),

    CONSTRAINT fk_musica_album
        FOREIGN KEY (id_album)
        REFERENCES album(id_album),

    CONSTRAINT fk_musica_genero
        FOREIGN KEY (id_genero)
        REFERENCES genero(id_genero)
);

-- =========================================
-- TABELA: playlist
-- =========================================
CREATE TABLE playlist (
    id_playlist INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    nome_playlist VARCHAR(100) NOT NULL,
    data_criacao DATE NOT NULL DEFAULT (CURRENT_DATE),

    CONSTRAINT fk_playlist_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

-- =========================================
-- TABELA ASSOCIATIVA: playlist_musica
-- Relacionamento N:N
-- =========================================
CREATE TABLE playlist_musica (
    id_playlist INT NOT NULL,
    id_musica INT NOT NULL,
    data_adicao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id_playlist, id_musica),

    CONSTRAINT fk_pm_playlist
        FOREIGN KEY (id_playlist)
        REFERENCES playlist(id_playlist),

    CONSTRAINT fk_pm_musica
        FOREIGN KEY (id_musica)
        REFERENCES musica(id_musica)
);

-- =========================================
-- TABELA: historico_reproducao
-- =========================================
CREATE TABLE historico_reproducao (
    id_reproducao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_musica INT NOT NULL,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_hist_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario),

    CONSTRAINT fk_hist_musica
        FOREIGN KEY (id_musica)
        REFERENCES musica(id_musica)
);

USE soundwave;

-- =========================================================
-- POPULAÇÃO DA TABELA: usuario
-- =========================================================

INSERT INTO usuario
(id_usuario, nome, email, data_cadastro, ativo)
VALUES
(1, 'Ana Souza', 'ana.souza@email.com', '2025-01-15', TRUE),
(2, 'Bruno Oliveira', 'bruno.oliveira@email.com', '2025-02-03', TRUE),
(3, 'Carolina Mendes', 'carolina.mendes@email.com', '2025-02-18', TRUE),
(4, 'Daniel Santos', 'daniel.santos@email.com', '2025-03-10', TRUE),
(5, 'Eduarda Lima', 'eduarda.lima@email.com', '2025-03-22', TRUE),
(6, 'Felipe Costa', 'felipe.costa@email.com', '2025-04-05', TRUE),
(7, 'Gabriela Alves', 'gabriela.alves@email.com', '2025-04-19', TRUE),
(8, 'Henrique Martins', 'henrique.martins@email.com', '2025-05-11', TRUE),
(9, 'Isabela Rocha', 'isabela.rocha@email.com', '2025-05-27', TRUE),
(10, 'João Pereira', 'joao.pereira@email.com', '2025-06-14', TRUE),
(11, 'Larissa Ferreira', 'larissa.ferreira@email.com', '2025-07-02', TRUE),
(12, 'Mateus Ribeiro', 'mateus.ribeiro@email.com', '2025-07-21', TRUE),
(13, 'Nathalia Gomes', 'nathalia.gomes@email.com', '2025-08-08', FALSE),
(14, 'Pedro Almeida', 'pedro.almeida@email.com', '2025-08-25', TRUE),
(15, 'Rafaela Cardoso', 'rafaela.cardoso@email.com', '2025-09-12', FALSE);


-- =========================================================
-- POPULAÇÃO DA TABELA: assinatura
-- =========================================================

INSERT INTO assinatura
(id_assinatura, id_usuario, tipo_plano, valor_mensal, data_inicio, status_assinatura)
VALUES
(1, 1, 'PREMIUM', 21.90, '2025-01-15', 'ATIVA'),
(2, 2, 'FAMILIA', 34.90, '2025-02-03', 'ATIVA'),
(3, 3, 'PREMIUM', 21.90, '2025-02-18', 'ATIVA'),
(4, 4, 'BASICO', 11.90, '2025-03-10', 'ATIVA'),
(5, 5, 'PREMIUM', 21.90, '2025-03-22', 'ATIVA'),
(6, 6, 'FAMILIA', 34.90, '2025-04-05', 'ATIVA'),
(7, 7, 'BASICO', 11.90, '2025-04-19', 'ATIVA'),
(8, 8, 'PREMIUM', 21.90, '2025-05-11', 'ATIVA'),
(9, 9, 'PREMIUM', 21.90, '2025-05-27', 'ATIVA'),
(10, 10, 'BASICO', 11.90, '2025-06-14', 'ATIVA'),
(11, 13, 'PREMIUM', 21.90, '2025-08-08', 'CANCELADA'),
(12, 15, 'BASICO', 11.90, '2025-09-12', 'CANCELADA');


-- =========================================================
-- POPULAÇÃO DA TABELA: artista
-- =========================================================

INSERT INTO artista
(id_artista, nome_artista, pais_origem, data_cadastro)
VALUES
(1, 'Taylor Swift', 'Estados Unidos', '2025-01-01'),
(2, 'The Weeknd', 'Canadá', '2025-01-01'),
(3, 'Billie Eilish', 'Estados Unidos', '2025-01-01'),
(4, 'Bruno Mars', 'Estados Unidos', '2025-01-02'),
(5, 'Adele', 'Reino Unido', '2025-01-02'),
(6, 'Ed Sheeran', 'Reino Unido', '2025-01-03'),
(7, 'Lady Gaga', 'Estados Unidos', '2025-01-03'),
(8, 'Coldplay', 'Reino Unido', '2025-01-04'),
(9, 'Imagine Dragons', 'Estados Unidos', '2025-01-04'),
(10, 'Arctic Monkeys', 'Reino Unido', '2025-01-05'),
(11, 'Anitta', 'Brasil', '2025-01-05'),
(12, 'Jorge & Mateus', 'Brasil', '2025-01-06'),
(13, 'Legião Urbana', 'Brasil', '2025-01-06'),
(14, 'Charlie Brown Jr.', 'Brasil', '2025-01-07'),
(15, 'Rihanna', 'Barbados', '2025-01-07');


-- =========================================================
-- POPULAÇÃO DA TABELA: genero
-- =========================================================

INSERT INTO genero
(id_genero, nome_genero)
VALUES
(1, 'Pop'),
(2, 'R&B'),
(3, 'Rock'),
(4, 'Indie Rock'),
(5, 'Sertanejo'),
(6, 'MPB'),
(7, 'Hip Hop'),
(8, 'Eletrônica'),
(9, 'Funk'),
(10, 'Alternativo');


-- =========================================================
-- POPULAÇÃO DA TABELA: album
-- =========================================================

INSERT INTO album
(id_album, id_artista, titulo, data_lancamento)
VALUES
(1, 1, '1989', '2014-10-27'),
(2, 2, 'After Hours', '2020-03-20'),
(3, 3, 'Happier Than Ever', '2021-07-30'),
(4, 4, '24K Magic', '2016-11-18'),
(5, 5, '25', '2015-11-20'),
(6, 6, 'Divide', '2017-03-03'),
(7, 7, 'The Fame', '2008-08-19'),
(8, 8, 'A Rush of Blood to the Head', '2002-08-26'),
(9, 9, 'Night Visions', '2012-09-04'),
(10, 10, 'AM', '2013-09-09'),
(11, 11, 'Versions of Me', '2022-04-12'),
(12, 12, 'A Hora é Agora', '2010-10-18'),
(13, 13, 'Dois', '1986-07-20'),
(14, 14, 'Transpiração Contínua Prolongada', '1997-04-01'),
(15, 15, 'Good Girl Gone Bad', '2007-05-31');


-- =========================================================
-- POPULAÇÃO DA TABELA: musica
-- =========================================================

INSERT INTO musica
(id_musica, id_album, id_genero, titulo, duracao_segundos)
VALUES

-- Taylor Swift - 1989
(1, 1, 1, 'Blank Space', 231),
(2, 1, 1, 'Style', 231),
(3, 1, 1, 'Shake It Off', 219),

-- The Weeknd - After Hours
(4, 2, 2, 'Blinding Lights', 200),
(5, 2, 2, 'Save Your Tears', 215),
(6, 2, 2, 'In Your Eyes', 237),

-- Billie Eilish - Happier Than Ever
(7, 3, 1, 'Happier Than Ever', 298),
(8, 3, 1, 'Therefore I Am', 174),
(9, 3, 1, 'Your Power', 245),

-- Bruno Mars - 24K Magic
(10, 4, 1, '24K Magic', 226),
(11, 4, 2, 'That’s What I Like', 206),
(12, 4, 2, 'Versace on the Floor', 261),

-- Adele - 25
(13, 5, 1, 'Hello', 295),
(14, 5, 1, 'When We Were Young', 290),
(15, 5, 1, 'Send My Love', 223),

-- Ed Sheeran - Divide
(16, 6, 1, 'Shape of You', 234),
(17, 6, 1, 'Perfect', 263),
(18, 6, 1, 'Castle on the Hill', 261),

-- Lady Gaga - The Fame
(19, 7, 1, 'Just Dance', 241),
(20, 7, 1, 'Poker Face', 238),
(21, 7, 1, 'Paparazzi', 208),

-- Coldplay - A Rush of Blood to the Head
(22, 8, 3, 'Clocks', 307),
(23, 8, 3, 'In My Place', 228),
(24, 8, 3, 'The Scientist', 309),

-- Imagine Dragons - Night Visions
(25, 9, 10, 'Radioactive', 187),
(26, 9, 10, 'Demons', 177),
(27, 9, 3, 'It’s Time', 240),

-- Arctic Monkeys - AM
(28, 10, 4, 'Do I Wanna Know?', 272),
(29, 10, 4, 'R U Mine?', 202),
(30, 10, 4, 'Arabella', 207),

-- Anitta - Versions of Me
(31, 11, 9, 'Envolver', 193),
(32, 11, 9, 'Girl From Rio', 193),
(33, 11, 9, 'Me Gusta', 191),

-- Jorge & Mateus - A Hora é Agora
(34, 12, 5, 'Amo Noite e Dia', 187),
(35, 12, 5, 'Seu Astral', 188),
(36, 12, 5, 'Aí Já Era', 189),

-- Legião Urbana - Dois
(37, 13, 3, 'Tempo Perdido', 303),
(38, 13, 3, 'Eduardo e Mônica', 261),
(39, 13, 3, 'Índios', 285),

-- Charlie Brown Jr.
(40, 14, 3, 'Proibida Pra Mim', 190),
(41, 14, 3, 'O Coro Vai Comê!', 174),
(42, 14, 3, 'Tudo Que Ela Gosta de Escutar', 181),

-- Rihanna - Good Girl Gone Bad
(43, 15, 1, 'Umbrella', 275),
(44, 15, 1, 'Don’t Stop the Music', 267),
(45, 15, 2, 'Hate That I Love You', 218);


-- =========================================================
-- POPULAÇÃO DA TABELA: playlist
-- =========================================================

INSERT INTO playlist
(id_playlist, id_usuario, nome_playlist, data_criacao)
VALUES
(1, 1, 'Minhas Favoritas', '2025-01-20'),
(2, 2, 'Músicas para Treinar', '2025-02-10'),
(3, 3, 'Pop Internacional', '2025-02-25'),
(4, 4, 'Rock Clássico', '2025-03-15'),
(5, 5, 'Viagem de Carro', '2025-04-01'),
(6, 7, 'Sertanejo', '2025-05-01'),
(7, 8, 'Brasil', '2025-05-20'),
(8, 14, 'Minha Playlist Nova', '2025-09-15');


-- =========================================================
-- POPULAÇÃO DA TABELA: playlist_musica
-- =========================================================

INSERT INTO playlist_musica
(id_playlist, id_musica, data_adicao)
VALUES

-- Playlist 1 - Minhas Favoritas
(1, 1, '2025-01-21 10:15:00'),
(1, 4, '2025-01-21 10:16:00'),
(1, 13, '2025-01-21 10:17:00'),
(1, 16, '2025-01-21 10:18:00'),
(1, 22, '2025-01-21 10:19:00'),
(1, 31, '2025-01-21 10:20:00'),
(1, 37, '2025-01-21 10:21:00'),
(1, 43, '2025-01-21 10:22:00'),

-- Playlist 2 - Músicas para Treinar
(2, 3, '2025-02-11 08:00:00'),
(2, 4, '2025-02-11 08:01:00'),
(2, 10, '2025-02-11 08:02:00'),
(2, 16, '2025-02-11 08:03:00'),
(2, 19, '2025-02-11 08:04:00'),
(2, 25, '2025-02-11 08:05:00'),
(2, 31, '2025-02-11 08:06:00'),
(2, 43, '2025-02-11 08:07:00'),

-- Playlist 3 - Pop Internacional
(3, 1, '2025-02-26 15:00:00'),
(3, 2, '2025-02-26 15:01:00'),
(3, 5, '2025-02-26 15:02:00'),
(3, 7, '2025-02-26 15:03:00'),
(3, 13, '2025-02-26 15:04:00'),
(3, 16, '2025-02-26 15:05:00'),
(3, 20, '2025-02-26 15:06:00'),
(3, 43, '2025-02-26 15:07:00'),

-- Playlist 4 - Rock Clássico
(4, 22, '2025-03-16 18:00:00'),
(4, 23, '2025-03-16 18:01:00'),
(4, 24, '2025-03-16 18:02:00'),
(4, 28, '2025-03-16 18:03:00'),
(4, 29, '2025-03-16 18:04:00'),
(4, 37, '2025-03-16 18:05:00'),
(4, 40, '2025-03-16 18:06:00'),
(4, 41, '2025-03-16 18:07:00'),

-- Playlist 5 - Viagem de Carro
(5, 4, '2025-04-02 12:00:00'),
(5, 6, '2025-04-02 12:01:00'),
(5, 18, '2025-04-02 12:02:00'),
(5, 22, '2025-04-02 12:03:00'),
(5, 27, '2025-04-02 12:04:00'),
(5, 30, '2025-04-02 12:05:00'),
(5, 35, '2025-04-02 12:06:00'),
(5, 43, '2025-04-02 12:07:00'),

-- Playlist 6 - Sertanejo
(6, 34, '2025-05-02 20:00:00'),
(6, 35, '2025-05-02 20:01:00'),
(6, 36, '2025-05-02 20:02:00'),

-- Playlist 7 - Brasil
(7, 31, '2025-05-21 14:00:00'),
(7, 34, '2025-05-21 14:01:00'),
(7, 37, '2025-05-21 14:02:00'),
(7, 38, '2025-05-21 14:03:00'),
(7, 40, '2025-05-21 14:04:00'),
(7, 42, '2025-05-21 14:05:00');

-- Playlist 8 permanece propositalmente vazia.


-- =========================================================
-- POPULAÇÃO DA TABELA: historico_reproducao
-- =========================================================

INSERT INTO historico_reproducao
(id_reproducao, id_usuario, id_musica, data_hora)
VALUES

-- Ana
(1, 1, 1, '2025-09-01 08:15:00'),
(2, 1, 4, '2025-09-01 08:19:00'),
(3, 1, 16, '2025-09-02 09:30:00'),
(4, 1, 22, '2025-09-03 18:20:00'),
(5, 1, 43, '2025-09-04 20:10:00'),

-- Bruno
(6, 2, 3, '2025-09-01 07:00:00'),
(7, 2, 10, '2025-09-01 07:05:00'),
(8, 2, 25, '2025-09-02 07:15:00'),
(9, 2, 43, '2025-09-03 07:20:00'),

-- Carolina
(10, 3, 1, '2025-09-05 10:00:00'),
(11, 3, 7, '2025-09-05 10:04:00'),
(12, 3, 13, '2025-09-06 14:30:00'),
(13, 3, 20, '2025-09-07 16:00:00'),

-- Daniel
(14, 4, 22, '2025-09-02 21:00:00'),
(15, 4, 28, '2025-09-02 21:06:00'),
(16, 4, 37, '2025-09-03 22:00:00'),
(17, 4, 40, '2025-09-04 22:05:00'),

-- Eduarda
(18, 5, 4, '2025-09-05 09:00:00'),
(19, 5, 16, '2025-09-05 09:05:00'),
(20, 5, 31, '2025-09-06 10:00:00'),
(21, 5, 35, '2025-09-07 19:00:00'),

-- Felipe
(22, 6, 10, '2025-09-01 12:00:00'),
(23, 6, 11, '2025-09-01 12:05:00'),
(24, 6, 43, '2025-09-03 13:00:00'),

-- Gabriela
(25, 7, 34, '2025-09-02 18:00:00'),
(26, 7, 35, '2025-09-02 18:04:00'),
(27, 7, 36, '2025-09-03 18:10:00'),

-- Henrique
(28, 8, 4, '2025-09-01 20:00:00'),
(29, 8, 5, '2025-09-01 20:04:00'),
(30, 8, 6, '2025-09-02 20:10:00'),
(31, 8, 43, '2025-09-04 20:00:00'),

-- Isabela
(32, 9, 13, '2025-09-05 11:00:00'),
(33, 9, 14, '2025-09-05 11:05:00'),
(34, 9, 17, '2025-09-06 11:10:00'),

-- João
(35, 10, 37, '2025-09-01 17:00:00'),
(36, 10, 38, '2025-09-01 17:06:00'),
(37, 10, 40, '2025-09-02 17:15:00'),

-- Larissa
(38, 11, 7, '2025-09-03 13:00:00'),
(39, 11, 8, '2025-09-03 13:05:00'),
(40, 11, 9, '2025-09-04 13:10:00'),

-- Mateus
(41, 12, 28, '2025-09-01 22:00:00'),
(42, 12, 29, '2025-09-01 22:05:00'),
(43, 12, 30, '2025-09-02 22:10:00'),

-- Usuário inativo com histórico antigo
(44, 13, 1, '2025-08-10 15:00:00'),
(45, 13, 4, '2025-08-11 15:05:00'),

-- Pedro
(46, 14, 31, '2025-09-10 19:00:00'),

-- Rafaela, inativa
(47, 15, 43, '2025-08-20 20:00:00');