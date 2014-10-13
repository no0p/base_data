## rdatapop

This create tables in Postgresql based on data sets from the data() function in R.

## Usage 

Edit the database connection details in the script.  The run the script:

```
Rscript pgdata.r
```

The script will populate tables in an rdata schema.

## Dependencies

The script obviously requires the R environment which can be installed on ubuntu systems with:

```
sudo apt-get install r-base-core
```

Additionally it requires the RPostgresql package to be installed, which can be installed with the following R command:

```
> install.packages("RPostgreSQL")
```

## Tables

The script creates a number of interesting data tables.

```
=# \d
                    List of relations
 Schema |             Name             |   Type   | Owner  
--------+------------------------------+----------+--------
 rdata  | ability_cov                  | table    | robert
 rdata  | airmiles                     | table    | robert
 rdata  | airpassengers                | table    | robert
 rdata  | airquality                   | table    | robert
 rdata  | anscombe                     | table    | robert
 rdata  | attenu                       | table    | robert
 rdata  | attitude                     | table    | robert
 ...
 (214 rows)
```

These tables are great for test data.

This data was used as a basis for prototyping <a href="http://no0p.github.io/postgresql/2013/11/18/background-working.html">a modeling Postgresql background worker experiment</a> and as examplars when developing <a href="https://github.com/no0p/plotpg/wiki/Plotting-Data">plotpg</a>.
