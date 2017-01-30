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
  
  output$plot1 <- renderPlot({
    #Categorico
    a <- (aggregate(data()$FACTOREL, by=list(SEXO1=data()[,input$atributo]), FUN=sum))
    barplot(a$x, names.arg = a$SEXO1)

  })
  
  output$plot11 <- renderPlot({
    #Categorico
    barplot(table(data()[,input$atributo]))
    
  })
  
  output$plot3 <- renderPlot({
    if (is.numeric(data()[,input$atributo]))
    hist(data()[,input$atributo], main = "Histogram of Used Car Prices",xlab = "Price ($)")
    
  })

  output$text1 <- renderPrint({
    if (is.numeric(data()[,input$atributo]))
    summary(data()[,input$atributo])
    
    
    #> var(usedcars$price)
    #[1] 9749892
    #> sd(usedcars$price)
    #[1] 3122.482
    #> var(usedcars$mileage)
    #[1] 728033954
    #> sd(usedcars$mileage)
    #[1] 26982.1
    #IQR(usedcars$price)
    #> range(usedcars$price)
    #[1]  3800 21992
    #> diff(range(usedcars$price))
    #[1] 18192

  })

  output$text2 <- renderPrint({
    if (is.numeric(data()[,input$atributo]))
    quantile(data()[,input$atributo],na.rm = TRUE)
    
  })
  
  output$plot2 <- renderPlot({
    if (is.numeric(data()[,input$atributo]))
    boxplot(data()[,input$atributo], main="Boxplot of Used Car Prices",ylab="Price ($)")
    
  })  
  
  
  
  
    
  # Se llama al cerrar el navegador
  session$onSessionEnded(function() {
    print ("Session ended.")
  })
})
