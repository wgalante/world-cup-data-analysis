# Prompt para Manus — Atualização do Infográfico Retrô-Pixel

Use este prompt para pedir à Manus que **regenere o infográfico de estilo
retrô/pixel art** (o mesmo usado anteriormente para "O Efeito de Sede"),
substituindo todo o conteúdo antigo pelas 3 perguntas atuais do projeto
`world-cup-data-analysis`. É uma peça visual **diferente** do banner
esports-HUD (`assets/banner.png`) — mantenha os dois arquivos separados.

---

## Prompt

Recrie este infográfico exatamente no mesmo estilo visual retrô/pixel art de
8-16 bits do arquivo de referência — fundo de arquibancada pixelada, ícones
pixelados (troféu, bola, bandeiras), fonte arcade em bloco dourado/amarelo
para o título, 5 painéis com bordas coloridas distintas, decoração de
estrelas (★) como marcadores de bullet, e a fileira decorativa de corações
pixelados e controles de videogame nos cantos inferiores. **Não altere o
estilo, a paleta de cores dos painéis, as fontes ou a composição geral** —
apenas substitua o conteúdo de cada painel pelos dados abaixo.

**Título principal (substituir):**
"COPA DO MUNDO 1994-2026: 3 PERGUNTAS, DADOS VALIDADOS"

**Painel 1 (borda azul — mantenha o ícone/estilo original deste painel):**
- Título do painel: "FORMA DE CLUBE NÃO PREVÊ O ARTILHEIRO"
- Conteúdo: mini gráfico de dispersão ou duas barras comparativas mostrando
  Ronaldo (2002): 7 gols pelo clube na temporada anterior → Artilheiro da
  Copa mesmo assim. Mbappé (2025-26): 42 gols pelo clube → também
  Artilheiro.
- Estatística em destaque: "r = 0,39" (correlação fraca-moderada)
- Bullet (★): "O pior ano de clube de toda a lista ainda venceu a artilharia."

**Painel 2 (borda magenta/roxa com ícone de caveira — substitua o ícone de
caveira por um ícone de troféu pixelado, mantendo a borda e estilo do
painel):**
- Título do painel: "O ARTILHEIRO QUASE NUNCA É CAMPEÃO"
- Estatística em destaque, grande: "2 DE 14"
- Conteúdo: bandeiras pixeladas dos 2 casos que venceram ambos (Brasil 2002 -
  Ronaldo, Espanha 2010 - David Villa) ao lado de um "X" sobre as bandeiras
  dos demais 12 artilheiros desde 1994, incluindo a França 2026 (Mbappé, 10
  gols, França terminou em 4º lugar).
- Bullet (★): "Ser o artilheiro e ser campeão são conquistas quase
  independentes."

**Painel 3 (borda verde com ícone de terminal ">_" — mantenha):**
- Título do painel: "STACK TÉCNICA"
- Conteúdo: lista pixelada com ícones — SQL (SQLite): JOINs, subqueries,
  CASE, GROUP BY / Python: pandas, matplotlib, seaborn / Jupyter Notebook
- Bullet (★): "Todo o dataset foi compilado via Gemini Pro Deep Research e
  validado manualmente antes do uso."

**Painel 4 (borda vermelha/laranja com ícones de troféu — substitua o
conteúdo, mantendo estilo):**
- Título do painel: "TETO x VOLUME: CAF e AFC"
- Conteúdo: duas barras de crescimento de vagas pixeladas — AFC: 2 → 9 vagas
  / CAF: 3 → 10 vagas (1994 → 2026), com ícones de bandeiras/confederação
- Estatística em destaque: melhores campanhas históricas (Coreia do Sul,
  semifinal 2002; Marrocos, semifinal 2022) ocorreram em edições com MENOS
  vagas do que 2026
- Bullet (★): "Mais vagas não elevou o teto de desempenho das confederações."

**Painel 5 (borda roxa com ícones de engrenagem — substitua o conteúdo,
mantendo estilo):**
- Título do painel: "VALIDAÇÃO E RIGOR METODOLÓGICO"
- Conteúdo: dois selos pixelados estilo "achievement unlocked":
  1. "ERRO REAL CORRIGIDO" — Camarões e Costa Rica apareciam como
     participantes de 2026 nos dados brutos; checagem cruzada com a
     Wikipedia confirmou que ambos não haviam se qualificado e foram
     removidos.
  2. "PERGUNTA DESCARTADA POR RIGOR" — uma 4ª pergunta sobre naturalização
     de jogadores foi testada e descartada: os dados não sustentavam a
     hipótese (apenas 2 de 36 casos tinham evidência real), então a
     pergunta foi removida do projeto em vez de forçar uma métrica fraca.
- Bullet (★): "Nem todo dado bruto sobrevive à validação — e isso faz parte
  do processo, não é uma falha."

**Rodapé (mantenha a decoração de corações pixelados e controles de
videogame nos cantos, sem alterações):**
"github.com/wgalante/world-cup-data-analysis"

---

## Observações antes de enviar

- Se a Manus perguntar sobre a imagem de referência original (a versão sobre
  "O Efeito de Sede"), anexe-a como base de estilo — o objetivo é replicar
  exatamente a linguagem visual, não criar algo novo do zero.
- Confirme que o resultado final não contém nenhuma menção a "sede",
  "campanha coletiva", "fator casa" ou à naturalização de jogadores como
  pergunta ativa do projeto — esses temas foram removidos do escopo.
- Depois de gerado, revise número por número contra o README antes de
  substituir o arquivo no repositório (nome de arquivo sugerido:
  `assets/infografico_retro.png`, para não conflitar com `assets/banner.png`).
