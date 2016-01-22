# Relational Data Analysis Case: __Kaggle AirBnB__ Data Set

## `SQL` Topics

Basic:

- `SELECT` all columns of a table
- `SELECT` certain columns of a table
- `SELECT ... INTO TEMP TABLE ...` for creating intermediate tables
    - `DROP TABLE IF EXISTS ...` for deleting temp table
- `LIMIT` number of rows returned
- `AS` (aliasing / renaming)
- `NULL` values for empty cells
- `DISTINCT` values of a column, or tuples of values across columns
- `ORDER BY` (sorting)
- `GROUP BY` (aggregation)
<br><br>


Intermediate:
- `CAST(... AS ...)` for conversion among common data types:
    - `INT`
    - `DOUBLE PRECISION`
    - `STR`
    - `DATE`
    - `TIMESTAMP`
- `CASE WHEN ... THEN ... WHEN ... THEN ... ELSE ... END` conditional logics
- `JOIN` & `LEFT JOIN` among 2 or more tables
    - Equality Join & Non-Equality Join
<br><br>


Advanced:

- String-manipulating functions
    - `CONCAT` for concatenating strings
    - `SUBSTR` for getting part of string
    
- Date/Time-manipulating functions
    - `EXTRACT(... FROM ...)` for getting date/time component
    - `TO_CHAR` for converting date/time component to string
    
- Sub-queries
- Window functions
