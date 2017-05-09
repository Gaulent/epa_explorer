#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  # Codigo puesto aqui se ejecuta 1 vez por usuario.
  # En las funciones reactivas, muchas veces por usuario
  # Fuera, o en global.R 1 vez por sesion de R.
  
  # Calculo de los datos una sola vez.
  # TODO: Puedo dejar la conexion a la bd abierta?
  # Como se que no pilla mucha memoria?
  
  rv<-reactiveValues()
  
  # Pestaña Single ---------------------------------

  single_data <- reactive({
    updateSliderInput(session,"single_limit",value = c(0,100))
    if (input$single_group == "none")
      dframe <- getData(input$single_atributo, c("CICLO=", input$single_ciclo))
    else
      dframe <- getData(c(input$single_atributo, input$single_group),c("CICLO=", input$single_ciclo))
    dframe
  })
  
  output$single_hist_plot <- renderPlotly({
    
    min_x <- floor(min(single_data()[, input$single_atributo], na.rm = TRUE))
    max_x <- ceiling(max(single_data()[, input$single_atributo], na.rm = TRUE))

    xlim <- c((max_x-min_x)*input$single_limit[1]/100+min_x, (max_x-min_x)*input$single_limit[2]/100+min_x)

    resplot <- ggplot(data = na.omit(single_data()), aes_string(x = input$single_atributo)) +
      geom_histogram(bins = input$single_bins,color = 'black',fill = '#099DD9')
    
    if (input$single_group != "none")
      resplot <- resplot + facet_wrap(input$single_group, ncol = 2)
    
    if (input$single_scale == "None")
      resplot <- resplot + scale_x_continuous(limits = xlim)
    if (input$single_scale == "Log10")
      resplot <- resplot + scale_x_log10()
    if (input$single_scale == "SQRT")
      resplot <- resplot + scale_x_sqrt()
    
    ggplotly(resplot)
  })
  
  output$single_freq_plot <- renderPlotly({
    
    min_x <- floor(min(single_data()[, input$single_atributo], na.rm = TRUE))
    max_x <- ceiling(max(single_data()[, input$single_atributo], na.rm = TRUE))
    
    xlim <- c((max_x-min_x)*input$single_limit[1]/100+min_x, (max_x-min_x)*input$single_limit[2]/100+min_x)
    
    resplot <- ggplot(data = na.omit(single_data()), aes_string(x = input$single_atributo))

    if (input$single_group == "none")
      resplot <- resplot + geom_freqpoly(bins = input$single_bins)
    else
      resplot <- resplot + geom_freqpoly(bins = input$single_bins, aes_string(color = input$single_group))
    
    if (input$single_scale == "None")
      resplot <- resplot + scale_x_continuous(limits = xlim)
    if (input$single_scale == "Log10")
      resplot <- resplot + scale_x_log10()
    if (input$single_scale == "SQRT")
      resplot <- resplot + scale_x_sqrt()
    
    ggplotly(resplot)
  })

  output$single_box_plot <- renderPlotly({
    
    min_x <- floor(min(single_data()[, input$single_atributo], na.rm = TRUE))
    max_x <- ceiling(max(single_data()[, input$single_atributo], na.rm = TRUE))
    
    xlim <- c((max_x-min_x)*input$single_limit[1]/100+min_x, (max_x-min_x)*input$single_limit[2]/100+min_x)
    
    if (input$single_group == "none")
      resplot <- ggplot(data=na.omit(single_data()), aes_string(x=1, y=input$single_atributo)) + geom_boxplot()
    else
      resplot <- ggplot(data=na.omit(single_data()), aes_string(x=input$single_group, y=input$single_atributo)) + geom_boxplot()
    
    resplot <- resplot + coord_cartesian(ylim = xlim)

    ggplotly(resplot)
  })  
    

  output$single_text1 <- renderPrint({
    if (is.numeric(single_data()[,input$single_atributo]))
    summary(single_data()[,input$single_atributo])
    
    
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
    if (is.numeric(single_data()[,input$single_atributo]))
    quantile(single_data()[,input$single_atributo],na.rm = TRUE)
    
  })
  

  
  # Pestaña Pair ---------------------------------

  pair_data<-reactive({
    updateSliderInput(session,"pair_limit_x",value = c(0,100))
    updateSliderInput(session,"pair_limit_y",value = c(0,100))

    if (input$pair_group == "none")
      dframe <- getData(c(input$pair_atributo1,input$pair_atributo2), c("CICLO=", input$pair_ciclo))
    else
      dframe <- getData(c(input$pair_atributo1,input$pair_atributo2, input$pair_group),c("CICLO=", input$pair_ciclo))

    dframe
  })
  
  output$pair_plot <- renderPlot({
    #if (is.numeric(data()[,input$single_atributo]))

    min_x <- floor(min(pair_data()[, input$pair_atributo1], na.rm = TRUE))
    max_x <- ceiling(max(pair_data()[, input$pair_atributo1], na.rm = TRUE))
    min_y <- floor(min(pair_data()[, input$pair_atributo2], na.rm = TRUE))
    max_y <- ceiling(max(pair_data()[, input$pair_atributo2], na.rm = TRUE))

    xlim <- c((max_x-min_x)*input$pair_limit_x[1]/100+min_x, (max_x-min_x)*input$pair_limit_x[2]/100+min_x)
    ylim <- c((max_y-min_y)*input$pair_limit_y[1]/100+min_y, (max_y-min_y)*input$pair_limit_y[2]/100+min_y)
    
    resplot <- ggplot(data = na.omit(pair_data()), aes_string(x = input$pair_atributo1, y = input$pair_atributo2)) +
      xlim(xlim) + ylim(ylim)
    
    if(input$pair_add_jitter && input$pair_group == "none")
      resplot <- resplot + geom_jitter(alpha=1/input$pair_alpha, color = 'orange')
    else if (!input$pair_add_jitter && input$pair_group == "none")
      resplot <- resplot + geom_point(alpha=1/input$pair_alpha, color = 'orange')
    else if (input$pair_add_jitter && input$pair_group != "none")
      resplot <- resplot + geom_jitter(alpha=1/input$pair_alpha, aes_string(color = input$pair_group))
    else if (!input$pair_add_jitter && input$pair_group != "none")
      resplot <- resplot + geom_point(alpha=1/input$pair_alpha, aes_string(color = input$pair_group))
    
    if(input$pair_add_mean)
      resplot <- resplot + geom_line(stat='summary', fun.y = mean)
    if(input$pair_add_10perc)
      resplot <- resplot + geom_line(stat='summary', fun.y = quantile, fun.args = list(probs = .1), linetype = 2, color = 'blue')
    if(input$pair_add_50perc)
      resplot <- resplot + geom_line(stat='summary', fun.y = quantile, fun.args = list(probs = .5), color = 'blue')
    if(input$pair_add_90perc)
      resplot <- resplot + geom_line(stat='summary', fun.y = quantile, fun.args = list(probs = .9), linetype = 2, color = 'blue')
    if(input$pair_add_cov)
      resplot <- resplot + geom_smooth(method = 'lm', color = 'red')

    if (input$pair_scale == "SQRT")
      resplot <- resplot + coord_trans(y = 'sqrt')

    resplot
  })  
  
  # Pestaña Multi ---------------------------------

  multi_graph <- eventReactive(input$multi_btn, {
    #progress <- shiny::Progress$new()
    #progress$set(message = "Recuperando Datos", value = 1)
    #on.exit(progress$close())

    library(GGally)
    
    current_data<-getData(input$multi_atributo, c("CICLO=",input$multi_ciclo))

    #ggpairs(current_data[sample.int(nrow(current_data),1000), ], 
    ##        lower = list(continuous = wrap("points", shape = I('.'))), 
    #        upper = list(combo = wrap("box", outlier.shape = I('.'))))
    ggpairs(current_data[sample.int(nrow(current_data),1000), ])
  })
  
  output$multi_plot <- renderPlot({
    multi_graph()
  })

  # Pestaña Time ---------------------------------
  
  output$time_plot <- renderPlotly({
    
    dframe <- getData(c(input$time_atributo, "CICLO, FACTOREL"),"CICLO>165", toString = FALSE)
    df<-dframe %>% group_by_(.dots=lapply(c("CICLO",input$time_atributo), as.symbol)) %>% summarise(n=sum(FACTOREL))
      
    resplot <- ggplot(data = df, aes_string(x = "CICLO", y = "n")) +
      geom_area(aes_string(fill = input$time_atributo))

    ggplotly(resplot)
  })
  
  # Pestaña Report ---------------------------------
  
  get_export_filename <- function() {
    paste(c(gsub("\\.Rmd$","",input$rpt_file),".docx"),collapse="")
  }

  output$rpt_generate <- downloadHandler(
    # For PDF output, change this to "report.pdf"
    filename = get_export_filename,
    contentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempReport <- file.path(tempdir(), input$rpt_file)
      file.copy(paste(c("reports/",input$rpt_file),collapse=""), tempReport, overwrite = TRUE)
      
      # Set up parameters to pass to Rmd document
      params <- list(ciclo = as.numeric(input$rpt_ciclo), underShiny = TRUE)
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempReport, output_file = file,
                        params = params,
                        envir = new.env(parent = globalenv()),
                        encoding = "UTF-8",
                        output_format = rmarkdown::word_document(fig_width = 7, fig_height = 5, fig_caption = TRUE)
      )
    }  
  )
  
  # Pestaña Graph ---------------------------------
  # Pestaña de prueba. Solo se lanza el grafico al pulsar el boton.

  graph <- eventReactive(input$graph_btn, {
    progress <- shiny::Progress$new()
    progress$set(message = "Recuperando Datos", value = 1)
    on.exit(progress$close())
    
    current_data<-getData("CICLO, SEXO, FACTOREL", "SITU IS NOT NULL AND CICLO >= 155", updateProgress = progress$set)
    result <- current_data %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL))
    result$hombres <- (filter(current_data, SEXO=="V") %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL)))$total
    result$mujeres <- (filter(current_data, SEXO=="M") %>% group_by(CICLO) %>% summarise(total = sum(FACTOREL)))$total
    
    ggplot(result, aes(155:176)) + 
      geom_line(aes(y = total/1000, colour = "var0")) + 
      geom_line(aes(y = hombres/1000, colour = "var1")) +
      geom_line(aes(y = mujeres/1000, colour = "var2")) +
      scale_y_continuous(expand = c(0, 0), limits = c(0, max(result$total/1000)))
  })
  
  output$graph_plot <- renderPlot({
    graph()
  })

  # Pestaña Update ---------------------------------
  # Pestaña Settings. Solo actualiza la base de datos al pulsar el boton,
  # pero el summary se muestra siempre.

  rv$db_patches<- names(getMapValues("CICLO"))
  
  observeEvent(input$cfg_update_btn,{
               update_database(input$cfg_file)
               rv$db_patches <- names(getMapValues("CICLO", forceCheck = TRUE))
               updateSelectInput(session, "cfg_file", choices = check_for_updates()$Name)
               updateSelectInput(session, "single_ciclo",choices = rev(getMapValues("CICLO")[-(1:25)]))
               })
  
  output$cfg_db_summary <- renderPrint({
    rv$db_patches
  })
    
  # Se llama al cerrar el navegador
  session$onSessionEnded(function() {
    print ("Session ended.")
  })
  
  # Pestaña ARules_Train ---------------------------------
  
  arules_train_data <- eventReactive(input$arules_train_btn, {
    
    selected_atributes <- c("CCAA","PROV","EDAD5", "SEXO", "NAC", "MUN", "REGNA", "ECIV", "NFORMA", "CURSR", "CURSNR", "TRAREM", "AOI", "OFEMP", "SIDI1", "SIDI2", "SIDI3", "SIDI4", "SIDI5", "SIDI6", "SIDI7", "SIDAC1", "SIDAC2")
    
    dframe<-getData(selected_atributes,c("CICLO=",input$arules_train_ciclo, "AND NIVEL=1"))
    
    dframe <- as.data.frame(unclass(dframe))
    
    indx <- sapply(dframe, is.numeric)
    dframe[indx] <- lapply(dframe[indx], function(x) cut(x,breaks = 5, include.lowest = TRUE, ordered_result = TRUE))
    
    #☻sample_df <- dframe[sample.int(nrow(dframe),100000), ]
    
    library(arules)

        # find association rules with default settings
    rules <- apriori(na.omit(dframe), parameter=list(support = 0.1, minlen = 3, maxlen = 3, target= "rules", confidence = 0.7))
    inspect(rules[1:20])
  })
  
  output$arules_train_text <- renderPrint({
    arules_train_data()
  })
})
