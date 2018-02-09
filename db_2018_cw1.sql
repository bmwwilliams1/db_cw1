-- Question 1

SELECT name, father, mother
FROM person
WHERE dod IS NOT NULL
AND name IN
( SELECT child.name
  FROM person AS child JOIN person AS father
  ON child.father = father.name
  WHERE child.dod < father.dod
)
AND name IN
( SELECT child.name
  FROM person AS child JOIN person AS mother
  ON child.mother = mother.name
  WHERE child.dod < mother.dod
)
ORDER BY name;


-- Question 2
SELECT DISTINCT name
FROM
(SELECT name
  FROM monarch
  WHERE house IS NOT NULL) AS mon_names
UNION
(SELECT name FROM prime_minister)
ORDER BY name;
