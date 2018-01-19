-- LOAD
-- This operator is used to load data from the file system or HDFS storage into
-- a Pig relation.
loading1 = LOAD 'input/tutorial/first.csv' USING PigStorage(',') AS (user: chararray, url: chararray, id: int);
loading2 = LOAD 'input/tutorial/second.csv' USING PigStorage(',') AS (url: chararray, rating: int);
loading3 = LOAD 'input/tutorial/third.csv' USING PigStorage(',') AS (user: chararray, url: chararray, id: int);

-- FOREACH
-- This operator generates data transformations based on columns of data.
-- It is used to add or remove fields from a relation.
-- Use FOREACH-GENERATE operation to work with columns of data.
for_each = FOREACH loading1 GENERATE url,id;
DUMP for_each;

-- FILTER
-- This operator selects tuples from a relation based on a condition.
filter_command = FILTER loading1 BY id > 8;
DUMP filter_command;

-- JOIN
-- JOIN operator is used to perform an inner, equijoin join of two or more
-- relations based on common field values.
-- The JOIN operator always performs an inner join.
-- Inner joins ignore null keys, so it makes sense to filter them out before
-- the join.
join_command = JOIN loading1 BY url, loading2 BY url;
DUMP join_command;

-- ORDER BY
-- ORDER BY is used to sort a relation based on one or more fields.
-- You can do sorting in ascending or descending order using ASC and DESC
-- keywords.
loading4 = ORDER loading2 BY rating ASC;
DUMP loading4;

-- DISTINCT
-- DISTINCT removes duplicate tuples in a relation.
loading3_distinct = DISTINCT loading3;
DUMP loading3_distinct;

-- STORE
-- STORE is used to save results to the file system.
STORE loading3 INTO 'output/tutorial';

-- GROUP
-- The GROUP operator groups together the tuples with the same group key
-- (key field).
-- The key field will be a tuple if the group key has more than one field,
-- otherwise it will be the same type as that of the group key.
-- The result of a GROUP operation is a relation that includes one tuple per
-- group.
group_command = GROUP loading1 BY url;
DUMP group_command;

-- COGROUP
-- COGROUP is same as GROUP operator. For readability, programmers usually use
-- GROUP when only one relation is involved and COGROUP when multiple relations
-- are involved.
cogroup_command = COGROUP loading1 BY url, loading2 BY url;
DUMP cogroup_command;

-- CROSS
-- The CROSS operator is used to compute the cross product (Cartesian product)
-- of two or more relations.
cross_command = CROSS loading1, loading2;
DUMP cross_command;

-- LIMIT
-- LIMIT operator is used to limit the number of output tuples. If the specified
-- number of output tuples is equal to or exceeds the number of tuples in the
-- relation, the output will include all tuples in the relation.
limit_command = LIMIT loading1 3;
DUMP limit_command;

-- SPLIT
-- SPLIT operator is used to partition the contents of a relation into two or
-- more relations based on some expression. Depending on the conditions stated
-- in the expression.
SPLIT loading2 INTO x IF rating > 8, y IF rating <= 8;
DUMP x;
DUMP y;
