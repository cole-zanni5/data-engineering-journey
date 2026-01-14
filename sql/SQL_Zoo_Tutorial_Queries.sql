SELECT 'My first SQL file' AS status;

-- SQLZoo SELECT Basics
1.
SELECT population FROM world
  WHERE name = 'Germany'

2.
SELECT name, population FROM world
  WHERE name IN ('Sweden','Norway','Denmark');

3.
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

-- SQLZoo SELECT from WORLD Tutorial
1.
SELECT name, continent, population FROM world

2.
SELECT name FROM world
WHERE population >= 200000000

3.
SELECT name, gdp/population FROM world
WHERE population >= 200000000

4.
SELECT name, population/1000000 FROM world
WHERE continent = 'South America'

5.
SELECT name, population FROM world
WHERE name IN ('France','Germany', 'Italy')

6.
SELECT name FROM world
WHERE name LIKE '%United%'

7.
SELECT name, population, area FROM world
WHERE area > 3000000
OR population > 250000000

8.
SELECT name, population, area FROM world
WHERE area > 3000000
XOR population > 250000000

9.
SELECT name, ROUND(population/1000000,2), ROUND(gdp/1000000000,2) FROM world
WHERE continent = 'South America'

10.
SELECT name, ROUND(gdp/population,-3) FROM world
WHERE gdp >= 1000000000000

11.
SELECT name, capital FROM world
WHERE LENGTH(name) = LENGTH(capital)

12.
SELECT name, capital FROM world
WHERE left(name,1) = left(capital,1) 
AND name <> capital

-- SQLZoo SELECT from NOBEL Tutorial
1.
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

2.
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'literature'

3.
SELECT yr, subject FROM nobel
WHERE winner = 'Albert Einstein'

4.
SELECT winner fROM nobel
WHERE subject = 'peace'
AND yr >= 2000

5.
SELECT * FROM nobel
WHERE subject = 'literature'
AND yr>= 1980 AND yr <= 1989

6.
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Thomas Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

7.
SELECT winner FROM nobel
WHERE winner LIKE 'John %'

8.
SELECT * FROM nobel
WHERE subject = 'physics' AND yr = 1980
OR subject ='chemistry' AND yr = 1984

9.
SELECT * FROM nobel
WHERE yr = 1980 AND subject NOT IN ('chemistry', 'medicine')

10.
SELECT * FROM nobel
WHERE subject = 'medicine' AND yr < 1910
OR subject = 'literature' and yr >= 2004

11.
SELECT * FROM nobel
WHERE winner = 'PETER GRÜNBERG'

12.
SELECT * FROM nobel
WHERE winner = "EUGENE O'NEILL"

13.
SELECT winner, yr, subject FROM nobel
WHERE winner LIKE 'Sir %'
ORDER BY yr DESC, winner ASC;

14.
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY 
  (subject IN ('physics','chemistry')),
  subject,
  winner;


-- SQLZoo SELECT within SELECT Tutorial
1.
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

2.
SELECT name FROM world
  WHERE continent = 'Europe'
  AND gdp/population > 
    (SELECT gdp/population FROM world
    WHERE name = 'United Kingdom')


3.
SELECT name,continent FROM world
  WHERE continent IN 
    (SELECT continent FROM world
     WHERE name = 'Argentina'
     OR name = 'Australia')
     ORDER BY name ASC

4.
SELECT name,population FROM world
  WHERE population >
    (Select population FROM world
    WHERE name = 'United Kingdom')
  AND population < 
    (SELECT population FROM world
     WHERE name = 'Germany')

5.
SELECT name, CONCAT(
  ROUND(
  population*100 /
    (SELECT population FROM world WHERE name = 'Germany')
    ),
  '%'
) AS percentage FROM world
WHERE continent = 'Europe'  

6. 
SELECT name FROM world
  WHERE gdp > ALL
    (SELECT gdp FROM world
    WHERE continent = 'Europe'
    AND gdp > 0)

7.
SELECT
  continent,
  MIN(name) AS name
FROM world
GROUP BY continent ASC

8.
SELECT
  continent,
  MIN(name) AS name
FROM world
GROUP BY continent ASC

9.
SELECT name,continent,population FROM world 
WHERE continent IN (
SELECT continent FROM world
GROUP BY continent
HAVING MAX(population) <= 25000000
)

10.
SELECT w1.name, w1.continent FROM world w1
WHERE w1.population > 3* (
SELECT MAX(w2.population) FROM world w2
WHERE w1.continent = w2.continent
AND w1.name != w2.name)

-- SQLZoo SUM and COUNT Tutorial
1.
SELECT SUM(population)
FROM world

2.
SELECT DISTINCT(continent)
FROM world

3.
SELECT SUM(gdp) FROM world
WHERE continent = 'Africa'

4.
SELECT COUNT(name) FROM world
WHERE area >= 1000000

5.
SELECT SUM(population) FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

6.
SELECT continent,COUNT(name) FROM world
GROUP BY continent

7.
SELECT continent, COUNT(name) FROM world
WHERE population >= 10000000
GROUP BY continent

8.
SELECT continent FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000

-- SQLZoo The JOIN Operation
1.
SELECT matchid,player FROM goal 
  WHERE teamid = 'GER'

2.
SELECT id,stadium,team1,team2
  FROM game WHERE id = 1012

3.
SELECT player,teamid,stadium,mdate
  FROM game JOIN goal ON (id=matchid)
  WHERE teamid = 'GER'  

4.
SELECT team1,team2,player FROM game
JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%'

5.
SELECT player, teamid,coach,gtime
  FROM goal JOIN eteam ON (teamid=id)
  WHERE gtime<=10

6.
SELECT mdate,teamname FROM game
JOIN eteam ON (team1 = eteam.id)
WHERE coach = 'Fernando Santos'

7.
SELECT player FROM goal
JOIN game ON (id=matchid)
WHERE stadium = 'National Stadium, Warsaw'

8.
SELECT distinct(player)
  FROM game JOIN goal ON matchid = id 
  WHERE (team1 = 'GER' OR team2 = 'GER')
  AND teamid <> 'GER'

9.
SELECT teamname,COUNT(player) as 'goals scored'
  FROM eteam JOIN goal ON id=teamid
  GROUP BY teamname

10.
SELECT stadium,COUNT(stadium) AS 'goals scored'
  FROM game JOIN goal ON id=matchid
  GROUP BY stadium

11.
SELECT matchid,mdate,COUNT(id)
  FROM game JOIN goal ON matchid = id 
   WHERE (team1 = 'POL' OR team2 = 'POL')
  GROUP BY id,matchid,mdate

12.
SELECT matchid,mdate,COUNT(matchid) AS 'goals'
FROM game JOIN goal ON id=matchid
WHERE teamid = 'GER'
GROUP BY matchid,mdate

13.
SELECT
        mdate,
        team1,
        SUM(CASE                  
            WHEN teamid=team1 THEN 1                              
            ELSE 0              
        END) as 'score1',
        team2,
        SUM(CASE                  
            WHEN teamid=team2 THEN 1                  
            ELSE 0              
        END) as 'score2'             
    FROM
        game          
    LEFT JOIN
        goal                  
            ON (
                goal.matchid = game.id                 
            )          
    GROUP BY
        mdate,
        team1,
        team2          
    ORDER BY
        mdate,
        matchid,
        team1,
        team2     ;

-- SQLZoo More JOIN Tutorial
1.
SELECT id, title
 FROM movie
 WHERE yr=1962 AND budget > 2000000 

2.
SELECT yr FROM movie
WHERE title = 'Citizen Kane'

3.
SELECT id, title, yr FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr

4.
SELECT id FROM actor
WHERE name = 'Glenn Close'

5.
SELECT id FROM movie
WHERE title = 'Casablanca' AND yr = 1942

6.
SELECT name FROM actor
JOIN casting ON id=actorid
WHERE movieid = 132689

7.
SELECT name FROM actor
JOIN casting ON id=actorid
WHERE movieid = 
(SELECT id FROM movie
WHERE title = 'Alien') 

8.
SELECT title FROM movie
JOIN casting ON id=movieid
WHERE actorid IN (
SELECT id FROM actor
JOIN casting ON id=actorid
WHERE name = 'Harrison Ford')

9.
SELECT title FROM movie
JOIN casting ON movie.id=movieid
JOIN actor ON actor.id=actorid
WHERE name = 'Harrison Ford' AND ord != 1

10.
SELECT title,name FROM movie
JOIN casting ON movie.id=movieid
JOIN actor ON actor.id=actorid
WHERE yr = 1962 AND ord = 1

11.
SELECT movie.title, actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE casting.ord = 1
  AND movie.id IN (
      SELECT movieid
      FROM casting
      JOIN actor ON actorid = actor.id
      WHERE name = 'Julie Andrews'
  )

12.
SELECT movie.title, actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE casting.ord = 1
  AND movie.id IN (
      SELECT movieid
      FROM casting
      JOIN actor ON actorid = actor.id
      WHERE name = 'Julie Andrews'
  )

13.
SELECT name FROM actor
JOIN casting ON actorid=actor.id
JOIN movie ON movieid=movie.id
WHERE casting.ord=1
GROUP BY actor.name
HAVING COUNT(*) >= 15
ORDER BY actor.name

14.
SELECT title,COUNT(*) AS num_actors FROM movie
JOIN casting ON movie.id=movieid
WHERE movie.yr = 1978
GROUP BY movie.id,movie.title
ORDER BY num_actors DESC, movie.title

15.
SELECT DISTINCT(name) FROM actor 
JOIN casting ON actorid=actor.id 
JOIN movie ON movieid=movie.id 
WHERE movieid IN 
(SELECT movieid FROM casting
JOIN actor ON actorid=actor.id
WHERE name = 'Art Garfunkel')
AND actor.name != 'Art Garfunkel'

-- SQLZoo Using Null Tutorial
1.
SELECT name FROM teacher
WHERE dept IS NULL

2.
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

3.
SELECT teacher.name,dept.name FROM teacher
LEFT JOIN dept ON (teacher.dept=dept.id)

4.
SELECT teacher.name,dept.name FROM teacher
RIGHT JOIN dept ON (teacher.dept=dept.id)

5.
SELECT teacher.name, COALESCE(teacher.mobile,'07986 444 2266') AS mobile
FROM teacher

6.
SELECT teacher.name,COALESCE(dept.name,'None') AS dept_name
FROM teacher
LEFT JOIN dept ON teacher.dept=dept.id

7.
SELECT COUNT(teacher.name) AS num_teachers,
COUNT(teacher.mobile) AS num_mobile
FROM teacher

8.
SELECT dept.name,COUNT(teacher.name) FROM dept
LEFT JOIN teacher ON dept.id=teacher.dept
GROUP BY dept.name

9.
SELECT teacher.name,
CASE
WHEN teacher.dept = 1 OR teacher.dept=2
THEN 'Sci'
ELSE 'Art'
END
FROM teacher

10.
SELECT teacher.name,
CASE
WHEN teacher.dept = 1 OR teacher.dept=2
THEN 'Sci'
WHEN teacher.dept = 3
THEN 'Art'
ELSE 'None'
END
FROM teacher

-- SQLZoo Self Join Tutorial
1.
SELECT DISTINCT(COUNT(name)) FROM stops

2.
SELECT id FROM stops
WHERE name = 'Craiglockhart'

3.
SELECT stops.id,stops.name FROM stops
JOIN route ON route.stop=stops.id
WHERE route.num = '4'
AND route.company = 'LRT'

4.
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2

5.
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53
AND b.stop = 
(SELECT id FROM stops
WHERE name = 'London Road')

6.
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'London Road'


7.
SELECT DISTINCT(a.company), a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop = 115
AND b.stop = 137

8.
SELECT DISTINCT(a.company), a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'Tollcross'

9.
SELECT stopb.name,a.company, b.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'

10.
SELECT DISTINCT
    a.num, a.company,         -- first bus
    stopb.name,               -- transfer stop
    c.num, c.company          -- second bus
FROM route a
JOIN route b
  ON a.company = b.company
 AND a.num = b.num
JOIN stops stopa
  ON a.stop = stopa.id
JOIN stops stopb
  ON b.stop = stopb.id,
     route c
JOIN route d
  ON c.company = d.company
 AND c.num = d.num
JOIN stops stopc
  ON c.stop = stopc.id
JOIN stops stopd
  ON d.stop = stopd.id
WHERE stopa.name = 'Craiglockhart'
  AND stopd.name = 'Lochend'
  AND stopb.id = stopc.id
ORDER BY a.num, stopb.name, c.num;
