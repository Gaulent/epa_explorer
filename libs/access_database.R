
# Obtener parches que faltan
if(!exists('access_database_R')){
  access_database_R<-T
  
  getSQL <- function(sql_query) {
    
    library(RSQLite)
    database_path <- "D:/workarea/epa_explorer/epa_db.db"

    con <- dbConnect(RSQLite::SQLite(), database_path)
    rs <- dbSendQuery(con, sql_query)
    result_data<-dbFetch(rs,n=-1)
    dbClearResult(rs)
    dbDisconnect(con)
    return(result_data)
  }
  
  getData <- function(select, where = NULL) {
    select <- paste(select,collapse=",")
    if (is.null(where))
      sql_query<-paste(c("SELECT", select, "FROM epa_table"),collapse=" ")
    else
      sql_query<-paste(c("SELECT", select, "FROM epa_table WHERE", where),collapse=" ")
    return(getSQL(sql_query))
  }
}