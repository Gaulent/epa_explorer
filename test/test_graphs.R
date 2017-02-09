
getData <- function(select, where) {
  con <- dbConnect(RSQLite::SQLite(), "epa_db.db")
  sql_query<-paste(c("SELECT ", select, " FROM epa_table WHERE ", where),collapse="")
  rs <- dbSendQuery(con, sql_query)
  result_data<-dbFetch(rs,n=-1)
  dbClearResult(rs)
  dbDisconnect(con)
  return(result_data)
}

grafica<-0
params<-list(ciclo=176)

for (i in 0:6) {

  current_data<-getData("FACTOREL", c("CICLO=",params$ciclo-4*i," AND SITU IS NOT NULL"))
  past_data<-getData("FACTOREL", c("CICLO=",params$ciclo-4*i-1," AND SITU IS NOT NULL"))
  grafica[7-i] <- sum(current_data$FACTOREL) - sum(past_data$FACTOREL)

}

round(grafica/1000,digits = 1)
barplot(datos)

