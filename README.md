# Tutorials on Data Frames and Relational Databases
 
This repository contains tutorials on manipulating data frames and querying relational databases. Tools covered include:

- Traditional `SQL` tools such as __`PostgreSQL`__ and __`MySQL`__;

- `Python` __`Pandas`__ data frames;

- `R` __`data.frame`__ and __`data.table`__; and
 
- `Apache Spark`, which ships with __`Spark DataFrame`__ and __`Spark SQL`__.

In order to provide meaningful context and motivation, tutorials are structured as dataset-centric cases, with similar examples illustrated in multiple ways using different tools.



## Software Installation Requirements & Guides


### `Git` & Related Version-Control Software

[__`Git`__](https://git-scm.com) is the go-to software solution for version control / change-tracking of programming code and related materials.

Follow [__instructions__ on the Chicago Booth Analytics wiki](https://github.com/ChicagoBoothAnalytics/site/wiki/Git-%26-Git-related-version-control-software) to download and install:
- __`Git`__; and
- __`SourceTree`__.


### Clone Chicago Booth Analytics's `Software` and `RelationalData` Repos onto Your Computer

One you have installed `Git` and `SourceTree`, use `SourceTree` to __clone__ the following GitHub repos onto folders on your computer: 
- [__`Software`__](https://github.com/ChicagoBoothAnalytics/Software), which contains scripts for install some difficult software; and
- [__`RelationalData`__](https://github.com/ChicagoBoothAnalytics/RelationalData), _i.e._ this tutorial repo.


### JetBrains `DataGrip` `SQL` IDE

[JetBrains](https://www.jetbrains.com), a developer of some of the best integrated development environments (IDEs), has a nice IDE named [__`DataGrip`__](https://www.jetbrains.com/datagrip) for working with relational databases.

Follow [__instructions__ on the Chicago Booth Analytics wiki](https://github.com/ChicagoBoothAnalytics/site/wiki/JetBrains-DataGrip-DBMS-IDE-Installation) to download and install `DataGrip`.


### Anaconda `Python` v2.7 & `Python` Packages
 
For `Python`, we highly recommend [Continuum Analytics](https://www.continuum.io)'s [__`Anaconda`__ distribution](http://docs.continuum.io/anaconda/index), which helpfully pre-packages hundreds of useful packages for scientific computing and saves you the frustration of installing those on your own.
 
Follow [__instructions__ on the Chicago Booth Analytics wiki](https://github.com/ChicagoBoothAnalytics/site/wiki/Anaconda-Python-Installation) to download and install __`Anaconda Python` v2.7__. 

Then, enter a __shell command-line terminal__ &ndash; the default terminal on Mac / `Git Bash` terminal on Windows (see the [`Git` installation instructions](https://github.com/ChicagoBoothAnalytics/site/wiki/Git-&-Git-related-version-control-software)) &ndash; and:
- navigate to folder __`<your local Chicago Booth Analytics Software repo folder>/Python`__ and run the following commands:
    - __`sh Install-SQL-Related-Packages.sh`__;
        - note that for __Windows__, in order to get the __`pycopg2`__ package (essential for interacting with `PostgreSQL` databases_:
            - go [__here__](http://www.lfd.uci.edu/~gohlke/pythonlibs/#psycopg);
            - download a `.whl` file appropriate for your Windows machine's processor (32-bit / 64-bit);
            - enter a command-line terminal, navigate to the download folder; and
            - run command: __`pip install <the-downloaded-file-name.whl>`__;
    - __`sh Install-ApacheSpark-Related-Packages.sh`__; and
    - __`sh Install-Visualization-Packages.sh`__.
    

### `R` & `R` packages

Follow [__instructions__ on the Chicago Booth Analytics wiki](https://github.com/ChicagoBoothAnalytics/site/wiki/R-Installation) to download and install __`R`__ of __version at least 3.2.3__. 



## Outline of Topics


### __`SQL`__

__Note__: the main `SQL` dialect we use here is __`PostgreSQL`__, which usually provides a very good starting point for learning `SQL`. Other `SQL` dialects such as `MySQL`, `HiveQL`, _etc._ have some syntactic differences compared with `PostgreSQL`, especially regarding advanced functionalities.

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
- __`VALUES`__ clause to create table on the fly
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
    - __`ROW_NUMBER()`__, __`RANK()`__ & __`DENSE_RANK()`__
    - __`LAG`__ & __`LEAD`__


### `Python Pandas DataFrame`

Basic:
- __`len(<Pandas DataFrame>)`__: count number of rows
- __`.columns`__: list of columns
- __`.info(...)`__: summary, including column data types
- __`.loc[..., ...]`__: slicing of by string-label indices and column names, plus boolean logical conditions
- __`.iloc[..., ...]`__: slicing by integer indices and integer column numbers
- __`.ix[..., ...]`__: versatile slicing by a mixture of integer and string indices and column names, plus boolean logical conditions
<br><br>

Intermediate:
- __`.unique()`__: list unique / distinct values from a `Pandas` __series__ / `DataFrame` column
- __`.isnull()`__: detect `None` & `numpy.nan` values
- __`.rename(...)`__: rename columns
<br><br>

Advanced:
- __`.groupby(...)`__: similar to `GROUP BY` in `SQL`
<br><br>


### `PySpark DataFrame`

Basic:
- __`.count()`__: count number of rows 
- __`.columns`__: list of columns
- __`.printSchema()`__: summarize column data types
- __`.show(...)`__: show certain number of first rows
- __`.select(...)`__: select certain columns
- __`.toPandas`__: convert to `Pandas DataFrame`

Intermediate:
- __`.distinct()`__: select distinct rows
<br><br>
