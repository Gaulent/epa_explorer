#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(RSQLite)

getData <- function(sql_query) {
  con <- dbConnect(RSQLite::SQLite(), "epa_db.db")
  rs <- dbSendQuery(con, sql_query)
  result_data<-dbFetch(rs,n=-1)
  dbClearResult(rs)
  dbDisconnect(con)
  return(result_data)
}

# Lista de distintos Ciclos Posibles
list_ciclo<-getData("SELECT DISTINCT CICLO FROM epa_table")

# Definicion de atributos
list_attrdef<-getData("PRAGMA table_info(epa_table)")
