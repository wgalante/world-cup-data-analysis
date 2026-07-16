"""
db_utils.py
------------
Reusable helper functions to load the World Cup datasets (tournament history,
host country performance, 2026 knockout stage results, and team titles) into
an in-memory SQLite database and run SQL queries against them with pandas.

This module exists so the analysis notebook stays focused on SQL + insights
instead of repeating boilerplate CSV/DB setup in every cell.

Project: World Cup Host-Nation Effect Analysis (1930-2026)
Course reference: IBM "Databases and SQL for Data Science with Python" (Coursera)
"""

from __future__ import annotations

import re
import sqlite3
from pathlib import Path

import pandas as pd

DATA_DIR = Path(__file__).resolve().parent.parent / "data"

TABLES = {
    "TOURNAMENTS": DATA_DIR / "tournaments.csv",
    "HOST_PERFORMANCE": DATA_DIR / "host_performance.csv",
    "MATCHES_2026": DATA_DIR / "matches_2026.csv",
    "TEAM_TITLES": DATA_DIR / "team_titles.csv",
}


def _sanitize_column(name: str) -> str:
    """Turn a raw CSV header into a safe, uppercase SQL column name."""
    name = name.strip().upper()
    name = re.sub(r"[^A-Z0-9]+", "_", name)
    return name.strip("_")


def get_connection(db_path: str = ":memory:") -> sqlite3.Connection:
    """
    Create a SQLite connection and load all four World Cup datasets into it
    as tables: TOURNAMENTS, HOST_PERFORMANCE, MATCHES_2026, TEAM_TITLES.

    Parameters
    ----------
    db_path : str
        Where to create the SQLite database. Defaults to an in-memory
        database.

    Returns
    -------
    sqlite3.Connection
        An open connection with all four tables already loaded.
    """
    conn = sqlite3.connect(db_path)

    for table_name, csv_path in TABLES.items():
        if not csv_path.exists():
            raise FileNotFoundError(
                f"Expected data file not found: {csv_path}. "
                "Make sure the /data folder contains the original CSVs."
            )
        df = pd.read_csv(csv_path)
        df.columns = [_sanitize_column(c) for c in df.columns]
        df.to_sql(table_name, conn, if_exists="replace", index=False)

    return conn


def run_query(conn: sqlite3.Connection, query: str) -> pd.DataFrame:
    """Run a SQL query against the given connection and return a DataFrame."""
    return pd.read_sql_query(query, conn)


def list_tables(conn: sqlite3.Connection) -> list[str]:
    """Return the list of tables currently loaded in the database."""
    result = run_query(conn, "SELECT name FROM sqlite_master WHERE type='table';")
    return result["name"].tolist()
