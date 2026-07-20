# World Cup Data Analysis (1994-2026): 3 Questions

![Project banner](assets/banner.png)

![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-SQLite-lightgrey?logo=sqlite&logoColor=white)
![pandas](https://img.shields.io/badge/pandas-data%20analysis-150458?logo=pandas&logoColor=white)
![Status](https://img.shields.io/badge/status-completed-brightgreen)
![Course](https://img.shields.io/badge/IBM-Databases%20%26%20SQL%20for%20Data%20Science-052FAD?logo=ibm&logoColor=white)

A SQL + Python data analysis project asking three specific, less obvious questions
about the last nine World Cups (1994-2026) — the span between the two tournaments
held in the USA. No "does hosting help" here: this project skips the obvious question
and goes after things that are more interesting and less asked.

Built on SQL techniques from IBM's **"Databases and SQL for Data Science with
Python"** course (Coursera / IBM Data Science Professional Certificate), applied to
an original dataset compiled via **Gemini Pro Deep Research** and **independently
validated** against primary sources before use — see
[Methodology & Data Validation Log](#methodology).

> **Data snapshot:** tournament complete as of **July 20, 2026**. Spain beat
> Argentina 1-0 in the final; England beat France 6-4 in the third-place match;
> Kylian Mbappé finished as outright top scorer with 10 goals — all reflected in
> the data below.

---

## The Hook

Kylian Mbappé finished the 2026 World Cup with a record-setting **10 goals** and the
outright Golden Boot. His team, France, finished **fourth**. That split is not an
exception — it is the rule: only **2 of 14** top-scorer/team pairs since 1994 ended in
a championship. This project runs that finding, and two others like it, through SQL.

## The Three Questions

1. Does a World Cup top scorer's club form, right before the tournament, predict
   their scoring form at the Cup?
2. Does the top scorer's team actually win the tournament?
3. Africa (CAF) and Asia (AFC) have gained steadily more World Cup slots since
   1994 — did their *ceiling* (best result) grow at the same pace as their *volume*
   (number of slots)?

## Datasets

Two original CSV tables, compiled via Gemini Pro Deep Research and independently
validated against primary sources before use (see
[Methodology & Data Validation Log](#methodology)):

| Table | File | Description |
|---|---|---|
| `TOP_SCORERS` | `top_scorers_1994_2026.csv` | Each edition's top scorer + club-season form immediately before the tournament (1994-2026) |
| `TEAM_RESULTS` | `team_results_1994_2026.csv` | Every team, every edition, with confederation and furthest stage reached (296 rows, 1994-2026) |

`TOP_SCORERS` has 14 rows (one per edition, 1994-2026) and `TEAM_RESULTS` has 296 rows
(one per team per edition). Both are intentionally small — hand-compiled and
independently validated rather than sampled from a large pre-built source. See
[Methodology](#methodology) for why that trade-off was made deliberately.

## Key Findings

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

Full analysis, SQL, and charts: [`notebooks/world_cup_data_analysis.ipynb`](notebooks/world_cup_data_analysis.ipynb)

## Project Structure

```
world-cup-data-analysis/
├── assets/
│   └── banner.png                       # README banner infographic
├── data/
│   ├── top_scorers_1994_2026.csv        # Each edition's top scorer + club form
│   └── team_results_1994_2026.csv       # Every team, every edition (296 rows)
├── src/
│   └── db_utils.py                      # Reusable DB connection + query helper functions
├── sql/
│   └── queries.sql                      # All SQL queries, documented and commented
├── notebooks/
│   └── world_cup_data_analysis.ipynb    # Full analysis: SQL + pandas + visualizations
├── requirements.txt
└── README.md
```

## Tech Stack

- **SQL** (SQLite) — aggregate functions, `GROUP BY`, `JOIN`, subqueries, `CASE`
  statements for data normalization
- **Python** — `pandas`, `matplotlib`, `seaborn`
- **Jupyter Notebook** for narrative analysis
- **Gemini Pro Deep Research** for data compilation — independently validated
  before use, not taken at face value (see [Methodology](#methodology))

## How to Run

```bash
git clone https://github.com/wgalante/world-cup-data-analysis.git
cd world-cup-data-analysis
pip install -r requirements.txt
jupyter notebook notebooks/world_cup_data_analysis.ipynb
```

The notebook loads the CSVs from `data/` into an in-memory SQLite database via
`src/db_utils.py` — no external database setup required.

## SQL Concepts Demonstrated

- `SELECT`, `WHERE`, `ORDER BY`, aggregate functions (`COUNT`, `AVG`, `MIN`)
- `GROUP BY` for per-category summaries
- `JOIN` between `TOP_SCORERS` and `TEAM_RESULTS` (top-scorer/team outcome question)
- Subqueries and derived tables — joining a per-edition slot-count subquery with a
  per-edition ceiling subquery for the CAF/AFC question
- `CASE` statements for data normalization — mapping free-text stage labels onto a
  consistent ordinal rank scale

## Methodology & Data Validation Log <a id="methodology"></a>

- **Compiled via Gemini Pro Deep Research**, using schema-first prompts (exact CSV
  column headers specified up front, explicit source-citation and
  confidence-flagging instructions).
- **Independently validated before use, not taken at face value** — every dataset was
  cross-checked against primary sources before being loaded into this project. See the
  correction log below for the one concrete error this caught.
- **2026 data:** tournament complete as of **July 20, 2026** — all results final,
  including the Spain 1-0 Argentina final and the England 6-4 France third-place match.
- **Language note:** team names, stage labels, and notes in the datasets are in
  Portuguese (the language the research was conducted in); this README and the
  notebook's narrative text are in English.

### Correction log

One real error was found and fixed during this project — a deliberate part of the
portfolio story, not an incidental detail:

1. **Two non-qualified teams in the 2026 `TEAM_RESULTS` data.** The Deep Research
   output included Cameroon and Costa Rica as 2026 participants, which would have made
   the tournament 50 teams instead of 48. A row-count check flagged the discrepancy;
   cross-referencing Wikipedia's "List of team base camps" table (one row per
   actually-qualified team) confirmed both were false inclusions and removed them.

### A question that didn't survive scrutiny

An earlier version of this project included a fourth question — whether naturalized
players are used as a targeted fix for a specific squad need, versus generic
reinforcement. After building it out, the underlying data (a free-text description of
each player's on-field role) turned out not to support that claim: mentioning a
player's position is not evidence of *why* a federation naturalized them, and only 2 of
36 documented cases actually stated an identified need being filled. Rather than keep a
metric that doesn't hold up, that question was dropped. Recognizing when a question
doesn't survive scrutiny — and saying so — is part of the same validation discipline
that produced the correction above.

### Why the datasets are small

This project intentionally does **not** rely on a third-party pre-built dataset —
14 rows in `TOP_SCORERS`, 296 in `TEAM_RESULTS`. That size is a direct consequence of
compiling and validating every row by hand rather than importing a large ready-made
source: a bigger dataset would have meant trusting rows that were never individually
checked. The trade-off is fewer total rows in exchange for every number being traceable
back to a primary source, which is also why the correction log above is part of the
deliverable, not an afterthought.

## Course Credit

SQL techniques applied in this project (joins, subqueries, aggregate functions,
`GROUP BY`/`ORDER BY`, `CASE` statements) were learned in IBM's **"Databases and SQL
for Data Science with Python"** course (Coursera / IBM Data Science Professional
Certificate). The dataset, queries, and analysis are original work built for this
portfolio project.
