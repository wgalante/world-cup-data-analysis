# World Cup Host-Nation Effect Analysis (1930-2026)

![Project banner](assets/banner.png)

![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-SQLite-lightgrey?logo=sqlite&logoColor=white)
![pandas](https://img.shields.io/badge/pandas-data%20analysis-150458?logo=pandas&logoColor=white)
![Status](https://img.shields.io/badge/status-completed-brightgreen)
![Course](https://img.shields.io/badge/IBM-Databases%20%26%20SQL%20for%20Data%20Science-052FAD?logo=ibm&logoColor=white)

A SQL + Python data analysis project in two parts. **Part 1** asks a simple question
with 96 years of World Cup history: does hosting the tournament actually help a
national team win — and how did that hold up against 2026? **Part 2** asks four less
obvious questions about the last nine editions (1994-2026): does club form predict
the Golden Boot, does the top scorer's team win the title, did Africa/Asia's growing
slot count raise their ceiling, and how do naturalized players actually get used.

Built on SQL techniques from IBM's **"Databases and SQL for Data Science with
Python"** course (Coursera / IBM Data Science Professional Certificate), applied to
original, hand-compiled datasets — for Part 2, compiled via Gemini Pro Deep Research
and independently validated against primary sources before use (see
[Methodology & Data Validation Log](#methodology)).

> **Data snapshot:** **tournament complete** as of **July 20, 2026**. Spain beat
> Argentina **1-0** in the final (Ferrán Torres, stoppage time) for their second
> title; England beat France **6-4** in the third-place match; Kylian Mbappé finished
> as outright top scorer with **10 goals**.

---

## The Hook

For the first time ever, the World Cup has **three** host nations: Canada, Mexico, and
the USA, in the first-ever 48-team edition. All three were eliminated in the **Round
of 16** — none reached the Quarterfinals. Historically, hosts have won the tournament
outright **6 times out of 21** (1930-2022, ~29%). Part 1 uses SQL to quantify just how
unusual 2026's result is. Part 2 then steps back from hosting entirely and digs into
four other questions across the 1994-2026 span — the two World Cups held in the USA.

## Datasets

Seven original CSV tables. Part 1's four tables are compiled and cross-checked
against public football history and 2026 tournament coverage; Part 2's three tables
were compiled via Gemini Pro Deep Research and independently validated before use
(see [Methodology & Data Validation Log](#methodology)):

| Table | File | Description |
|---|---|---|
| `TOURNAMENTS` | `tournaments.csv` | One row per World Cup edition (1930-2026): host, champion, format, team count |
| `HOST_PERFORMANCE` | `host_performance.csv` | One row per host country per edition: furthest stage reached |
| `MATCHES_2026` | `matches_2026.csv` | Full 2026 knockout results: Round of 16 through the Final, plus the third-place match |
| `TEAM_TITLES` | `team_titles.csv` | World Cup titles won per national team |
| `TOP_SCORERS` | `raw_research/top_scorers_1994_2026.csv` | Each edition's top scorer + club-season form immediately before the tournament (1994-2026) |
| `TEAM_RESULTS` | `raw_research/team_results_1994_2026.csv` | Every team, every edition, with confederation and furthest stage reached (296 rows, 1994-2026) |
| `NATURALIZED_PLAYERS` | `raw_research/naturalized_players_1994_2026.csv` | 36 documented, press-covered cases of naturalized players who were key contributors |

## Key Findings — Part 1: Does Hosting Help?

- Host nations have won the World Cup **6 of 21** times (1930-2022) — a striking
  overperformance versus a random baseline.
- **2026 breaks that pattern completely:** all three hosts (Canada, Mexico, USA) were
  eliminated in the Round of 16, the worst collective host performance on record.
  Average host "stage rank" in 2026 (6.0) is far below the 96-year historical host
  average (~3.61, on a scale where 1 = Champion).
- Two of the three host eliminations (Canada 0-3 vs. Morocco, USA 1-4 vs. Belgium)
  were comfortable wins for the opposition, not narrow losses.
- **2026 is the first-ever three-host edition, so there is no exact historical
  precedent — but the one partial precedent points the same way.** 2002 (co-hosted
  by South Korea and Japan) is the only other shared-hosting edition, and it already
  underperformed the single-host norm: South Korea reached the Fourth Place match
  (rank 4) and Japan fell in the Round of 16 (rank 6), averaging 5.0 versus ~3.48 for
  single-host editions. The pattern across 1, 2, and 3 hosts (3.48 → 5.0 → 6.0) is a
  small sample, but consistent with a real mechanism: when hosting is split, each
  host nation still has to travel to the other host countries for most of its
  matches, diluting the classic "no travel, home crowd" advantage instead of
  multiplying it.
- A simple pedigree + form heuristic flagged **France** and **Argentina** as early
  favorites among the 2026 Quarterfinalists — and neither won the trophy. **Spain**
  (1 previous title) beat Argentina 1-0 in the final; **England** (1 previous title)
  beat France 6-4 in the third-place match. Final standings: Spain champion, Argentina
  runner-up, England third, France fourth — the two least-titled teams left standing
  took gold and bronze.
- Brazil (5) leads all-time titles, followed by Italy and Germany (4 each, once
  West Germany's 3 titles are correctly combined with Germany's 2014 title). Spain now
  has 2 titles (2010, 2026).

## Key Findings — Part 2: Four More Questions (1994-2026)

- **Club form does not predict the Golden Boot.** Ronaldo won it in 2002 with the
  *fewest* club goals in the dataset (7, injury-limited); Mbappé's record 2026 haul
  came off the *most* club goals (42). No consistent floor either way.
- **The top scorer's team almost never wins the title.** Only 2 of 14 top-scorer/team
  pairs since 1994 (Ronaldo 2002, David Villa 2010) ended in a championship. Mbappé's
  2026 Golden Boot (10 goals) came with France finishing fourth.
- **CAF/AFC slot growth has not moved the ceiling.** Both confederations roughly
  doubled or tripled their slot counts since 1994 (AFC: 2→9, CAF: 3→10), but their
  best-ever results (South Korea's 2002 semifinal, Morocco's 2022 semifinal) happened
  in editions with *fewer* slots than 2026 — where, despite the largest allocation in
  history, neither matched that ceiling.
- **Naturalization reads as a targeted fix, not a trend.** 27 of the 36 documented
  cases are defenders or attackers solving one specific positional problem for their
  adopted team (e.g., Aymeric Laporte anchoring Spain's 2026 title-winning defense),
  not evidence of squads broadly rebuilt around naturalized players.

Full analysis, SQL, and charts: [`notebooks/world_cup_host_effect_analysis.ipynb`](notebooks/world_cup_host_effect_analysis.ipynb)

## Project Structure

```
world-cup-host-effect-analysis/
├── assets/
│   └── banner.png                # README banner infographic
├── data/
│   ├── tournaments.csv           # 1930-2026 tournament summary
│   ├── host_performance.csv      # Host nation results, every edition
│   ├── matches_2026.csv          # Full 2026 knockout results (R16 -> Final + 3rd place)
│   ├── team_titles.csv           # All-time titles per national team
│   └── raw_research/             # Part 2 datasets (1994-2026), Deep Research + validated
│       ├── top_scorers_1994_2026.csv
│       ├── team_results_1994_2026.csv
│       └── naturalized_players_1994_2026.csv
├── src/
│   └── db_utils.py               # Reusable DB connection + query helper functions
├── sql/
│   └── queries.sql               # All SQL queries (Part 1 + Part 2), documented and commented
├── notebooks/
│   └── world_cup_host_effect_analysis.ipynb  # Full analysis: SQL + pandas + visualizations
├── requirements.txt
└── README.md
```

## Tech Stack

- **SQL** (SQLite) — aggregate functions, `GROUP BY`, `JOIN`, subqueries, `CASE`
  statements for data normalization
- **Python** — `pandas`, `matplotlib`, `seaborn`
- **Jupyter Notebook** for narrative analysis
- **Gemini Pro Deep Research** for Part 2 data compilation — independently validated
  before use, not taken at face value (see [Methodology](#methodology))

## How to Run

```bash
git clone https://github.com/wgalante/world-cup-host-effect-analysis.git
cd world-cup-host-effect-analysis
pip install -r requirements.txt
jupyter notebook notebooks/world_cup_host_effect_analysis.ipynb
```

The notebook loads the CSVs from `data/` into an in-memory SQLite database via
`src/db_utils.py` — no external database setup required.

## SQL Concepts Demonstrated

- `SELECT`, `WHERE`, `ORDER BY`, aggregate functions (`COUNT`, `AVG`, `MIN`)
- `GROUP BY` for per-category summaries
- `JOIN` across `TOURNAMENTS`, `HOST_PERFORMANCE`, `MATCHES_2026`, `TEAM_TITLES`
  (Part 1) and `TOP_SCORERS`, `TEAM_RESULTS` (Part 2, top-scorer/team outcome join)
- Subqueries and derived tables (e.g., host campaigns below the historical average;
  joining a per-edition slot-count subquery with a per-edition ceiling subquery for
  the CAF/AFC question)
- `CASE` statements for data normalization — combining "West Germany" and "Germany"
  into one historical entity, labeling 2026 vs. historical eras, mapping free-text
  stage labels onto a consistent ordinal rank scale, and bucketing free-text position
  descriptions into position groups for the naturalization question

## Methodology & Data Validation Log <a id="methodology"></a>

### Part 1 data (1930-2026)

- **Historical data (1930-2022):** compiled from well-documented, publicly available
  World Cup history (host countries, champions, runners-up, and host-nation results
  for every edition), cross-checked against standard football references. Early
  tournament team counts (pre-1950) can vary slightly by source due to withdrawals;
  figures here reflect commonly cited totals.
- **2026 data:** compiled from public news coverage. Tournament complete as of
  **July 20, 2026** — all results final, including the Spain 1-0 Argentina final and
  the England 6-4 France third-place match.
- **Stage-rank scale:** `1` = Champion, `2` = Runner-up, `3` = Third Place,
  `4` = Fourth Place, `5` = Quarterfinal (or nearest historical equivalent),
  `6` = Round of 16 (or nearest equivalent), `7` = Group Stage. This lets tournament
  formats from very different eras be compared on a consistent ordinal basis.
- **Country naming:** national teams are recorded under the name officially used at
  the time (e.g. "West Germany" through 1990); combined with "Germany" via SQL
  `CASE` statements where relevant for all-time totals.

### Part 2 data (1994-2026)

- **Compiled via Gemini Pro Deep Research**, using three schema-first prompts (exact
  CSV column headers specified up front, explicit source-citation and
  confidence-flagging instructions, and a strict definition of "naturalized" —
  residency/civil-process naturalization only, excluding ancestry-based eligibility
  such as Miroslav Klose's German repatriation or Morocco's diaspora players).
- **Independently validated before use, not taken at face value** — every dataset was
  cross-checked against primary sources before being loaded into this project. See the
  correction log below for the two concrete errors this caught.
- **`NATURALIZED_PLAYERS` is a curated set of the most-documented, press-covered
  cases, not an exhaustive squad census** — deliberately scoped down from an
  unreliable full count to a smaller set of verifiable cases.
- **Language note:** team names, stage labels, and notes in the Part 2 tables are in
  Portuguese (the language the research was conducted in); this README and the
  notebook's narrative text are in English.

### Correction log

Three real errors were found and fixed during this project, each caught by a
different validation method:

1. **Stale host-average figure (Part 1).** Early drafts of this README and notebook
   claimed the 96-year historical host average stage rank was "~3.2." Re-running the
   actual SQL aggregate query returned **3.61** — the text had never been updated
   after an earlier data revision. Fixed everywhere, with the 2002 co-hosting
   precedent added as supporting context rather than just a corrected number.
2. **Two non-qualified teams in the 2026 `TEAM_RESULTS` data (Part 2).** The Deep
   Research output included Cameroon and Costa Rica as 2026 participants, which would
   have made the tournament 50 teams instead of 48. A row-count check flagged the
   discrepancy; cross-referencing Wikipedia's "List of team base camps" table (one row
   per actually-qualified team) confirmed both were false inclusions and removed them.
3. **A player who never played the tournament (Part 2).** The naturalized-players
   research listed Robin Le Normand as a starting centre-back for Spain's actual 2026
   squad. A targeted web search confirmed he was not selected for the World Cup squad
   (only for Euro 2024) — the row was removed.

This project intentionally does **not** rely on a third-party pre-built dataset —
the data was compiled and structured specifically for this analysis, which is also
why the numbers can be fully traced back to their sources in the notebook, and why
the correction log above is part of the deliverable, not an afterthought.

## Course Credit

SQL techniques applied in this project (joins, subqueries, aggregate functions,
`GROUP BY`/`ORDER BY`, `CASE` statements) were learned in IBM's **"Databases and SQL
for Data Science with Python"** course (Coursera / IBM Data Science Professional
Certificate). The dataset, queries, and analysis are original work built for this
portfolio project.

---

**