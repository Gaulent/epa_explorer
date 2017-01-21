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
shinyServer(function(input, output, session) {
  
  # Codigo puesto aqui se ejecuta 1 vez por usuario.
  # En las funciones reactivas, muchas veces por usuario
  # Fuera, o en global.R 1 vez por sesion de R.
  
  # Calculo de los datos una sola vez.
  # TODO: Puedo dejar la conexion a la bd abierta?
  # Como se que no pilla mucha memoria?
  
  data<-reactive({

    # Lista de distintos Ciclos Posibles
    sql_query <- paste(c("SELECT ",input$atributo,",FACTOREL FROM epa_table WHERE CICLO=",input$ciclo),collapse="")
    getData(sql_query)
  })
  
  output$plot <- renderPlot({

    a <- (aggregate(data()$FACTOREL, by=list(SEXO1=data()[,input$atributo]), FUN=sum))
    barplot(a$x, names.arg = a$SEXO1)

  })
  
  # Se llama al cerrar el navegador
  session$onSessionEnded(function() {
    print ("Session ended.")
  })
})
