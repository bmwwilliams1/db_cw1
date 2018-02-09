-- Question 1

-- SELECT name, father, mother
-- FROM   person
-- WHERE  dod IS NOT NULL
-- AND    name IN
-- ( SELECT child.name
--   FROM person AS child JOIN person AS father
--   ON child.father = father.name
--   WHERE child.dod < father.dod
-- )
-- AND name IN
-- ( SELECT child.name
--   FROM person AS child JOIN person AS mother
--   ON child.mother = mother.name
--   WHERE child.dod < mother.dod
-- )
-- ORDER BY name;


-- Question 2
-- SELECT DISTINCT name
-- FROM
--   (SELECT name FROM monarch WHERE house IS NOT NULL) AS mon_names
--   UNION
--   (SELECT name FROM prime_minister)
-- ORDER BY name;


-- Question 3
-- SELECT DISTINCT person.name
-- FROM person NATURAL JOIN monarch
-- WHERE EXISTS
--   (SELECT name
--     FROM monarch AS second
--     WHERE second.accession>monarch.accession
--     AND second.accession < person.dod)
-- ORDER BY name;


-- --Question 4
-- SELECT house,
--       name,
--       accession
-- FROM monarch
-- WHERE house IS NOT NULL
-- AND accession <= ALL(SELECT accession FROM monarch AS second WHERE monarch.house = second.house)
-- ORDER BY accession;

--
--
-- -- Question 5
SELECT first_name,
        COUNT(first_name) AS popularity
FROM (SELECT (LEFT(name, CASE WHEN POSTIION(name,' ') = 0 THEN
    LENGTH(name) ELSE POSITION(name,' ') - 1 END)) AS first_name FROM person) AS first_names
GROUP BY first_name
HAVING COUNT(first_name) > 1
ORDER BY popularity DESC, first_name;

-- Question 6
SELECT *
FROM (SELECT (LEFT(accession,2)) AS century FROM monarch) AS centuries;
