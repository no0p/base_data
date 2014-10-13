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
