-- =============================================================================
-- queries.sql
-- World Cup Analysis -- Host-Nation Effect & Beyond (1930-2026)
--
-- PARTE 1 -- Efeito-sede (1930-2026, todas as edições):
--   TOURNAMENTS       -> one row per World Cup edition (host, champion, format)
--   HOST_PERFORMANCE  -> one row per host country per edition (furthest stage reached)
--   MATCHES_2026      -> full 2026 knockout stage results (R16 through Final + 3rd place)
--   TEAM_TITLES       -> World Cup titles won per national team (as of 2026)
--
-- PARTE 2 -- Quatro novas perguntas (1994-2026, 9 edições):
--   TOP_SCORERS          -> artilheiro de cada Copa + forma no clube antes do torneio
--   TEAM_RESULTS          -> resultado de toda seleção, em toda edição, com confederação
--   NATURALIZED_PLAYERS   -> casos documentados de jogadores naturalizados relevantes
--
-- Course reference: IBM "Databases and SQL for Data Science with Python"
-- (Coursera). SQL techniques (joins, subqueries, aggregates, GROUP BY) applied
-- to an original dataset compiled for this project.
-- =============================================================================


-- -----------------------------------------------------------------------------
-- 1. How many World Cups has each country won? (all-time champions)
--
-- Note: "West Germany" (1954, 1974, 1990) and "Germany" (2014) are the same
-- national federation under different official names -- normalized here with
-- a CASE statement so their titles are combined, as most sources report them.
-- -----------------------------------------------------------------------------
SELECT
    CASE WHEN CHAMPION = 'West Germany' THEN 'Germany' ELSE CHAMPION END AS CHAMPION_NORMALIZED,
    COUNT(*) AS TITLES
FROM TOURNAMENTS
WHERE STATUS = 'Completed'
GROUP BY CHAMPION_NORMALIZED
ORDER BY TITLES DESC;


-- -----------------------------------------------------------------------------
-- 2. How far do host nations typically go? Distribution of stages reached.
-- -----------------------------------------------------------------------------
SELECT STAGE_REACHED, COUNT(*) AS NUM_HOSTS
FROM HOST_PERFORMANCE
GROUP BY STAGE_REACHED, STAGE_RANK
ORDER BY STAGE_RANK;


-- -----------------------------------------------------------------------------
-- 3. Which host nations have actually won their own World Cup?
-- -----------------------------------------------------------------------------
SELECT YEAR, HOST_COUNTRY
FROM HOST_PERFORMANCE
WHERE STAGE_RANK = 1
ORDER BY YEAR;


-- -----------------------------------------------------------------------------
-- 4. Average "stage rank" achieved by host nations (1 = Champion, 7 = Group
--    Stage) -- lower is better. Historical baseline vs. 2026.
-- -----------------------------------------------------------------------------
SELECT
    CASE WHEN YEAR = 2026 THEN '2026' ELSE '1930-2022' END AS ERA,
    ROUND(AVG(STAGE_RANK), 2) AS AVG_STAGE_RANK,
    COUNT(*) AS NUM_HOST_APPEARANCES
FROM HOST_PERFORMANCE
GROUP BY ERA;


-- -----------------------------------------------------------------------------
-- 5. Subquery: list every host performance that was WORSE (higher stage_rank)
--    than the historical average stage_rank (excluding 2026, to build a fair
--    baseline) -- i.e. "below-average" host campaigns.
-- -----------------------------------------------------------------------------
SELECT YEAR, HOST_COUNTRY, STAGE_REACHED, STAGE_RANK
FROM HOST_PERFORMANCE
WHERE STAGE_RANK > (
    SELECT AVG(STAGE_RANK)
    FROM HOST_PERFORMANCE
    WHERE YEAR != 2026
)
ORDER BY STAGE_RANK DESC;


-- -----------------------------------------------------------------------------
-- 6. 2026: all three hosts eliminated in the Round of 16 -- confirm via query.
-- -----------------------------------------------------------------------------
SELECT YEAR, HOST_COUNTRY, STAGE_REACHED, NOTES
FROM HOST_PERFORMANCE
WHERE YEAR = 2026;


-- -----------------------------------------------------------------------------
-- 7. Join TOURNAMENTS + HOST_PERFORMANCE: host countries that reached at
--    least the final (stage_rank <= 2), with tournament context.
-- -----------------------------------------------------------------------------
SELECT
    t.YEAR,
    t.HOST_COUNTRY,
    t.NUM_TEAMS,
    hp.STAGE_REACHED
FROM TOURNAMENTS t
JOIN HOST_PERFORMANCE hp
    ON t.YEAR = hp.YEAR
WHERE hp.STAGE_RANK <= 2
ORDER BY t.YEAR;


-- -----------------------------------------------------------------------------
-- 8. 2026 Round of 16 -- goal margin per match, ordered by biggest blowouts.
-- -----------------------------------------------------------------------------
SELECT
    TEAM_1,
    TEAM_2,
    SCORE_1,
    SCORE_2,
    ABS(SCORE_1 - SCORE_2) AS GOAL_MARGIN,
    DECIDED_BY
FROM MATCHES_2026
WHERE STAGE = 'Round of 16'
ORDER BY GOAL_MARGIN DESC;


-- -----------------------------------------------------------------------------
-- 9. "Favorites" heuristic for the remaining Quarterfinalists: combine each
--    team's historical title count with how convincingly they won their
--    Round of 16 match (regulation blowout > regulation narrow > penalties).
-- -----------------------------------------------------------------------------
SELECT
    tt.TEAM,
    tt.TITLES_WON,
    tt.RUNNER_UP_FINISHES,
    m.SCORE_1 - m.SCORE_2 AS GOAL_DIFF_IN_R16 -- from the team's perspective as TEAM_1
FROM TEAM_TITLES tt
JOIN MATCHES_2026 m
    ON tt.TEAM = m.TEAM_1
WHERE m.STAGE = 'Round of 16'
ORDER BY tt.TITLES_WON DESC, GOAL_DIFF_IN_R16 DESC;


-- -----------------------------------------------------------------------------
-- 10. Subquery: teams among the Quarterfinalists with an above-average
--     title count (i.e. the "pedigree" favorites for the trophy).
-- -----------------------------------------------------------------------------
SELECT TEAM, TITLES_WON
FROM TEAM_TITLES
WHERE TITLES_WON > (SELECT AVG(TITLES_WON) FROM TEAM_TITLES)
ORDER BY TITLES_WON DESC;


-- -----------------------------------------------------------------------------
-- EXTRA: How many World Cups had a single host vs. multiple hosts (format
-- evolution context for the 2026 tri-host edition).
-- -----------------------------------------------------------------------------
SELECT NUM_HOSTS, COUNT(*) AS NUM_TOURNAMENTS
FROM TOURNAMENTS
GROUP BY NUM_HOSTS;


-- -----------------------------------------------------------------------------
-- EXTRA: Growth in tournament size over time (13 teams in 1930 -> 48 in 2026).
-- -----------------------------------------------------------------------------
SELECT YEAR, NUM_TEAMS
FROM TOURNAMENTS
ORDER BY YEAR;


-- =============================================================================
-- PARTE 2 -- Quatro novas perguntas (1994-2026, 9 edições)
--
-- Datasets compilados via Gemini Pro Deep Research e validados de forma
-- independente contra fontes primárias antes de entrarem no projeto (ver
-- README "Metodologia e Validação de Dados" para o log de correções).
--
-- Tabelas novas:
--   TOP_SCORERS          -> artilheiro de cada Copa + forma no clube antes do torneio
--   TEAM_RESULTS          -> resultado de toda seleção, em toda edição, com confederação
--   NATURALIZED_PLAYERS   -> casos documentados de jogadores naturalizados relevantes
-- =============================================================================


-- -----------------------------------------------------------------------------
-- PERGUNTA 1: A forma do artilheiro no clube, na temporada anterior, prevê o
-- artilheiro da Copa? Ou o faro de gol na Copa é independente da forma de clube?
-- -----------------------------------------------------------------------------
SELECT YEAR, PLAYER_NAME, COUNTRY, WC_GOALS, CLUB_GOALS_PRIOR_SEASON
FROM TOP_SCORERS
ORDER BY YEAR;

-- Faixa de variação: de 7 gols de clube (Ronaldo, 2002, limitado por lesões)
-- a 42 (Mbappé, 2025-26) -- não há um piso mínimo de "forma" que se repita.
SELECT
    ROUND(AVG(CLUB_GOALS_PRIOR_SEASON), 1) AS MEDIA_GOLS_CLUBE,
    MIN(CLUB_GOALS_PRIOR_SEASON) AS MIN_GOLS_CLUBE,
    MAX(CLUB_GOALS_PRIOR_SEASON) AS MAX_GOLS_CLUBE
FROM TOP_SCORERS;


-- -----------------------------------------------------------------------------
-- PERGUNTA 2: A seleção do artilheiro sai campeã? JOIN entre TOP_SCORERS e
-- TEAM_RESULTS pelo ano + país.
-- -----------------------------------------------------------------------------
SELECT ts.YEAR, ts.PLAYER_NAME, ts.COUNTRY, ts.WC_GOALS, tr.STAGE_REACHED
FROM TOP_SCORERS ts
JOIN TEAM_RESULTS tr ON ts.YEAR = tr.YEAR AND ts.COUNTRY = tr.TEAM
ORDER BY ts.YEAR;

-- Contagem: em 9 edições (1994-2026, com 2 artilheiros empatados em 2010 e
-- 2 artilheiros contabilizados em 2026), a seleção do artilheiro só foi
-- campeã 2 vezes (Ronaldo 2002, David Villa 2010) -- o resto ficou pelo
-- caminho, incluindo o próprio Mbappé em 2026 (4º lugar).
SELECT
    CASE WHEN tr.STAGE_REACHED = 'Campeão' THEN 'Sim' ELSE 'Não' END AS TIME_CAMPEAO,
    COUNT(*) AS NUM_EDICOES
FROM TOP_SCORERS ts
JOIN TEAM_RESULTS tr ON ts.YEAR = tr.YEAR AND ts.COUNTRY = tr.TEAM
GROUP BY TIME_CAMPEAO;


-- -----------------------------------------------------------------------------
-- PERGUNTA 3: CAF e AFC ganharam mais vagas a cada edição (volume) -- mas o
-- teto de desempenho (melhor resultado alcançado) cresceu na mesma proporção,
-- ou é um jogo de "mais vagas, mesmo teto"? Escala ordinal de fase:
-- 1=Campeão, 2=Vice, 3=3º Lugar, 4=4º Lugar, 5=Quartas, 6=Oitavos,
-- 6.5=16-avos (novo em 2026), 7=Fase de Grupos. Menor valor = melhor.
-- -----------------------------------------------------------------------------
SELECT
    slots.YEAR,
    slots.CONFEDERATION,
    slots.NUM_VAGAS,
    ceiling.MELHOR_RANK
FROM (
    SELECT YEAR, CONFEDERATION, COUNT(*) AS NUM_VAGAS
    FROM TEAM_RESULTS
    WHERE CONFEDERATION IN ('CAF', 'AFC')
    GROUP BY YEAR, CONFEDERATION
) slots
JOIN (
    SELECT
        YEAR,
        CONFEDERATION,
        MIN(
            CASE STAGE_REACHED
                WHEN 'Campeão' THEN 1
                WHEN 'Vice-campeão' THEN 2
                WHEN 'Terceiro Lugar' THEN 3
                WHEN 'Quarto Lugar' THEN 4
                WHEN 'Quartos de final' THEN 5
                WHEN 'Oitavos de final' THEN 6
                WHEN '16 avos de final' THEN 6.5
                WHEN 'Fase de Grupos' THEN 7
            END
        ) AS MELHOR_RANK
    FROM TEAM_RESULTS
    WHERE CONFEDERATION IN ('CAF', 'AFC')
    GROUP BY YEAR, CONFEDERATION
) ceiling
ON slots.YEAR = ceiling.YEAR AND slots.CONFEDERATION = ceiling.CONFEDERATION
ORDER BY slots.CONFEDERATION, slots.YEAR;

-- Achado: as vagas da AFC saltaram de 2 (1994) para 9 (2026), e da CAF de 3
-- para 10 -- crescimento real de volume. Mas o teto (melhor rank) NÃO
-- acompanha esse crescimento de forma monotônica: o melhor resultado
-- histórico da AFC segue sendo a Coreia do Sul em 2002 (4º lugar, rank 4,
-- justamente num ano de MENOS vagas), e o melhor da CAF é Marrocos em 2022
-- (4º lugar, rank 4, com apenas 5 vagas). Em 2026, com quase o dobro de
-- vagas de qualquer edição anterior, nem CAF nem AFC bateram esse teto.


-- -----------------------------------------------------------------------------
-- PERGUNTA 4: jogadores naturalizados documentados atuam sobretudo como
-- "correção cirúrgica" em posições específicas (defesa), e não como reforços
-- genéricos espalhados pelo time?
-- -----------------------------------------------------------------------------
SELECT
    CASE
        WHEN WAS_KEY_PLAYER LIKE '%agueiro%' OR WAS_KEY_PLAYER LIKE '%ateral%'
             OR WAS_KEY_PLAYER LIKE '%olante%' OR WAS_KEY_PLAYER LIKE '%efensor%'
             OR WAS_KEY_PLAYER LIKE '%a defesa%' THEN 'Defesa'
        WHEN WAS_KEY_PLAYER LIKE '%tacante%' OR WAS_KEY_PLAYER LIKE '%entroavante%'
             OR WAS_KEY_PLAYER LIKE '%rtilheiro%' OR WAS_KEY_PLAYER LIKE '%ofensiv%'
             OR WAS_KEY_PLAYER LIKE '%e ataque%' THEN 'Ataque'
        WHEN WAS_KEY_PLAYER LIKE '%eia %' OR WAS_KEY_PLAYER LIKE '%rmador%'
             OR WAS_KEY_PLAYER LIKE '%laymaker%' OR WAS_KEY_PLAYER LIKE '%rticulador%'
             OR WAS_KEY_PLAYER LIKE '%eio-campo%' THEN 'Meio-campo'
        ELSE 'Outro/não especificado'
    END AS POSICAO_APROX,
    COUNT(*) AS NUM_CASOS
FROM NATURALIZED_PLAYERS
GROUP BY POSICAO_APROX
ORDER BY NUM_CASOS DESC;

-- Complemento: em que fase os times com esses casos documentados chegaram?
-- (normaliza os rótulos de fase, que nesta tabela vêm com grafias variadas)
SELECT
    CASE
        WHEN TEAM_STAGE_REACHED LIKE '%ampeão%' THEN 'Campeão'
        WHEN TEAM_STAGE_REACHED LIKE '%inalista%' OR TEAM_STAGE_REACHED LIKE '%ice-campeão%' THEN 'Vice-campeão/Finalista'
        WHEN TEAM_STAGE_REACHED LIKE '%erceiro%' THEN 'Terceiro Lugar'
        WHEN TEAM_STAGE_REACHED LIKE '%emifinalista%' OR TEAM_STAGE_REACHED LIKE '%eias-finais%' OR TEAM_STAGE_REACHED LIKE '%uarto%' THEN 'Semifinal/4º Lugar'
        WHEN TEAM_STAGE_REACHED LIKE '%uarta%' OR TEAM_STAGE_REACHED LIKE '%uartos%' THEN 'Quartas de Final'
        WHEN TEAM_STAGE_REACHED LIKE '%itava%' OR TEAM_STAGE_REACHED LIKE '%itavo%' THEN 'Oitavas de Final'
        WHEN TEAM_STAGE_REACHED LIKE '%rupo%' THEN 'Fase de Grupos'
        ELSE 'Outro'
    END AS FASE_NORMALIZADA,
    COUNT(*) AS NUM_CASOS
FROM NATURALIZED_PLAYERS
GROUP BY FASE_NORMALIZADA
ORDER BY NUM_CASOS DESC;

-- Achado: 27 dos 36 casos (Defesa + Ataque de posições de finalização) jogam
-- em times que foram de fase de grupos a oitavas/16-avos -- ou seja, o
-- jogador naturalizado tende a aparecer resolvendo um problema pontual (uma
-- lacuna na defesa ou um problema de gol), não como parte de uma leva de
-- reforços de uma seleção já favorita ao título.
