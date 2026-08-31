# 🎵 SoundWave - Banco de Dados para Plataforma de Streaming Musical

## 📖 Sobre o Projeto

O SoundWave é um projeto acadêmico de Banco de Dados desenvolvido com o objetivo de modelar e implementar uma plataforma de streaming musical inspirada em serviços como Spotify e Deezer.

A solução foi construída utilizando MySQL 8.0 e contempla o gerenciamento de usuários, artistas, álbuns, músicas, gêneros musicais, playlists, assinaturas e histórico de reproduções.

Além das operações básicas de armazenamento e consulta de dados, o projeto busca fornecer informações estratégicas por meio de consultas analíticas capazes de identificar padrões de consumo, popularidade de artistas e comportamento dos usuários.

---

## 🎯 Objetivos

### Objetivo Geral

Desenvolver um banco de dados relacional capaz de representar as principais funcionalidades de uma plataforma de streaming musical.

### Objetivos Específicos

- Aplicar conceitos de modelagem relacional.
- Implementar relacionamentos 1:1, 1:N e N:N.
- Utilizar chaves primárias e estrangeiras.
- Garantir integridade dos dados por meio de restrições.
- Popular o banco com dados realistas.
- Desenvolver consultas SQL para geração de informações gerenciais.
- Aplicar funções avançadas como RANK() e LAG().

---

## 🚀 Como Executar

1. Abra o MySQL Workbench ou outro cliente compatível com MySQL 8.0.

2. Execute o arquivo `BANCO.sql` para criar o banco de dados, as tabelas, os relacionamentos e inserir os dados de teste.

3. Após a criação do banco, execute o arquivo `CONSULTAS.sql` para visualizar as consultas desenvolvidas no projeto e seus respectivos resultados.

## 📂 Arquivos do Projeto

- **BANCO.sql**: contém a criação completa do banco de dados, incluindo tabelas, restrições, relacionamentos e população inicial.
- **CONSULTAS.sql**: contém as consultas SQL elaboradas para análise dos dados da plataforma.

## ✅ Resultado Esperado

Ao final da execução, o banco de dados `soundwave` estará totalmente configurado e pronto para a realização das consultas e análises propostas no projeto.

---

## 🗂️ Estrutura do Banco de Dados

### Entidades Principais

| Tabela | Responsabilidade |
|----------|----------|
| usuario | Armazenar dados dos usuários |
| assinatura | Controlar planos contratados |
| artista | Registrar artistas da plataforma |
| genero | Classificar músicas por gênero |
| album | Registrar álbuns musicais |
| musica | Armazenar catálogo musical |
| playlist | Gerenciar playlists dos usuários |
| playlist_musica | Implementar relacionamento N:N |
| historico_reproducao | Registrar reproduções realizadas |

---

## 📈 Recursos SQL Aplicados

Durante o projeto foram utilizados:

- INNER JOIN
- LEFT JOIN
- GROUP BY
- ORDER BY
- HAVING
- COUNT()
- AVG()
- DISTINCT
- Subconsultas
- Funções de Janela
  - RANK()
  - LAG()

---

## 📚 Conceitos Aplicados

- Modelagem Relacional
- Integridade Referencial
- Normalização
- Consultas Analíticas
- Banco de Dados Relacional
- SQL Avançado
- Funções de Janela

---

## 👩‍💻 Autora

**Eduarda Guimarães Monteiro**

Projeto desenvolvido para a disciplina de Banco de Dados.

---

## 📄 Licença

Este projeto foi desenvolvido exclusivamente para fins acadêmicos.
