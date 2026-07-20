# Post para LinkedIn — Copa do Mundo 2026: 4 perguntas (versão fechada)

---

Terminei o curso "Databases and SQL for Data Science with Python" (IBM/Coursera) e fiquei
com aquela vontade de aplicar de verdade — mas sem virar mais um case de churn ou vendas
igual a tantos outros no portfolio. Como acompanho futebol de perto e a Copa do Mundo
tinha acabado de rolar, resolvi usar SQL pra responder perguntas que eu mesmo tinha como
torcedor — só que fugindo da pergunta óbvia (sediar ajuda a vencer?) e indo atrás de coisas
menos perguntadas:

→ O artilheiro da Copa costuma ser do time campeão?
→ Jogador naturalizado entra pra reforçar o time inteiro, ou pra resolver um problema
específico numa posição?
→ África e Ásia ganharam cada vez mais vagas nas últimas edições — isso virou seleções
mais fortes, ou só mais vagas?

Compilei um dataset original cobrindo 9 Copas (1994-2026, o intervalo entre as duas Copas
sediadas nos EUA) usando Deep Research (Gemini) com prompts bem específicos — schema de
colunas definido antes de rodar, exigindo fonte pra cada dado, com critério rígido pra
"naturalizado" (por residência, não por ascendência). E, mais importante: não usei nada
disso de olhos fechados. Validei cada tabela contra fonte primária antes de rodar qualquer
query — e isso pegou um erro real (a pesquisa tinha incluído Camarões e Costa Rica como
classificados pra 2026; nenhum dos dois se classificou — corrigi comparando com a lista
oficial de seleções no Wikipedia).

A resposta que mais me surpreendeu: o artilheiro da Copa quase nunca está no time campeão.
Desde 1994, em 14 casos de artilheiro (contando empates), só 2 times do artilheiro
saíram campeões — Brasil de Ronaldo em 2002 e Espanha de David Villa em 2010. Mbappé fechou
2026 com 10 gols, a Chuteira de Ouro isolada e um recorde histórico — e a França terminou
em 4º lugar. São conquistas que, no dado, quase não se cruzam.

A segunda que gostei: África e Ásia foram ganhando cada vez mais vagas desde 1994 (a Ásia
foi de 2 pra 9 vagas; a África, de 3 pra 10) — mas o teto de desempenho não acompanhou.
O melhor resultado histórico de cada uma ainda é de anos com bem menos vagas: Coreia do Sul
na semifinal de 2002 (só 4 vagas na época) e Marrocos na semifinal de 2022 (só 5 vagas). Em
2026, com quase o dobro de vagas de qualquer edição anterior, nenhuma das duas bateu esse
teto. Mais vaga não é sinônimo de seleção mais forte — pelo menos não ainda.

Todo o dataset, as queries comentadas (joins, subqueries, `CASE`) e o notebook completo —
incluindo as outras 2 perguntas (forma de clube x artilheiro, e onde entram os jogadores
naturalizados) — estão públicos no GitHub.

🔗 [link do repositório]

Curioso pra saber: alguma dessas quebrou alguma expectativa sua também? Comenta aqui.

#SQL #Python #DataAnalytics #WorldCup2026 #IBM #Coursera #DataScience

---

### Observações antes de publicar

1. Substitua `[link do repositório]` pelo link real do repositório (o nome vai mudar de
   `world-cup-host-effect-analysis` para `world-cup-data-analysis` — veja as instruções de
   renomeação separadas).
2. Anexe o banner novo (o que o Manus vai gerar, focado só nas 4 perguntas) como imagem do
   post — aumenta bastante o alcance no feed.
3. As duas primeiras linhas são o que aparece antes do "ver mais" — mantive o gancho no
   curso + motivação pessoal (futebol).
4. A pergunta final pede comentário, não curtida — é o que o algoritmo do LinkedIn mais
   recompensa em alcance orgânico.
5. O parágrafo de validação é intencionalmente curto — mostra que você não confia de olhos
   fechados em dado gerado por IA, sem virar um tutorial de prompt engineering.
6. Deixei só 2 das 4 respostas no corpo do post (artilheiro x campeão, e CAF/AFC) pra manter
   curto — as outras 2 (forma de clube e naturalização) ficam como gancho pra quem entrar no
   repositório.
