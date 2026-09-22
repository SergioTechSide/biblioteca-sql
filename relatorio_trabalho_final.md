# 📚 Trabalho Final - Projeto Integrador de Banco de Dados I
**Tema:** Desenvolvimento de um Banco de Dados Relacional para Sistema de Gestão de Biblioteca  
**Estudante:** Sérgio Alves de Barros  
**Disciplina:** Banco de Dados I (UESB)  

---

## 1. Descrição do Minimundo
O sistema informatiza o gerenciamento do acervo, empréstimos e consultas locais de uma biblioteca universitária, eliminando controles manuais.

* **Problema:** Controle manual passível de erros, registros duplicados e atrasos na devolução de obras.
* **Público-alvo:** Leitores/Alunos e equipe de Bibliotecários.
* **Informações armazenadas:** Usuários, livros, periódicos, registros de empréstimos e registros de consultas locais.
* **Operações principais:** Cadastro de itens e usuários, lançamento e devolução de empréstimos, consultas locais e relatórios de controle.
* **Regras de Negócio:**
  1. Periódicos são destinados exclusivamente para consulta local (não podem ser emprestados).
  2. O empréstimo só é permitido para obras com status 'Disponível'.
  3. Uma obra não pode estar em empréstimo e consulta simultaneamente.
  4. Todo empréstimo possui data prevista de devolução.

---

## 2. Modelo Entidade-Relacionamento (MER)
* **Entidades:** `Usuario`, `Livro`, `Periodico`, `Emprestimo`, `Consulta`.
* **Atributos:**
  * `Usuario`: **id_usuario** (PK), nome, endereco, cic, idade, escolaridade.
  * `Livro`: **id_livro** (PK), titulo, autor, editora, ano, status.
  * `Periodico`: **id_periodico** (PK), titulo, editora, ano, status.
  * `Emprestimo`: **id_emprestimo** (PK), data_emprestimo, data_devolucao_prevista, data_devolucao_real, id_usuario (FK), id_livro (FK).
  * `Consulta`: **id_consulta** (PK), data_consulta, hora_inicio, hora_fim, id_usuario (FK), id_livro (FK), id_periodico (FK).
* **Cardinalidades:**
  * Usuario (1,1) <realiza> (0,N) Emprestimo
  * Livro (1,1) <pertence a> (0,N) Emprestimo
  * Usuario (1,1) <efetua> (0,N) Consulta
  * Livro/Periodico (1,1) <registrado em> (0,N) Consulta

---

## 3. Modelo Relacional
Transformação das entidades em estruturas relacionais com chaves:

* **Usuario** (**id_usuario**, nome, endereco, cic, idade, escolaridade)
* **Livro** (**id_livro**, titulo, autor, editora, ano, status)
* **Periodico** (**id_periodico**, titulo, editora, ano, status)
* **Emprestimo** (**id_emprestimo**, data_emprestimo, data_devolucao_prevista, data_devolucao_real, *id_usuario*, *id_livro*)
* **Consulta** (**id_consulta**, data_consulta, hora_inicio, hora_fim, *id_usuario*, *id_livro*, *id_periodico*)

---

## 4. Dependências Funcionais e Normalização

### Tabela Não Normalizada (UNF)
`R_EMPRESTIMO` (id_emprestimo, nome_usuario, cic_usuario, titulo_livro, autor_livro, data_emprestimo, data_devolucao)

### Dependências Funcionais (DFs)
* DF1: `id_emprestimo` -> `nome_usuario`, `cic_usuario`, `titulo_livro`, `autor_livro`, `data_emprestimo`, `data_devolucao`
* DF2: `cic_usuario` -> `nome_usuario` (Transitiva)
* DF3: `titulo_livro` -> `autor_livro` (Transitiva)

### Processo de Normalização
1. **1FN:** Todos os atributos possuem valores atômicos e indivisíveis.
2. **2FN:** Não existem dependências parciais, pois a chave primária (`id_emprestimo`) é simples.
3. **3FN:** Remoção das dependências transitivas (DF2 e DF3). As informações de usuário e livro foram isoladas em tabelas próprias (`Usuario` e `Livro`), mantendo apenas as chaves estrangeiras em `Emprestimo`.

---

## 5 e 6. Implementação SQL e Manipulação (DDL e DML)
O script completo de criação das tabelas (DDL) e inserção/atualização dos dados (DML) encontra-se totalmente operacional no arquivo `banco_biblioteca.sql`.

---

## 7. Consultas SQL (10 Consultas Solicitadas)

1. **Listar todos os usuários:**
   ```sql
   SELECT * FROM Usuario;
SELECT * FROM Livro ORDER BY ano DESC;
SELECT * FROM Periodico WHERE status = 'Disponível';
SELECT COUNT(*) AS total_usuarios FROM Usuario;
SELECT titulo, autor FROM Livro WHERE ano >= 2011;
SELECT AVG(idade) AS media_idade FROM Usuario;
SELECT E.id_emprestimo, U.nome, L.titulo, E.data_emprestimo 
FROM Emprestimo E 
JOIN Usuario U ON E.id_usuario = U.id_usuario 
JOIN Livro L ON E.id_livro = L.id_livro;
SELECT id_usuario, COUNT(*) AS qtd FROM Emprestimo GROUP BY id_usuario;
SELECT id_usuario, COUNT(*) AS qtd FROM Emprestimo GROUP BY id_usuario HAVING COUNT(*) >= 1;
SELECT C.id_consulta, U.nome, C.data_consulta 
FROM Consulta C 
JOIN Usuario U ON C.id_usuario = U.id_usuario;
SELECT nome, idade FROM Usuario WHERE idade > (SELECT AVG(idade) FROM Usuario);
SELECT titulo FROM Livro WHERE id_livro NOT IN (SELECT id_livro FROM Emprestimo);
SELECT nome FROM Usuario WHERE id_usuario IN (SELECT DISTINCT id_usuario FROM Emprestimo);
