#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$plot <- renderPlot({


    con <- dbConnect(RSQLite::SQLite(), "epa_db.db")
    
    # Lista de distintos Ciclos Posibles
    sql_query <- paste(c("SELECT ",input$atributo,",FACTOREL FROM epa_table WHERE CICLO=",input$ciclo),collapse="")
    rs <- dbSendQuery(con, sql_query)
    result<-dbFetch(rs,n=-1)
    dbClearResult(rs)
    
    dbDisconnect(con)
    
        
    a <- (aggregate(result$FACTOREL, by=list(SEXO1=result[,input$atributo]), FUN=sum))
    barplot(a$x, names.arg = a$SEXO1)
    
  
  })
})
