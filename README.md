SQL Queries for English Premier League (EPL) Data Analysis
This repository contains a structured collection of SQL queries designed to analyze historical English Premier League (EPL) match data stored in a PostgreSQL database. The queries are categorised by difficulty (Beginner, Intermediate, Advanced) to demonstrate various levels of SQL proficiency and to provide insights ranging from basic data retrieval to complex analytical computations.

Database Setup:

The data is imported from a CSV file into a PostgreSQL database named epl_final.

The primary table containing the match data is assumed to be epl_final.

Query Categories:

1. Beginner Queries (beginner_queries.sql)
These queries focus on fundamental SQL operations for initial data exploration and validation. They cover:

Selecting all or specific columns from the epl_matches table.

Counting the total number of records.

Basic filtering using WHERE clauses (e.g., by season, by team, by match result).

Ordering results using ORDER BY.

Limiting the number of returned rows.

Counting distinct values.

Purpose: To get a quick overview of the dataset, confirm successful data import, and practice basic data retrieval.

2. Intermediate Queries (intermediate_queries.sql)
This section introduces more complex SQL concepts, enabling deeper analysis and aggregation of the data. Queries here demonstrate:

Aggregating data using GROUP BY and functions like COUNT() and AVG().

Conditional aggregation using CASE statements (e.g., counting wins, draws, losses).

Calculating average goals scored and conceded by teams in home and away matches.

Filtering aggregated results using the HAVING clause (e.g., for teams with a minimum number of matches played).

Calculating percentages (e.g., home win percentage).

Purpose: To extract summarized statistics, analyze team performance trends, and perform basic conditional data analysis.

3. Advanced Queries (advanced_queries.sql)
These queries showcase advanced SQL techniques for sophisticated data analysis and reporting. They include:

Common Table Expressions (CTEs): Used to break down complex queries into readable, logical steps.

Window Functions (SUM() OVER(), RANK() OVER()): For calculating running totals, rankings, and other partition-based computations (e.g., tracking cumulative points for teams throughout a season, determining final league standings).

Complex string manipulation and casting for derived data (e.g., generating scoreline strings like '2-1').

Detailed head-to-head analysis between specific teams.

Purpose: To perform in-depth statistical analysis, simulate league dynamics, and answer more complex analytical questions that require multi-step processing or context-aware calculations.
