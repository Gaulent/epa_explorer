#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")

# Lista de distintos Ciclos Posibles. Los primeros 25 los mantenemos de historico.
list_ciclo<-getSQL("SELECT DISTINCT CICLO FROM epa_table WHERE CICLO >= 155")

# Definicion de atributos
list_attrdef<-getSQL("PRAGMA table_info(epa_table)")


map_ccaa <- data.frame(value=c(1:17,51,52), label=c("Andalucía", "Aragón", "Asturias", "Baleares", "Canarias", "Cantabria", "Castilla y León", "Castilla-La Mancha", "Cataluña", "Comunidad Valenciana", "Extremadura", "Galicia", "Comunidad de Madrid", "Región de Murcia", "Navarra", "País Vasco", "La Rioja", "Ceuta", "Melilla"),stringsAsFactors=FALSE)  




