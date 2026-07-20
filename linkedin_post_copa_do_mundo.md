# Post para LinkedIn — Copa do Mundo 2026 (versão fechada, pós-final)

---

Terminei o curso "Databases and SQL for Data Science with Python" (IBM/Coursera) e fiquei
com aquela vontade de aplicar de verdade — mas sem virar mais um case de churn ou vendas
igual a tantos outros no portfolio. Como acompanho futebol de perto e a Copa do Mundo estava
rolando, resolvi usar SQL pra responder perguntas que eu mesmo tinha como torcedor.

Antes das quartas de final, três coisas me deixavam curioso:

→ Sediar a Copa realmente ajuda a vencer?
→ Como os anfitriões de 2026 — Canadá, México e EUA, os primeiros três sedes simultâneos da
história — estavam se saindo comparado ao histórico?
→ Dava pra prever quem chegaria à final só com pedigree e forma na estreia?

Compilei um dataset original com 96 anos de Copa (1930-2026) — nada de base pronta de
terceiros — e fui pras queries: joins, subqueries, `CASE`, agregações, tudo em SQL puro, com
pandas e matplotlib/seaborn pra visualizar.

Sediar ajuda, sim — 6 dos 21 títulos (~29%) foram do país-sede, bem acima do esperado ao
acaso. Mas 2026 quebrou o padrão por completo: pela primeira vez, os três anfitriões caíram
todos nas oitavas — a pior campanha coletiva de sedes já registrada, com rank médio 6.0
contra ~3,61 na média histórica das sedes únicas.

E aqui vale uma ressalva que eu mesmo me fiz: como é a primeira vez com 3 sedes, não existe
um precedente exato pra comparar. Mas existe um precedente parcial — 2002, a única outra Copa
com sede dividida (Coreia do Sul e Japão), já tinha vindo pior que a média de sede única:
Coreia chegou à disputa de 3º lugar (rank 4), Japão caiu nas oitavas (rank 6), média 5.0
contra ~3,48 de quem sediou solo. A progressão de 1 pra 2 pra 3 sedes (3,48 → 5,0 → 6,0) é
pouca amostra, mas faz sentido: sede dividida significa que cada anfitrião ainda viaja pros
outros países-sede na maioria dos jogos — o que dilui a vantagem de jogar em casa, em vez de
multiplicar ela.

A pergunta que eu mais queria testar: uma query simples de pedigree (títulos × saldo de gols
na estreia) apontou França e Argentina como favoritas, antes de qualquer jogo das quartas.
Resultado real, agora que a Copa acabou: nenhuma das duas ficou com o título. A Argentina
confirmou o pedigree até a final, mas perdeu por 1 a 0 pra Espanha (1 título só, bem abaixo da
média do grupo). A França nem chegou à final — caiu pra Espanha na semi e ainda perdeu a
disputa de 3º lugar pra Inglaterra (também 1 título só) por 6 a 4. As duas seleções com mais
taça no currículo terminaram em 2º e 4º lugar; as duas "azarãs" no meu próprio ranking
levaram ouro e bronze. Pedigree ajudou a apontar direção no meio do caminho, mas não previu
quem ficaria com a taça.

Bônus técnico (e humano): no meio do projeto, encontrei um bug real nos meus próprios dados —
o texto da análise dizia que a média histórica de sede era "~3,2", mas rodando a query de novo
o resultado real era 3,61. Corrigi em todo o projeto e usei a chance pra reforçar a análise
com mais contexto (o precedente de 2002), em vez de só trocar o número. Esse tipo de checagem
— rodar de novo, desconfiar do próprio dado — acabou virando um hábito no projeto: mais adiante
usei Deep Research (Gemini) pra levantar mais 4 perguntas com dados de 1994 a 2026, e validei
cada resultado contra fonte primária antes de confiar nele — o que pegou, por exemplo, um país
que constava errado na lista de classificados pra 2026.

Todo o dataset, as queries comentadas e o notebook completo — incluindo essas 4 perguntas
extras — estão públicos no GitHub.

🔗 [link do repositório]

Curioso pra saber: você também tinha um favorito "no papel" que não bateu com o resultado?
Comenta aqui.

#SQL #Python #DataAnalytics #WorldCup2026 #IBM #Coursera #DataScience

---

### Observações antes de publicar

1. Substitua `[link do repositório]` pelo link real
   (`github.com/wgalante/world-cup-host-effect-analysis`).
2. Anexe o infográfico (o que você já fez, estilo retrô/pixel) como imagem do post — ele
   resume visualmente a mesma história e aumenta bastante o alcance no feed. Se quiser, dá pra
   fazer uma versão nova só com o resultado final (Espanha campeã), mas não é obrigatório.
3. As duas primeiras linhas são o que aparece antes do "ver mais" — mantive o gancho no curso
   + motivação pessoal (futebol).
4. A pergunta final pede comentário, não curtida — é o que o algoritmo do LinkedIn mais
   recompensa em alcance orgânico. Trocada porque a pergunta antiga ("que vai ganhar domingo?")
   não faz mais sentido com o torneio encerrado.
5. O parágrafo sobre Deep Research é intencionalmente curto — o objetivo aqui é mostrar que
   você valida dados de IA em vez de confiar de olhos fechados, sem transformar o post num
   tutorial de prompt engineering. Se quiser aprofundar isso, pode ser um post separado depois.
