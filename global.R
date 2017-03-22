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

# Definicion de atributos
list_attrdef<-getSQL("SELECT * FROM list_attrdef")
list_select_attr<-as.list(list_attrdef$name)
names(list_select_attr)<-paste(list_attrdef$name,list_attrdef$description,sep = " ")
#filter(list_attrdef, type=="NUMERIC")$name