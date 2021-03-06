# Tutorials on Data Frames and Relational Databases
 
This repository contains tutorials on manipulating data frames and querying relational databases. Tools covered include:

- Traditional `SQL` tools such as __`PostgreSQL`__ and __`MySQL`__;

- `Python` __`Pandas`__ data frames;

- `R` __`data.frame`__ and __`data.table`__; and
 
- `Apache Spark`, which ships with __`Spark DataFrame`__ and __`Spark SQL`__.

In order to provide meaningful context and motivation, tutorials are structured as dataset-centric cases, with similar examples illustrated in multiple ways using different tools.



## 1. Outline of Topics


### 1.1. __`SQL`__

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
- __`CROSS JOIN`__ to create Cartesian product
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


### 1.2. __`Python Pandas DataFrame`__

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
- __`.drop_duplicates(...)`__: return unique / distinct rows of a `Pandas DataFrame`
- __`.isnull()`__: detect `None` & `numpy.nan` values
- __`.rename(...)`__: rename columns
<br><br>

Advanced:
- __`.groupby(...)`__: similar to `GROUP BY` in `SQL`
<br><br>


### 1.3. __`R data.frame`__

Basic:
- __`nrow(<data.frame>)`__: count number of rows
- __`colnames(<data.frame>)`__ / __`names(<data.frame>)`__: vector of column names
- __`summary(<data.frame>)`__: summarize `data.frame`
- __`<data.frame>[..., ]`__: select rows of `data.frame` by row numbers or by logical conditions
- __`<data.frame>[..., c(<selected column names>)]`__: select specific columns of `data.frame`, and select certain rows only by either row numbers or logical conditions

Intermediate:
- __`unique(<data.frame>)`__: obtain unique / distinct rows of `data.frame`

Advanced:
- __`aggregate(...)`__: aggregrate by group, similar to `GROUP BY` in `SQL`
<br><br>


### 1.4. __`R data.table`__

Basic:
- __`nrow(<data.table>)`__: count number of rows
- __`colnames(<data.table>)`__ / __`names(<data.table>)`__: vector of column names
- __`summary(<data.table>)`__: summarize `data.table`
- __`<data.table>[...]`__: select rows of `data.table` by row numbers or by logical conditions
- __`<data.table>[..., .(<selected column names>)]`__: select specific columns of `data.table`, and select certain rows only by either row numbers or logical conditions

Intermediate:
- use of __`get(...)`__ to get variables by name inside the `data.table` namespace
- use of __`:=`__ for assignment within the `data.table` namespace
- use of __`with=FALSE`__ to force literal interpretation of inputs passed into `[..., ...]`
- __`setnames(...)`__ for renaming `data.table` column names
- __`unique(<data.table>)`__: obtain unique / distinct rows of `data.table`

Advanced:
- __`<data.table>[..., ..., by=...]`__: aggregrate by group, similar to `GROUP BY` in `SQL`
<br><br>


### 1.5a. __`PySpark SQL DataFrame`__

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


### 1.5b. __`SparkR SQL DataFrame`__

Basic:
- __`count(<SparkR SQL DataFrame>)`__: count number of rows
- __`columns(<SparkR SQL DataFrame>)`__: vector of column names
- __`printSchema(<SparkR SQL DataFrame>)`__: summarize column data types
- __`showDF(<SparkR SQL DataFrame>, <numRows>)`__: show certain number of first rows
- __`select(...)`__: select certain columns
- __`as.data.frame`__: convert to `R` `data.frame`

Intermediate:
- __`distinct(<SparkR SQL DataFrame>)`__: select distinct rows


## 2. Tips for Exploratory Analyses of Relational Data

Below is a simple checklist of things you may want to examine to effectively explore a set of relational data:

- For each table, examine which columns are __numeric__ and which are __categorical__ in nature, and which represent a body of __text__ or an __array__ of values;

- For each categorical column, list out the __distinct categories__, count their frequencies, and, if there are too many, consider how you may group them into __fewer super-categories__;

- Define a number of __metrics__ you believe are relevant; for each metric, examine its:
    - __Growth trends__ over time;
    - __Cyclical changes__ across ___hours of a day___, ___days of a week___, ___months of a year___, _etc._;
    - __Cross-sectional variations__ & __rankings__ across categories / segments / tiers of data.



## 3. Software Installation Requirements & Guides

There are 3 possible setups for running these tutorials:

1. Running on an __Amazon Web Services Elastic MapReduce__ (__AWS EMR__) __server cluster__ (recommended)
2. Running on a single __Mac__ or __Windows__ machine that is __sufficiently high-spec__:
    - RAM >= 12GB
    - No. of Processor Cores >= 8


### 3.1. AWS EMR

If you wish to use the recommended AWS EMR setup:

- Follow the [__instructions__ on the Chicago Booth Analytics wiki](https://github.com/ChicagoBoothAnalytics/site/wiki/AWS-Elastic-MapReduce-(EMR)-Cluster-Setup) to set up the necessary software for working with AWS EMR;

- Test your set up:
    
    - Launch a __shell command-line terminal window__:
        - ___Mac___: the default terminal;
        - ___Windows___: please use the __`Git Bash`__ terminal that ships with `Git` &ndash; don't use the Windows terminal;
            
    - Navigate to __`<path to your cloned Chicago Booth Analytics Software folder>/AWS/EMR`__ in the command-line terminal;
    
    - Bid for a basic EMR cluster of 1 Master + 2 Workers of M3.xLarge server type, trying a price range around $0.050/server/hour, by running a command like: `sh create.sh` `-b` __`<my-s3-bucket-in-cali>`__ `-m` __`m3.xlarge`__ `-p` __`0.050`__ `-n` __`2`__ `-t` __`m3.xlarge`__ `-q` __`0.050`__ `-r` __`"a normal cluster with M3.xLarge servers"`__
    
    - Check the [Northern California AWS EMR management console](us-west-1.console.aws.amazon.com/elasticmapreduce) to verify that:
        - the cluster enters the "__Bootstrapping__" stage after about 15 minutes
            - if it does not, that means your price is too low; terminate the cluster and try again
        - the cluster enters the "__Running__" stage after about 30-45 minutes
        
    - Once the cluster is in the "__Running__" stage, connect to the cluster by running command: __`sh connect -d <Your-Cluster-Master-Public-DNS>`__ and typing _"yes"_ to accept any questions in the command-line terminal
        - the command should open a new tab on your internet browser, with address __`localhost:8133`__; if that does not happen, manually go to  __`localhost:8133`__ in a browswer windows
        - check that you see __`Jupyter`__ environment in the browser window
        
    - Terminate your cluster through the AWS EMR management console.
    
    
### 3.2. Single Mac or Windows machine
         
If your computer is __sufficiently high-spec__ (RAM >= 12GB, No. of Processor Cores >= 8), you may try running the tutorials locally.

You will need the following software setup:


#### 3.2.1. `Git` & Related Version-Control Software

[__`Git`__](https://git-scm.com) is the go-to software solution for version control / change-tracking of programming code and related materials.

Follow [__instructions__ on the Chicago Booth Analytics wiki](https://github.com/ChicagoBoothAnalytics/site/wiki/Git-%26-Git-related-version-control-software) to download and install:
- __`Git`__; and
- __`SourceTree`__.


#### 3.2.2. Clone Chicago Booth Analytics's `Software` and `RelationalData` Repos onto Your Computer

One you have installed `Git` and `SourceTree`, use `SourceTree` to __clone__ the following GitHub repos onto folders on your computer: 
- [__`Software`__](https://github.com/ChicagoBoothAnalytics/Software), which contains scripts for install some difficult software; and
- [__`RelationalData`__](https://github.com/ChicagoBoothAnalytics/RelationalData), _i.e._ this tutorial repo.


#### 3.2.3. JetBrains `DataGrip` `SQL` IDE

[JetBrains](https://www.jetbrains.com), a developer of some of the best integrated development environments (IDEs), has a nice IDE named [__`DataGrip`__](https://www.jetbrains.com/datagrip) for working with relational databases.

Follow [__instructions__ on the Chicago Booth Analytics wiki](https://github.com/ChicagoBoothAnalytics/site/wiki/JetBrains-DataGrip-DBMS-IDE-Installation) to download and install `DataGrip`.


#### 3.2.4. Anaconda `Python` v2.7 & `Python` Packages
 
For `Python`, we highly recommend [Continuum Analytics](https://www.continuum.io)'s [__`Anaconda`__ distribution](http://docs.continuum.io/anaconda/index), which helpfully pre-packages hundreds of useful packages for scientific computing and saves you the frustration of installing those on your own.
 
Follow [__instructions__ on the Chicago Booth Analytics wiki](https://github.com/ChicagoBoothAnalytics/site/wiki/Anaconda-Python-Installation) to download and install __`Anaconda Python` v2.7__. 

Then, enter a __shell command-line terminal__ &ndash; the default terminal on Mac / `Git Bash` terminal on Windows (see the [`Git` installation instructions](https://github.com/ChicagoBoothAnalytics/site/wiki/Git-&-Git-related-version-control-software)) &ndash; and:
- navigate to folder __`<your local Chicago Booth Analytics Software repo folder>/Python`__ and run the following commands:
    - __`sh Install-SQL-Related-Packages.sh`__;
        - note that for __Windows__, in order to get the __`PsycoPG2`__ package (essential for interacting with `PostgreSQL` databases_:
            - go [__here__](http://www.lfd.uci.edu/~gohlke/pythonlibs/#psycopg);
            - download a `.whl` file appropriate for your Windows machine's processor (32-bit / 64-bit);
            - enter a command-line terminal, navigate to the download folder; and
            - run command: __`pip install <the-downloaded-file-name.whl>`__;
    - __`sh Install-ApacheSpark-Related-Packages.sh`__; and
    - __`sh Install-Visualization-Packages.sh`__.
    

#### 3.2.5. `R` & `R` packages

Follow [__instructions__ on the Chicago Booth Analytics wiki](https://github.com/ChicagoBoothAnalytics/site/wiki/R-Installation) to download and install __`R`__ of __version at least 3.2.3__.

Install certain `R`-related software:

- Launch a __shell command-line terminal window__:
    - ___Mac___: the default terminal;
    - ___Windows___: please use the __`Git Bash`__ terminal that ships with `Git` &ndash; don't use the Windows terminal;

- Navigate to __`<path to your cloned Chicago Booth Analytics Software folder>/R`__ in the command-line terminal;

- Install the __`iR` kernel for `Jupyter`__, to allow us to run `R` in the `Jupyter Notebook` environment: run command __`Rscript Install-JupyterIRKernel.R`__

- Install __basic `R` packages__: run command __`Rscript Install-Basic-Packages.R`__

- Install __SQL and Data Frame-related packages__: run command __`Rscript Install-SQL-and-DataFrame-Packages.R`__

- Install __Visualization packages__: run command __`Rscript Install-Visualization-Packages.R`__


#### 3.2.6. Test Your Local Mac / Windows Setup

- Launch a __shell command-line terminal window__:
    - ___Mac___: the default terminal;
    - ___Windows___: please use the __`Git Bash`__ terminal that ships with `Git` &ndash; don't use the Windows terminal;

- Navigate to __`<path to your cloned Chicago Booth Analytics RelationData folder>`__ __(this repo!)_ in the command-line terminal;

- Launch the `Jupyter` environment: run command __`jupyter notebook`__
    - this would launch a browser tab with address __`localhost:8888`__
    
- In the `Jupyter` environment in the browswer tab:
    - Enter the __`Test-Jupyter-Workbooks-for-Software-Setup`__ folder;
    - __Test the setup for `Python`__: open the __`Test-Python-Software-SetUps.ipynb`__ workbook, run all cells, and verify that there are no errors;
    - __Test the setup for `R`__: open the __`Test-R-Software-SetUps.ipynb`__ workbook, run all cells, and verify that there are no errors.
