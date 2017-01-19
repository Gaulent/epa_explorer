#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(RSQLite)

con <- dbConnect(RSQLite::SQLite(), "epa_db.db")

# Lista de distintos Ciclos Posibles
rs <- dbSendQuery(con, "SELECT DISTINCT CICLO FROM epa_table")
list_ciclo<-dbFetch(rs,n=-1)
dbClearResult(rs)

# Definicion de atributos
rs <- dbSendQuery(con, "PRAGMA table_info(epa_table)")
list_attrdef<-dbFetch(rs,n=-1)
dbClearResult(rs)

dbDisconnect(con)





