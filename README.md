# World Cup Host-Nation Effect Analysis (1930-2026)

![Project banner](assets/banner.png)

![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-SQLite-lightgrey?logo=sqlite&logoColor=white)
![pandas](https://img.shields.io/badge/pandas-data%20analysis-150458?logo=pandas&logoColor=white)
![Status](https://img.shields.io/badge/status-completed-brightgreen)
![Course](https://img.shields.io/badge/IBM-Databases%20%26%20SQL%20for%20Data%20Science-052FAD?logo=ibm&logoColor=white)

A SQL + Python data analysis project asking a simple question with 96 years of World
Cup history: **does hosting the tournament actually help a national team win?** — and
checking the answer against what just happened at the 2026 World Cup.

Built on SQL techniques from IBM's **"Databases and SQL for Data Science with
Python"** course (Coursera / IBM Data Science Professional Certificate), applied to
an original, hand-compiled dataset spanning every World Cup from 1930 to the ongoing
2026 edition.

> **Data snapshot:** as of **July 16, 2026** — Round of 16, Quarterfinals, and
> Semifinals are all complete. The final is set: **Spain vs. Argentina**, July 19
> at MetLife Stadium.

---

## The Hook

For the first time ever, the World Cup has **three** host nations: Canada, Mexico, and
the USA, in the first-ever 48-team edition. All three were eliminated in the **Round
of 16** — none reached the Quarterfinals. Historically, hosts have won the tournament
outright **6 times out of 21** (1930-2022, ~29%). This project uses SQL to quantify
just how unusual 2026's result is.

## Datasets

Four original CSV tables, compiled and cross-checked against public football
history and 2026 tournament coverage (see [Methodology](#methodology)):

| Table | File | Description |
|---|---|---|
| `TOURNAMENTS` | `tournaments.csv` | One row per World Cup edition (1930-2026): host, champion, format, team count |
| `HOST_PERFORMANCE` | `host_performance.csv` | One row per host country per edition: furthest stage reached |
| `MATCHES_2026` | `matches_2026.csv` | 2026 Round of 16, Quarterfinal, and Semifinal results, plus the Final fixture |
| `TEAM_TITLES` | `team_titles.csv` | World Cup titles won per national team |

## Key Findings

- Host nations have won the World Cup **6 of 21** times (1930-2022) — a striking
  overperformance versus a random baseline.
- **2026 breaks that pattern completely:** all three hosts (Canada, Mexico, USA) were
  eliminated in the Round of 16, the worst collective host performance on record.
  Average host "stage rank" in 2026 (6.0) is far below the 96-year historical host
  average (~3.2, on a scale where 1 = Champion).
- Two of the three host eliminations (Canada 0-3 vs. Morocco, USA 1-4 vs. Belgium)
  were comfortable wins for the opposition, not narrow losses.
- A simple pedigree + form heuristic flagged **France** and **Argentina** as early
  favorites among the 2026 Quarterfinalists. Argentina backed up the pick, beating
  England to reach the final — but France was eliminated by **Spain**, a team with
  just one historical title. The final (**Spain vs. Argentina**, July 19) pits the
  heuristic's top pick against the team that already beat its runner-up: pedigree
  pointed in a useful direction, but didn't fully predict the bracket.
- Brazil (5) leads all-time titles, followed by Italy and Germany (4 each, once
  West Germany's 3 titles are correctly combined with Germany's 2014 title).

Full analysis, SQL, and charts: [`notebooks/world_cup_host_effect_analysis.ipynb`](notebooks/world_cup_host_effect_analysis.ipynb)

## Project Structure

```
world-cup-host-effect-analysis/
├── assets/
│   └── banner.png                # README banner infographic
├── data/
│   ├── tournaments.csv           # 1930-2026 tournament summary
│   ├── host_performance.csv      # Host nation results, every edition
│   ├── matches_2026.csv          # 2026 Round of 16, Quarterfinal, Semifinal results + Final fixture
│   └── team_titles.csv           # All-time titles per national team
├── src/
│   └── db_utils.py               # Reusable DB connection + query helper functions
├── sql/
│   └── queries.sql               # All SQL queries, documented and commented
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

- `SELECT`, `WHERE`, `ORDER BY`, aggregate functions (`COUNT`, `AVG`)
- `GROUP BY` for per-category summaries
- `JOIN` across `TOURNAMENTS`, `HOST_PERFORMANCE`, `MATCHES_2026`, and `TEAM_TITLES`
- Subqueries (e.g., finding host campaigns below the historical average)
- `CASE` statements for data normalization (e.g., combining "West Germany" and
  "Germany" into one historical entity, or labeling 2026 vs. historical eras)

## Methodology & Data Sources <a id="methodology"></a>

- **Historical data (1930-2022):** compiled from well-documented, publicly available
  World Cup history (host countries, champions, runners-up, and host-nation results
  for every edition), cross-checked against standard football references. Early
  tournament team counts (pre-1950) can vary slightly by source due to withdrawals;
  figures here reflect commonly cited totals.
- **2026 data:** compiled from public news coverage, current as of **July 16, 2026**
  (Round of 16, Quarterfinals, and Semifinals complete; Final scheduled July 19).
- **Stage-rank scale:** `1` = Champion, `2` = Runner-up, `3` = Third Place,
  `4` = Fourth Place, `5` = Quarterfinal (or nearest historical equivalent),
  `6` = Round of 16 (or nearest equivalent), `7` = Group Stage. This lets tournament
  formats from very different eras be compared on a consistent ordinal basis.
- **Country naming:** national teams are recorded under the name officially used at
  the time (e.g. "West Germany" through 1990); combined with "Germany" via SQL
  `CASE` statements where relevant for all-time totals.

This project intentionally does **not** rely on a third-party pre-built dataset —
the data was compiled and structured specifically for this analysis, which is also
why the numbers can be fully traced back to their sources in the notebook.

## Course Credit

SQL techniques applied in this project (joins, subqueries, aggregate functions,
`GROUP BY`/`ORDER BY`, `CASE` statements) were learned in IBM's **"Databases and SQL
for Data Science with Python"** course (Coursera / IBM Data Science Professional
Certificate). The dataset, queries, and analysis are original work built for this
portfolio project.

---

**