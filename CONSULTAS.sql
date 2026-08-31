/*1 - Quais são as músicas mais reproduzidas na plataforma?
Esta consulta exibe as músicas mais reproduzidas da plataforma. 
A tabela musica é relacionada ao historico_reproducao, a função 
COUNT() contabiliza as reproduções de cada música, o GROUP BY 
agrupa os resultados por música e o ORDER BY organiza da mais 
reproduzida para a menos reproduzida.*/
SELECT
    m.titulo,
    COUNT(h.id_reproducao) AS total_reproducoes
FROM musica m
INNER JOIN historico_reproducao h
    ON h.id_musica = m.id_musica
GROUP BY m.id_musica, m.titulo
ORDER BY total_reproducoes DESC;

/*2 - Quais artistas possuem mais músicas cadastradas?
Esta consulta mostra quais artistas possuem mais músicas cadastradas 
na plataforma. As tabelas artista, album e musica são relacionadas 
por meio de INNER JOIN, a função COUNT() contabiliza a quantidade de 
músicas de cada artista, o GROUP BY realiza o agrupamento por artista 
e o ORDER BY organiza o resultado do artista com mais músicas para 
o que possui menos.*/
SELECT
    a.nome_artista,
    COUNT(m.id_musica) AS total_musicas
FROM artista a
INNER JOIN album al
    ON al.id_artista = a.id_artista
INNER JOIN musica m
    ON m.id_album = al.id_album
GROUP BY a.id_artista, a.nome_artista
ORDER BY total_musicas DESC;

/*3 - Quantas músicas existem por gênero musical?
Esta consulta mostra a quantidade de músicas cadastradas em cada gênero musical. 
A tabela genero é relacionada à tabela musica através de um LEFT JOIN, 
garantindo que gêneros sem músicas também sejam exibidos. A função COUNT() 
contabiliza as músicas de cada gênero, o GROUP BY realiza o agrupamento e o 
ORDER BY organiza do gênero com mais músicas para o que possui menos.*/
SELECT
    g.nome_genero,
    COUNT(m.id_musica) AS quantidade_musicas
FROM genero g
LEFT JOIN musica m
    ON m.id_genero = g.id_genero
GROUP BY g.id_genero, g.nome_genero
ORDER BY quantidade_musicas DESC;

/*4 - Quais playlists possuem mais músicas?
Esta consulta identifica quais playlists possuem mais músicas cadastradas. 
A tabela playlist é relacionada à tabela playlist_musica por meio de um 
LEFT JOIN, permitindo que playlists sem músicas também sejam exibidas. A 
função COUNT() contabiliza as músicas de cada playlist, o GROUP BY 
agrupa os resultados e o ORDER BY organiza da playlist com mais músicas 
para a que possui menos.*/
SELECT
    p.nome_playlist,
    COUNT(pm.id_musica) AS quantidade_musicas
FROM playlist p
LEFT JOIN playlist_musica pm
    ON pm.id_playlist = p.id_playlist
GROUP BY p.id_playlist, p.nome_playlist
ORDER BY quantidade_musicas DESC;

/*5 - Quais usuários não possuem assinatura?
Esta consulta identifica os usuários que não possuem assinatura cadastrada.
A tabela usuario é relacionada à tabela assinatura por meio de um LEFT JOIN, 
permitindo exibir todos os usuários. O filtro WHERE a.id_assinatura IS NULL 
seleciona apenas aqueles que não possuem registro de assinatura.*/
SELECT
    u.nome,
    u.email
FROM usuario u
LEFT JOIN assinatura a
    ON a.id_usuario = u.id_usuario
WHERE a.id_assinatura IS NULL;

/*6 - Quais músicas nunca foram reproduzidas?
Esta consulta identifica as músicas que nunca foram reproduzidas na plataforma. 
A tabela musica é relacionada à tabela historico_reproducao por meio de um 
LEFT JOIN, permitindo exibir todas as músicas. O filtro WHERE h.id_reproducao 
IS NULL retorna apenas as músicas que não possuem registros de reprodução.*/
SELECT
    m.titulo
FROM musica m
LEFT JOIN historico_reproducao h
    ON h.id_musica = m.id_musica
WHERE h.id_reproducao IS NULL;

/*7 - Quais artistas tiveram músicas reproduzidas na plataforma?
Esta consulta identifica quais artistas possuem músicas que já foram reproduzidas na plataforma. 
As tabelas artista, album, musica e historico_reproducao são relacionadas por meio de INNER JOIN, 
garantindo que apenas artistas com reproduções registradas sejam exibidos. 
O DISTINCT evita que um mesmo artista apareça repetido no resultado.*/
SELECT DISTINCT
    a.nome_artista
FROM artista a
INNER JOIN album al
    ON al.id_artista = a.id_artista
INNER JOIN musica m
    ON m.id_album = al.id_album
INNER JOIN historico_reproducao h
    ON h.id_musica = m.id_musica
ORDER BY a.nome_artista;

/*8 - Quais usuários realizaram mais reproduções?
Esta consulta mostra quais usuários realizaram mais reproduções na plataforma. 
As tabelas usuario e historico_reproducao são relacionadas por meio de um INNER JOIN, 
a função COUNT() contabiliza a quantidade de reproduções de cada usuário, 
o GROUP BY agrupa os resultados por usuário e o ORDER BY organiza do usuário 
com mais reproduções para o que possui menos.*/
SELECT
    u.nome,
    COUNT(h.id_reproducao) AS total_reproducoes
FROM usuario u
INNER JOIN historico_reproducao h
    ON h.id_usuario = u.id_usuario
GROUP BY u.id_usuario, u.nome
ORDER BY total_reproducoes DESC;

/*9 - Quais músicas possuem quantidade de reproduções acima da média geral?
Esta consulta identifica as músicas que possuem um número de reproduções 
acima da média geral da plataforma. As tabelas musica (m) e historico_reproducao 
(h) são relacionadas por meio de um INNER JOIN, permitindo contar quantas vezes 
cada música foi reproduzida. O GROUP BY agrupa os registros por música e a 
função COUNT() calcula o total de reproduções de cada uma.

A cláusula HAVING é utilizada para comparar esse total com a média geral de reproduções. 
Essa média é obtida por meio de uma subconsulta, que primeiro conta as reproduções de 
cada música e depois utiliza a função AVG() para calcular a média entre todas elas. 
Dessa forma, o resultado exibe apenas as músicas cujo número de reproduções está 
acima da média da plataforma.*/
SELECT
    m.titulo,
    COUNT(h.id_reproducao) AS total_reproducoes
FROM musica m
INNER JOIN historico_reproducao h
    ON h.id_musica = m.id_musica
GROUP BY m.id_musica, m.titulo
HAVING COUNT(h.id_reproducao) >
(
    SELECT AVG(qtd)
    FROM (
        SELECT COUNT(*) AS qtd
        FROM historico_reproducao
        GROUP BY id_musica
    ) medias
);

/*10 - Quais usuários criaram playlists que possuem músicas do gênero Pop?
Esta consulta identifica os usuários que criaram playlists contendo músicas do gênero Pop. 
A consulta principal busca os nomes dos usuários na tabela usuario, enquanto a subconsulta 
retorna os identificadores dos usuários que possuem playlists com músicas desse gênero.

Para isso, as tabelas playlist (p), playlist_musica (pm) e musica (m) são relacionadas 
por meio de INNER JOIN, permitindo localizar quais músicas estão presentes em cada playlist. 
Uma segunda subconsulta busca o id_genero correspondente ao gênero "Pop" na tabela genero. 
Por fim, o operador IN compara os usuários encontrados na subconsulta com os registros da 
tabela usuario, retornando apenas aqueles que possuem playlists com músicas desse gênero.*/
SELECT
    nome
FROM usuario
WHERE id_usuario IN
(
    SELECT DISTINCT p.id_usuario
    FROM playlist p
    INNER JOIN playlist_musica pm
        ON pm.id_playlist = p.id_playlist
    INNER JOIN musica m
        ON m.id_musica = pm.id_musica
    WHERE m.id_genero =
    (
        SELECT id_genero
        FROM genero
        WHERE nome_genero = 'Pop'
    )
);

/*11 - Quais artistas possuem músicas presentes em playlists dos usuários?
Esta consulta identifica quais artistas possuem músicas adicionadas em playlists 
criadas pelos usuários da plataforma. Para isso, são relacionadas as tabelas artista (a), 
album (al), musica (m), playlist_musica (pm) e playlist (p) por meio de INNER JOIN.

O relacionamento percorre o caminho artista → álbum → música → playlist, 
permitindo descobrir quais artistas estão presentes nas playlists dos usuários. 
O comando DISTINCT é utilizado para evitar que um mesmo artista apareça repetido no 
resultado caso possua várias músicas adicionadas em diferentes playlists. 
Por fim, o ORDER BY organiza os artistas em ordem alfabética.*/
SELECT DISTINCT
    a.nome_artista
FROM artista a
INNER JOIN album al
    ON al.id_artista = a.id_artista
INNER JOIN musica m
    ON m.id_album = al.id_album
INNER JOIN playlist_musica pm
    ON pm.id_musica = m.id_musica
INNER JOIN playlist p
    ON p.id_playlist = pm.id_playlist
ORDER BY a.nome_artista;

/*12 - Ranking dos artistas mais reproduzidos*
Esta consulta cria um ranking dos artistas mais reproduzidos na plataforma. 
Para isso, as tabelas artista (a), album (al), musica (m) e historico_reproducao (h) 
são relacionadas por meio de INNER JOIN, permitindo associar cada reprodução ao 
respectivo artista.

A função COUNT() é utilizada para calcular o total de reproduções de cada artista, 
enquanto o GROUP BY agrupa os resultados por artista. 
Em seguida, a função de janela RANK() OVER() gera uma classificação baseada na 
quantidade de reproduções, ordenando os artistas do mais reproduzido para o menos reproduzido. 
Dessa forma, além de exibir o total de reproduções, a consulta também apresenta 
a posição de cada artista no ranking geral da plataforma.*/
SELECT
    a.nome_artista,
    COUNT(h.id_reproducao) AS total_reproducoes,
    RANK() OVER (
        ORDER BY COUNT(h.id_reproducao) DESC
    ) AS ranking_artista
FROM artista a
INNER JOIN album al
    ON al.id_artista = a.id_artista
INNER JOIN musica m
    ON m.id_album = al.id_album
INNER JOIN historico_reproducao h
    ON h.id_musica = m.id_musica
GROUP BY a.id_artista, a.nome_artista;

/*13 - Evolução das reproduções por usuário
Esta consulta analisa a sequência de reproduções realizadas por cada usuário ao longo do tempo. 
As tabelas usuario (u), historico_reproducao (h) e musica (m) são relacionadas por meio de 
INNER JOIN, permitindo exibir o usuário, a música reproduzida e a data da reprodução.

O diferencial desta consulta é a utilização da função de janela LAG(), que retorna a data 
e hora da reprodução anterior do mesmo usuário. A cláusula PARTITION BY u.id_usuario separa 
os registros por usuário, enquanto ORDER BY h.data_hora organiza as reproduções em ordem cronológica. 
Dessa forma, é possível acompanhar o histórico de uso de cada usuário 
e visualizar a evolução das reproduções ao longo do tempo.*/
SELECT
    u.nome,
    h.data_hora,
    m.titulo,
    LAG(h.data_hora)
        OVER (
            PARTITION BY u.id_usuario
            ORDER BY h.data_hora
        ) AS reproducao_anterior
FROM usuario u
INNER JOIN historico_reproducao h
    ON h.id_usuario = u.id_usuario
INNER JOIN musica m
    ON m.id_musica = h.id_musica;
    
/*BÔNUS: O aplicativo Spotify faz uma retrospectiva no final do ano do
artista mais escutado de cada pessoa. A título de cursiosidade, 
resolvi fazer minha consulta para esse mesmo fim, 
mesmo já tendo cumprido o limite de consultas, achei legal
e agregador para o trabalho

A consulta relaciona as tabelas de usuários, reproduções, músicas, álbuns 
e artistas para identificar quem ouviu cada artista. Em seguida, utiliza 
COUNT() para contar as reproduções e RANK() para criar um ranking dos artistas 
mais ouvidos por cada usuário. Por fim, exibe apenas o artista que ficou 
em primeiro lugar no ranking de cada pessoa.*/

SELECT
    nome_usuario,
    nome_artista,
    total_reproducoes
FROM
(
    SELECT
        u.nome AS nome_usuario,
        a.nome_artista,
        COUNT(*) AS total_reproducoes,
        RANK() OVER (
            PARTITION BY u.id_usuario
            ORDER BY COUNT(*) DESC
        ) AS posicao
    FROM usuario u
    INNER JOIN historico_reproducao h
        ON h.id_usuario = u.id_usuario
    INNER JOIN musica m
        ON m.id_musica = h.id_musica
    INNER JOIN album al
        ON al.id_album = m.id_album
    INNER JOIN artista a
        ON a.id_artista = al.id_artista
    GROUP BY
        u.id_usuario,
        u.nome,
        a.id_artista,
        a.nome_artista
) ranking_artistas
WHERE posicao = 1
ORDER BY nome_usuario;