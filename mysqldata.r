install.packages('RMySQL', repos='http://cran.us.r-project.org')

# Establish database connection
library('RMySQL')
drv <- dbDriver("RMySQL")
con <- dbConnect(drv, dbname="robert", user="robert", host="localhost")

ddlq <- 'create schema rdata;'
insq <- ''
table_names <- c()

parse_row <- function(x) {
  
  vals <- c()
  for (i in x) {
    if (is.na(i)) {
      vals <- c(vals, "NULL")
    } else {
      if (class(i) == 'numeric') {
        vals <- c(vals, i)
      } else {
        vals <- c(vals, paste("'", i, "'", sep=""))
      }
    }
  }
  
  return(sprintf("(%s)", paste(vals, collapse=", ")))
}

# Loop over datasets available from data
#   to generate sql
for (i in data()$results[,3]) {
  name <- unlist(strsplit(i, " "))[1]
  
  if (class(eval(parse(text=name))) != 'dist') {
    fr <- as.data.frame(eval(parse(text=name)))
    
    table_name <- tolower(gsub("\\.", "_", gsub("\\s", "", name)))
    
    if (table_name %in% table_names) {
      table_name <- paste(table_name, '_2', sep="")
    }
    table_names <- c(table_names, table_name)
    
    # Generate sql for column entries in table
    cols <- ''
    col_names <- c()
    for (n in colnames(fr)) {
      # determine type
      dtype <- 'text'
      if (class(as.vector(fr[,n])[1]) == 'numeric') {
        dtype <- 'numeric'
      }
      
      # adjust name
      col <- tolower(gsub("\\.", "_", gsub("\\s", "_", n)))
      if (col == 'id') {
        col <- 'rid'
      }
      
      cols <- paste(cols, ', "', col, '" ', dtype, sep="")
      col_names <- c(col_names, paste('"', col, '"', sep=""))
    }
    
    # Generate values sql for insert statement
    data_vals <- apply(fr, 1, parse_row)
      
    ctq <- sprintf('create table rdata.%s (id serial primary key %s);', table_name, cols )
    dtq <- sprintf('insert into rdata.%s (%s) values %s;', table_name, paste(col_names, collapse=", "), paste(data_vals, collapse=", "))
    
    ddlq <- paste(ddlq, ctq)
    insq <- paste(insq, dtq)
  }
  
}

dbSendQuery(con, ddlq)
dbSendQuery(con, insq)

