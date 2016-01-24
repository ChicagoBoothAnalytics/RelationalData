# Tutorials on Data Frames and Relational Databases
 
This repository contains tutorials on manipulating data frames and querying relational databases. Tools covered include:

- Traditional `SQL` tools such as __`PostgreSQL`__ and __`MySQL`__;

- `R` __`data.frame`__ and __`data.table`__;

- `Python` __`Pandas`__ data frames; and
 
- `Apache Spark`, which ships with __`Spark DataFrame`__ and __`Spark SQL`__.

In order to provide meaningful context and motivation, tutorials are structured as dataset-centric cases, with similar examples illustrated in multiple ways by different tools.


## Software Installation Requirements & Guides


## Outline of Topics

### __`SQL`__

__Note__: the `SQL` dialect used to illustrate the below topics is __`PostgreSQL`__


Basic:
- __`SELECT`__ all columns / certain columns of table
- __`SELECT ... INTO TEMP TABLE ...`__ for creating temporary / intermediate table from query results
    - __`DROP TABLE IF EXISTS ...`__ for deleting temp table
- __`LIMIT`__ number of rows returned
- __`AS`__ for aliasing / renaming
- __`NULL`__ values for empty cells
- __`DISTINCT`__ values of a column, or tuples of values across columns
- __`WHERE`__ & logical comparisons:
    - __`=`__ for equality
    - __`!=`__, __`>`__, __`>=`__, __`<`__, __`<=`__ for inequalities
    - __`IN`__ for checking membership in values list
    - __`LIKE`__ & __`ILIKE`__ for string matching
- __`ORDER BY`__ for sorting
- Aggregating functions:
    - __`COUNT`__, __`SUM`__ & __`AVG`__
    - __`MAX`__ & __`MIN`__
- __`GROUP BY`__ for grouped aggregation
<br><br>


Intermediate:
- __`COALESCE(...)`__ for replacing `NULL` values
- __`CAST(... AS ...)`__ for conversion among common data types:
    - __`INT`__ for integers
    - __`DOUBLE PRECISION`__ for double-precision floating-point numbers
    - __`STR`__ for strings
    - __`DATE`__ for dates
    - __`TIMESTAMP`__ for date-times
- __`CASE WHEN ... THEN ... WHEN ... THEN ... ELSE ... END`__ conditional logics
- __`JOIN`__ & __`LEFT JOIN`__ among 2 or more tables
    - __Equality__ Join & __Non-Equality__ Join
<br><br>


Advanced:
- __String__-manipulating functions
    - __`CONCAT`__ for concatenating strings
    - __`SUBSTR`__ for getting part of string
- __Date/Time__-manipulating functions
    - __`EXTRACT(... FROM ...)`__ for getting date/time component
    - __`TO_CHAR`__ for converting date/time component to string
- __Sub-queries__ & Common Table Expressions (CTEs)
- __Windowing__ (__`PARTITION BY`__ & __`ORDER BY`__) & __Windowed Analytics Functions__:  
    - __`ROW_NUMBER()`__, __`RANK()`__ & `DENSE_RANK()`
    - __`LAG`__ & __`LEAD`__
