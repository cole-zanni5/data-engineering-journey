-- =====================================
-- JOIN Examples
-- Using INNER JOIN, LEFT JOIN
-- Queries that combine multiple tables
-- JOIN (same as INNER JOIN)
-- =====================================

-- 1. JOIN: List goals with the match date
-- Shows goals along with the match they belong to
SELECT g.id AS goal_id, ga.matchid, ga.mdate, g.teamid, g.player
FROM goal g
JOIN game ga ON g.matchid = ga.id;

-- 2. LEFT JOIN: List all matches and their goals (if any)
-- Keeps all matches even if no goals were scored
SELECT ga.id AS match_id, ga.mdate, g.id AS goal_id, g.teamid
FROM game ga
LEFT JOIN goal g ON ga.id = g.matchid;

-- 3. JOIN with filtering: Goals scored by a specific team
-- Shows only goals scored by team 1
SELECT g.id AS goal_id, g.player, ga.mdate
FROM goal g
JOIN game ga
  ON g.matchid = ga.id
WHERE g.teamid = ga.team1;

-- 4. Aggregated JOIN: Count of goals per match
-- Combines JOIN with aggregation
SELECT id AS COUNT(id) AS goals_count FROM game
JOIN goal ON matchid = id
  ON g.matchid = ga.id
GROUP BY id;
--OR
SELECT ga.id AS match_id, COUNT(g.id) AS goals_count
FROM game ga
JOIN goal g
  ON g.matchid = ga.id
GROUP BY ga.id;

-- 5. Count of goals scored by each team
SELECT et.teamname, COUNT(g.player) AS goals_scored
FROM eteam et
JOIN goal g
  ON et.id = g.teamid
GROUP BY et.teamname;

-- 6. Count of goals in matches involving Poland
SELECT ga.matchid, ga.mdate, COUNT(g.id) AS goals
FROM game ga
JOIN goal g
  ON g.matchid = ga.id
WHERE (ga.team1 = 'POL' OR ga.team2 = 'POL')
GROUP BY ga.matchid, ga.mdate;