#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(gmodels) # For CrossTable()

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
    getData(c(input$single_atributo,"FACTOREL"),c("CICLO=",input$single_ciclo))
  })
  
  output$single_plot1 <- renderPlot({
    #Categorico
    a <- (aggregate(data()$FACTOREL, by=list(SEXO1=data()[,input$single_atributo]), FUN=sum))
    barplot(a$x, names.arg = a$SEXO1)

  })
  
  output$single_plot11 <- renderPlot({
    #Categorico
    barplot(table(data()[,input$single_atributo]))
    
  })
  
  output$single_plot3 <- renderPlot({
    if (is.numeric(data()[,input$single_atributo]))
    hist(data()[,input$single_atributo], main = "Histogram of Used Car Prices",xlab = "Price ($)")
    
  })

  output$single_text1 <- renderPrint({
    if (is.numeric(data()[,input$single_atributo]))
    summary(data()[,input$single_atributo])
    
    
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

  output$single_text2 <- renderPrint({
    if (is.numeric(data()[,input$single_atributo]))
    quantile(data()[,input$single_atributo],na.rm = TRUE)
    
  })
  
  output$single_plot2 <- renderPlot({
    if (is.numeric(data()[,input$single_atributo]))
    boxplot(data()[,input$single_atributo], main="Boxplot of Used Car Prices",ylab="Price ($)")
    
  })  
  
  
  
  multi_data<-reactive({
    
    # Lista de distintos Ciclos Posibles
    getData(c(input$multi_atributo1,input$multi_atributo2),c("CICLO=",input$multi_ciclo))
    
  })
  
  
  output$multi_plot <- renderPlot({
    #if (is.numeric(data()[,input$single_atributo]))
    
    plot(x = multi_data()[,input$multi_atributo1], y = multi_data()[,input$multi_atributo2],
         main = "Scatterplot of Price vs. Mileage",
         xlab = "Used Car Odometer (mi.)",
         ylab = "Used Car Price ($)")
  })  
  
  output$multi_text <- renderPrint({
    # TODO: At least 2 elements
    CrossTable(x = multi_data()[,input$multi_atributo1], y = multi_data()[,input$multi_atributo2])
  })    
  


  
  output$report <- downloadHandler(
    # For PDF output, change this to "report.pdf"
    filename = "reports$report.html",
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempReport <- file.path(tempdir(), "report.Rmd")
      file.copy("reports/report.Rmd", tempReport, overwrite = TRUE)
      
      # Set up parameters to pass to Rmd document
      params <- list(n = input$single_ciclo)
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv())
      )
    }  
  )
  
    
    
  # Se llama al cerrar el navegador
  session$onSessionEnded(function() {
    print ("Session ended.")
  })
})
