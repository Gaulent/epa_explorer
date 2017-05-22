#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

list.of.packages <- c("shiny", "rmarkdown", "RSQLite", "dplyr", "readr", "RCurl", "ggplot2", "GGally", "plotly", "crosstalk", "arules", "arulesViz", "klaR")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

lapply(list.of.packages, require, character.only = TRUE)

source("libs/access_database.R", encoding = "UTF-8")
source("libs/update_database.R", encoding = "UTF-8")
