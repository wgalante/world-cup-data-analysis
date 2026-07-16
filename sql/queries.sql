-- =============================================================================
-- queries.sql
-- World Cup Host-Nation Effect Analysis (1930-2026)
--
-- Tables:
--   TOURNAMENTS       -> one row per World Cup edition (host, champion, format)
--   HOST_PERFORMANCE  -> one row per host country per edition (furthest stage reached)
--   MATCHES_2026      -> Round of 16 results + Quarterfinal fixtures, WC 2026
--   TEAM_TITLES       -> World Cup titles won per national team (as of 2022)
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
