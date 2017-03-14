if(!exists('access_database_R')){
  access_database_R<-T
  
  database_path <- "D:/workarea/epa_explorer/epa_db.db"
  
  getSQL <- function(sql_query, updateProgress = NULL) {
    
    library(RSQLite)
    library(dplyr)
    
    con <- dbConnect(RSQLite::SQLite(), database_path)
    rs <- dbSendQuery(con, sql_query)
    
    i <- 0
    datalist = list()
    while (!dbHasCompleted(rs)) {
      datalist[[i<-i+1]]<-dbFetch(rs, 100000)
      if (is.function(updateProgress)) updateProgress(detail=dbGetRowCount(rs))
    }

    dbClearResult(rs)
    dbDisconnect(con)
    return(bind_rows(datalist))
  }
  
  getData <- function(select, where = NULL, updateProgress = NULL) {
    
    select <- paste(select,collapse=",")
    
    if (is.null(where))
      sql_query<-paste(c("SELECT", select, "FROM epa_table"),collapse=" ")
    else
      sql_query<-paste(c("SELECT", select, "FROM epa_table WHERE", where),collapse=" ")
    
    return(getSQL(sql_query,updateProgress))
  }
}