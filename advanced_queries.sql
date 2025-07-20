-- Query 1: Calculate Running Points Total for Each Team Throughout a Season
WITH MatchPoints AS (
    -- First, determine points earned by HomeTeam and AwayTeam in each match
    SELECT
        "Season",
        "MatchDate",
        "HomeTeam" AS Team,
        CASE
            WHEN "FullTimeResult" = 'H' THEN 3 -- Home win
            WHEN "FullTimeResult" = 'D' THEN 1 -- Draw
            ELSE 0                           -- Home loss
        END AS Points_Earned
    FROM
        epl_final

    UNION ALL -- Combine with away team's points

    SELECT
        "Season",
        "MatchDate",
        "AwayTeam" AS Team,
        CASE
            WHEN "FullTimeResult" = 'A' THEN 3 -- Away win
            WHEN "FullTimeResult" = 'D' THEN 1 -- Draw
            ELSE 0                           -- Away loss
        END AS Points_Earned
    FROM
        epl_final
)
SELECT
    "Season",
    "MatchDate",
    Team,
    Points_Earned,
    SUM(Points_Earned) OVER (PARTITION BY "Season", Team ORDER BY "MatchDate") AS Running_Points_Total
    -- Calculate a running sum of Points_Earned
    -- PARTITION BY "Season", Team: Resets the sum for each team within each season
    -- ORDER BY "MatchDate": Sums points in chronological order
FROM
    MatchPoints
ORDER BY
    "Season" DESC,
    Team,
    "MatchDate";


-- Query 2: Final League Standings (Teams Ranked by Total Points per Season)
WITH TeamSeasonStats AS (
    -- First, calculate total points for each team per season
    SELECT
        "Season",
        "HomeTeam" AS Team,
        SUM(CASE WHEN "FullTimeResult" = 'H' THEN 3 WHEN "FullTimeResult" = 'D' THEN 1 ELSE 0 END) AS Home_Points
    FROM
        epl_final
    GROUP BY
        "Season", "HomeTeam"

    UNION ALL

    SELECT
        "Season",
        "AwayTeam" AS Team,
        SUM(CASE WHEN "FullTimeResult" = 'A' THEN 3 WHEN "FullTimeResult" = 'D' THEN 1 ELSE 0 END) AS Away_Points
    FROM
        epl_final
    GROUP BY
        "Season", "AwayTeam"
),
TotalPointsPerTeamSeason AS (
    -- Aggregate home and away points to get total points per team per season
    SELECT
        "Season",
        Team,
        SUM(Home_Points) AS Total_Points
    FROM
        TeamSeasonStats
    GROUP BY
        "Season", Team
)
SELECT
    "Season",
    Team,
    Total_Points,
    RANK() OVER (PARTITION BY "Season" ORDER BY Total_Points DESC) AS Rank_In_Season
    -- Ranks teams within each season based on their total points (highest points get rank 1)
FROM
    TotalPointsPerTeamSeason
ORDER BY
    "Season" DESC,
    Rank_In_Season ASC;


-- Query 3: Most Frequent Full-Time Scorelines
SELECT
    CAST("FullTimeHomeGoals" AS TEXT) || '-' || CAST("FullTimeAwayGoals" AS TEXT) AS Scoreline,
    -- Concatenates home and away goals into a string format like '2-1'
    COUNT(*) AS Number_of_Occurrences
FROM
    epl_final
GROUP BY
    Scoreline -- Groups by the generated scoreline string
ORDER BY
    Number_of_Occurrences DESC -- Orders to show the most frequent scorelines first
LIMIT 10; -- Show the top 10 most frequent scorelines


-- Query 4: Head-to-Head Record Between Two Specific Teams
WITH HeadToHeadMatches AS (
    -- Select only matches played between Arsenal and Manchester United
    SELECT
        "MatchDate",
        "HomeTeam",
        "AwayTeam",
        "FullTimeResult"
    FROM
        epl_final
    WHERE
        ("HomeTeam" = 'Arsenal' AND "AwayTeam" = 'Chelsea')
        OR ("HomeTeam" = 'Chelsea' AND "AwayTeam" = 'Arsenal')
)
SELECT
    'Arsenal' AS Team,
    COUNT(CASE WHEN ("HomeTeam" = 'Arsenal' AND "FullTimeResult" = 'H') OR ("AwayTeam" = 'Arsenal' AND "FullTimeResult" = 'A') THEN 1 END) AS Wins,
    COUNT(CASE WHEN "FullTimeResult" = 'D' THEN 1 END) AS Draws,
    COUNT(CASE WHEN ("HomeTeam" = 'Arsenal' AND "FullTimeResult" = 'A') OR ("AwayTeam" = 'Arsenal' AND "FullTimeResult" = 'H') THEN 1 END) AS Losses,
    COUNT(*) AS Total_Matches
FROM
    HeadToHeadMatches

UNION ALL -- Combine with stats for the other team

SELECT
    'Chelsea' AS Team,
    COUNT(CASE WHEN ("HomeTeam" = 'Chelsea' AND "FullTimeResult" = 'H') OR ("AwayTeam" = 'Chelsea' AND "FullTimeResult" = 'A') THEN 1 END) AS Wins,
    COUNT(CASE WHEN "FullTimeResult" = 'D' THEN 1 END) AS Draws,
    COUNT(CASE WHEN ("HomeTeam" = 'Chelsea' AND "FullTimeResult" = 'A') OR ("AwayTeam" = 'Chelsea' AND "FullTimeResult" = 'H') THEN 1 END) AS Losses,
    COUNT(*) AS Total_Matches
FROM
    HeadToHeadMatches;