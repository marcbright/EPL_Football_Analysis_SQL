-- Query 1: Total Home Wins, Away Wins, and Draws per Season
SELECT
    "Season",            -- Group by the season
    COUNT(CASE WHEN "FullTimeResult" = 'H' THEN 1 END) AS Home_Wins, -- Count matches where Home Team won
    COUNT(CASE WHEN "FullTimeResult" = 'A' THEN 1 END) AS Away_Wins, -- Count matches where Away Team won
    COUNT(CASE WHEN "FullTimeResult" = 'D' THEN 1 END) AS Draws     -- Count matches that were a Draw
FROM
    epl_final
GROUP BY
    "Season"             -- Aggregate the counts for each unique season
ORDER BY
    "Season" DESC;       -- Order by season, newest first



-- Query 2: Average Goals Scored and Conceded by Each Team (Home Games)
SELECT
    "HomeTeam" AS Team,      -- Select the home team and alias it as 'Team'
    COUNT(*) AS Matches_Played_Home, -- Count how many home matches they played
    AVG("FullTimeHomeGoals") AS Avg_Goals_Scored_Home, -- Average goals scored by the home team
    AVG("FullTimeAwayGoals") AS Avg_Goals_Conceded_Home -- Average goals conceded by the home team
FROM
    epl_final
GROUP BY
    "HomeTeam"               -- Aggregate these metrics for each unique home team
ORDER BY
    Avg_Goals_Scored_Home DESC; -- Order by average goals scored at home



-- Query 3: Average Goals Scored and Conceded by Each Team (Away Games)
SELECT
    "AwayTeam" AS Team,      -- Select the away team and alias it as 'Team'
    COUNT(*) AS Matches_Played_Away, -- Count how many away matches they played
    AVG("FullTimeAwayGoals") AS Avg_Goals_Scored_Away, -- Average goals scored by the away team
    AVG("FullTimeHomeGoals") AS Avg_Goals_Conceded_Away -- Average goals conceded by the away team
FROM
    epl_final
GROUP BY
    "AwayTeam"               -- Aggregate these metrics for each unique away team
ORDER BY
    Avg_Goals_Scored_Away DESC; -- Order by average goals scored away


-- Query 4: Matches with a High Number of Total Goals
SELECT
    "MatchDate",
    "HomeTeam",
    "AwayTeam",
    "FullTimeHomeGoals",
    "FullTimeAwayGoals",
    ("FullTimeHomeGoals" + "FullTimeAwayGoals") AS Total_Goals -- Calculate total goals in the match
FROM
    epl_final
WHERE
    ("FullTimeHomeGoals" + "FullTimeAwayGoals") >= 7 -- Filter for matches with 7 or more total goals
ORDER BY
    Total_Goals DESC,
    "MatchDate" DESC
LIMIT 10; -- Show the top 10 highest-scoring matches


-- Query 5: Teams with the Most Yellow Cards (Home Games)
SELECT
    "HomeTeam" AS Team,      -- Select the home team
    SUM("HomeYellowCards") AS Total_Yellow_Cards_Home -- Sum all yellow cards received at home
FROM
    epl_final
GROUP BY
    "HomeTeam"               -- Group by each home team
ORDER BY
    Total_Yellow_Cards_Home DESC -- Order by total yellow cards, highest first
LIMIT 10; -- Show the top 10 teams


-- Query 6: Home Win Percentage for Each Team (considering at least 10 home games)
SELECT
    "HomeTeam",
    COUNT(*) AS Total_Home_Matches,
    COUNT(CASE WHEN "FullTimeResult" = 'H' THEN 1 END) AS Home_Wins,
    (CAST(COUNT(CASE WHEN "FullTimeResult" = 'H' THEN 1 END) AS NUMERIC) / COUNT(*)) * 100 AS Home_Win_Percentage -- Calculate percentage
FROM
    epl_final
GROUP BY
    "HomeTeam"
HAVING
    COUNT(*) >= 10 -- Only include teams that have played at least 10 home matches
ORDER BY
    Home_Win_Percentage DESC;