-- LOAD
-- This operator is used to load data from the file system or HDFS storage into a Pig relation.
loading1 = LOAD 'input/tutorial/first.csv' USING PigStorage(',') AS (user: chararray, url: chararray, id: int);
loading2 = LOAD 'input/tutorial/second.csv' USING PigStorage(',') AS (url: chararray, rating: int);

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
