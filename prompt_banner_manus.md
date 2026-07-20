# Prompt para o Manus — banner do projeto (versão só com as 4 perguntas)

Cole isso no Manus junto com a imagem atual (`assets/banner.png`) como referência de estilo:

```
Recrie este banner de portfólio de dados mantendo EXATAMENTE o mesmo estilo visual,
mas com o conteúdo integralmente substituído pelo abaixo. Referência: imagem anexa.

ESTILO A MANTER (não mudar):
- Fundo azul-marinho escuro, tipo telão de estádio, com feixes de luz de holofote
  saindo dos cantos superiores esquerdo e direito.
- Ícone de holofotes/arquibancada no canto superior esquerdo.
- Título em duas linhas, fonte impact/condensada em caixa alta, efeito 3D cromado:
  primeira linha em prata/cromado, segunda linha em dourado.
- 5 painéis lado a lado, mesma largura, fundo azul-marinho translúcido, borda dourada
  em estilo "HUD de e-sports" (cantos em L), com selo numerado dourado (1 a 5) no
  canto superior esquerdo de cada painel.
- Proporção da imagem: 2688x1152 (ou equivalente ~2.33:1).
- Bandeiras nacionais, ícones e gráficos simples quando aplicável.

CONTEÚDO NOVO (substituir 100% do conteúdo antigo sobre efeito-sede — não deve sobrar
nenhuma menção a "país-sede", "anfitrião" ou "campanha coletiva" dos EUA/Canadá/México):

Título:
Linha 1 (prata): "4 PERGUNTAS SOBRE A COPA:"
Linha 2 (dourado): "ANÁLISE SQL (1994-2026)"

Painel 1 — "ARTILHEIRO x CAMPEÃO"
Número grande: "2 de 14"
Legenda: "TIMES DO ARTILHEIRO QUE SAÍRAM CAMPEÕES DESDE 1994"
Nota pequena: "MBAPPÉ: 10 GOLS EM 2026, FRANÇA TERMINOU EM 4º LUGAR"

Painel 2 — "FORMA DE CLUBE"
Número grande: "7 A 42"
Legenda: "GOLS DE CLUBE DOS ARTILHEIROS NA TEMPORADA ANTERIOR À COPA"
Nota pequena: "SEM PISO MÍNIMO — RONALDO VENCEU A CHUTEIRA DE OURO DE 2002 COM SÓ 7"

Painel 3 — "TETO x VOLUME (CAF/AFC)"
Elemento visual: duas linhas ou barras mostrando vagas subindo (Ásia 2→9, África 3→10)
lado a lado com o "teto" (melhor resultado) estagnado
Legenda: "VAGAS QUASE TRIPLICARAM DESDE 1994 — O TETO DE DESEMPENHO NÃO ACOMPANHOU"
Nota pequena: "MELHOR RESULTADO DE CADA UMA FOI EM ANOS COM MENOS VAGAS (2002 E 2022)"

Painel 4 — "NATURALIZAÇÃO"
Número grande: "27 de 36"
Legenda: "CASOS DOCUMENTADOS SÃO CORREÇÃO PONTUAL (DEFESA OU ATAQUE)"
Nota pequena: "NÃO É REFORÇO GERAL DE ELENCO — É AJUSTE CIRÚRGICO NUMA POSIÇÃO"

Painel 5 — "STACK & VALIDAÇÃO"
Ícone SQL: "SQL: JOINS, SUBQUERIES, CASE, GROUP BY"
Ícone Python: "PYTHON: PANDAS, MATPLOTLIB, SEABORN"
Linha extra: "DEEP RESEARCH (GEMINI) + VALIDAÇÃO: 2 ERROS REAIS CORRIGIDOS"

OBJETIVO: este banner acompanha um projeto de portfólio no GitHub voltado a
recrutadores de Análise de Dados/BI. Precisa ser lido e entendido em menos de
5 segundos por alguém escaneando o perfil. Priorize números grandes e legíveis,
alto contraste, sem poluição visual. Gere em alta resolução (mínimo 2688x1152px).
```

### Depois de gerar

1. Salve o arquivo novo substituindo `assets/banner.png` na pasta do projeto.
2. Se o Manus gerar em outro formato (jpg/webp), converta pra `.png` antes de substituir —
   o README já referencia especificamente `assets/banner.png`.
3. Depois de trocar o arquivo, é só incluir no mesmo commit final (`git add assets/banner.png`).
