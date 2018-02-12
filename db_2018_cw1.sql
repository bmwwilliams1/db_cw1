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
--

-- Question 2
-- SELECT DISTINCT name
-- FROM
--   (SELECT name FROM monarch WHERE house IS NOT NULL) AS mon_names
--   UNION
--   (SELECT name FROM prime_minister)
-- ORDER BY name;


-- Question 3
-- SELECT DISTINCT person.name
-- FROM person JOIN monarch
-- WHERE person.name = monarch.name
-- AND EXISTS
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
-- SELECT first_name,
--         COUNT(first_name) AS popularity
-- FROM (SELECT (LEFT(name, CASE WHEN POSITION(' ' IN name) = 0 THEN
--     LENGTH(name) ELSE POSITION(' ' IN name) - 1 END)) AS first_name FROM person) AS first_names
-- GROUP BY first_name
-- HAVING COUNT(first_name) > 1
-- ORDER BY popularity DESC, first_name;

-- Question 6
-- SELECT house,
--        SUM(CASE WHEN accession >= '1900-01-01' THEN 1 ELSE 0 END) AS twentieth,
--        SUM(CASE WHEN accession >= '1800-01-01' AND accession < '1900-01-01' THEN 1 ELSE 0 END) AS nineteenth,
--        SUM(CASE WHEN accession >= '1700-01-01' AND accession < '1800-01-01' THEN 1 ELSE 0 END) AS eighteenth,
--        SUM(CASE WHEN accession >= '1600-01-01' AND accession < '1700-01-01' THEN 1 ELSE 0 END) AS seventeenth
-- FROM monarch
-- GROUP BY house
-- HAVING house IS NOT NULL
-- ORDER BY house;

-- Question 7
-- SELECT dad.name AS father,
--       kid.name AS child,
--       (CASE   WHEN ((SELECT COUNT(name) FROM person AS kids WHERE kids.father = dad.name)>0)
--               THEN ((SELECT COUNT(name) FROM person AS siblings WHERE kid.father = siblings.father AND siblings.dob < kid.dob)+1)
--               ELSE null END
--       ) as born
-- FROM  person AS dad LEFT JOIN person AS kid
-- ON    dad.name = kid.father
-- WHERE dad.gender = 'M'
-- ORDER BY dad.name,born;

--Question 8
SELECT DISTINCT monarch.name AS monarch,
       prime_minister.name AS prime_minister
FROM   monarch JOIN prime_minister
ON     (monarch.accession <= prime_minister.entry)
AND    NOT EXISTS (SELECT name FROM monarch AS before WHERE before.accession > monarch.accession AND before.accession <= prime_minister.entry)
ORDER BY monarch.name,prime_minister.name;
