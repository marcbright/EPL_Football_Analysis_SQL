-- Query 1: Select All Data from the Table
SELECT
    *
FROM
    epl_final 
LIMIT 10; 


-- Query 2: Select Specific Columns
SELECT
    "MatchDate",        -- Selects the MatchDate column
    "HomeTeam",         -- Selects the HomeTeam column
    "AwayTeam",         -- Selects the AwayTeam column
    "FullTimeHomeGoals",-- Selects the FullTimeHomeGoals column
    "FullTimeAwayGoals" -- Selects the FullTimeAwayGoals column
FROM
    epl_final
LIMIT 10; -- Again, limiting for a quick view


-- Query 3: Count the Total Number of Matches
SELECT
    COUNT(*) AS total_matches -- Counts all rows and aliases the count as 'total_matches'
FROM
    epl_final;


-- Query 4: Filter Matches by a Specific Season
SELECT
    "MatchDate",
    "HomeTeam",
    "AwayTeam",
    "FullTimeHomeGoals",
    "FullTimeAwayGoals"
FROM
    epl_final
WHERE
    "Season" = '2022/23' -- Filters for matches from the 2022/23 season
LIMIT 10;


-- Query 5: Filter Matches by a Specific Team (Home or Away)
SELECT
    "MatchDate",
    "HomeTeam",
    "AwayTeam",
    "FullTimeResult"
FROM
    epl_final
WHERE
    "HomeTeam" = 'Liverpool' OR "AwayTeam" = 'Liverpool' -- Filters for matches involving 'Liverpool'
ORDER BY
    "MatchDate" DESC -- Orders the results by match date in descending order (most recent first)
LIMIT 10;


-- Query 6: Find Matches with a Specific Result (e.g., Home Win)
SELECT
    "MatchDate",
    "HomeTeam",
    "AwayTeam",
    "FullTimeHomeGoals",
    "FullTimeAwayGoals"
FROM
    epl_final
WHERE
    "FullTimeResult" = 'H' -- Filters for matches where the Home Team won
LIMIT 10;



-- Query 7: Order Results by Goals Scored (Descending)
SELECT
    "MatchDate",
    "HomeTeam",
    "AwayTeam",
    "FullTimeHomeGoals",
    "FullTimeAwayGoals"
FROM
    epl_final
ORDER BY
    "FullTimeHomeGoals" DESC, -- Orders primarily by Home Goals (highest first)
    "FullTimeAwayGoals" DESC -- If Home Goals are equal, orders by Away Goals (highest first)
LIMIT 10; -- Shows the top 10 matches with highest home goals



-- Query 8: Count Distinct Teams
SELECT
    COUNT(DISTINCT "HomeTeam") AS unique_home_teams -- Counts the number of unique values in the HomeTeam column
FROM
    epl_final;