
# Obtener parches que faltan
if(!exists('access_database_R')){
  access_database_R<-T
  
  database_path <- "D:/workarea/epa_explorer/epa_db.db"
  
  getSQL <- function(sql_query) {
    
    library(RSQLite)
    
    con <- dbConnect(RSQLite::SQLite(), database_path)
    rs <- dbSendQuery(con, sql_query)
    result_data<-dbFetch(rs,n=-1)
    dbClearResult(rs)
    dbDisconnect(con)
    return(result_data)
  }
  
  getData <- function(select, where = NULL) {
    
    library(RSQLite)
    library(dplyr)
    
    print("test")
    
    select <- paste(select,collapse=",")
    if (is.null(where)) {
      sql_query<-paste(c("SELECT", select, "FROM epa_table"),collapse=" ")
      total_rows <- getSQL(paste(c("SELECT count(*) FROM epa_table"),collapse=" "))$`count(*)`
    }
    else {
      sql_query<-paste(c("SELECT", select, "FROM epa_table WHERE", where),collapse=" ")
    total_rows <- getSQL(paste(c("SELECT count(*) FROM epa_table WHERE", where),collapse=" "))$`count(*)`
    }
    
    updateProgress <- exists("session") & total_rows > 500000
    print(updateProgress)
    
    if(updateProgress)
    {
      progress <- shiny::Progress$new()
      progress$set(message = "Generando Informe", value = 0)
      
    }
    
    
    con <- dbConnect(RSQLite::SQLite(), database_path)
    rs <- dbSendQuery(con, sql_query)
    i <- 1
    datalist = list()
    
    while (!dbHasCompleted(rs)) {
      
      datalist[[i]]<-dbFetch(rs, 100000)
      i<-i+1
      if(updateProgress) {
        progress$set(dbGetRowCount(rs)/total_rows, detail = "Inicializando")
      }
    }
    
    if(updateProgress)
      progress$close()
    
    dbClearResult(rs)
    dbDisconnect(con)
    return(bind_rows(datalist))
    
    
    
    
    
    
  }
}