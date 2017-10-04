#
# Este fichero contiene la logica del servidor de la aplicacion
#

library(shiny)

shinyServer(function(input, output, session) {
  
  # Descomentar para suprimir Warnigns
  options(warn = -1)
  
  # Vector de valores reactivos  
  rv<-reactiveValues()
  
  
  # Pestaña Single ---------------------------------
  
  single_data <- reactive({
    
    if (input$single_group == "none")
      dframe <- getData(input$single_atributo, c("CICLO=", input$single_ciclo))
    else
      dframe <- getData(c(input$single_atributo, input$single_group),c("CICLO=", input$single_ciclo))
    dframe
  })
  
  output$single_hist_plot <- renderPlotly({
    
    resplot <- ggplot(data = na.omit(single_data()), aes_string(x = input$single_atributo)) +
      geom_histogram(bins = input$single_bins,color = 'black',fill = '#099DD9')
    
    if (input$single_group != "none")
      resplot <- resplot + facet_wrap(input$single_group, ncol = 2)
    
    if (input$single_scale == "Log10")
      resplot <- resplot + scale_x_log10()
    if (input$single_scale == "SQRT")
      resplot <- resplot + scale_x_sqrt()
    
    ggplotly(resplot)
  })
  
  output$single_freq_plot <- renderPlotly({
    
    resplot <- ggplot(data = na.omit(single_data()), aes_string(x = input$single_atributo))
    
    if (input$single_group == "none")
      resplot <- resplot + geom_freqpoly(bins = input$single_bins)
    else
      resplot <- resplot + geom_freqpoly(bins = input$single_bins, aes_string(color = input$single_group))
    
    if (input$single_scale == "Log10")
      resplot <- resplot + scale_x_log10()
    if (input$single_scale == "SQRT")
      resplot <- resplot + scale_x_sqrt()
    
    ggplotly(resplot)
  })
  
  output$single_box_plot <- renderPlotly({
    
    if (input$single_group == "none")
      resplot <- ggplot(data=na.omit(single_data()), aes_string(x=1, y=input$single_atributo)) + geom_boxplot()
    else
      resplot <- ggplot(data=na.omit(single_data()), aes_string(x=input$single_group, y=input$single_atributo)) + geom_boxplot()
    
    ggplotly(resplot)
  })  
  
  output$single_text1 <- renderPrint({
    if (is.numeric(single_data()[,input$single_atributo]))
      summary(single_data()[,input$single_atributo])
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
      dframe <- getData(input$pair_atributos, c("CICLO=", input$pair_ciclo))
    else
      dframe <- getData(c(input$pair_atributos, input$pair_group),c("CICLO=", input$pair_ciclo))
    
    dframe
  })
  
  output$pair_plot <- renderPlot({
    
    if(length(input$pair_atributos)==2) {
      min_x <- floor(min(pair_data()[, input$pair_atributos[1]], na.rm = TRUE))
      max_x <- ceiling(max(pair_data()[, input$pair_atributos[1]], na.rm = TRUE))
      min_y <- floor(min(pair_data()[, input$pair_atributos[2]], na.rm = TRUE))
      max_y <- ceiling(max(pair_data()[, input$pair_atributos[2]], na.rm = TRUE))
      
      xlim <- c((max_x-min_x)*input$pair_limit_x[1]/100+min_x, (max_x-min_x)*input$pair_limit_x[2]/100+min_x)
      ylim <- c((max_y-min_y)*input$pair_limit_y[1]/100+min_y, (max_y-min_y)*input$pair_limit_y[2]/100+min_y)
      
      resplot <- ggplot(data = na.omit(pair_data()), aes_string(x = input$pair_atributos[1], y = input$pair_atributos[2])) +
        xlim(xlim) + ylim(ylim)
      
      if(input$pair_add_jitter && input$pair_group == "none")
        resplot <- resplot + geom_jitter(alpha=1/input$pair_alpha, color = 'steelblue3')
      else if (!input$pair_add_jitter && input$pair_group == "none")
        resplot <- resplot + geom_point(alpha=1/input$pair_alpha, color = 'steelblue3')
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
    }
  })  
  
  
  # Pestaña Multi ---------------------------------
  
  multi_graph <- eventReactive(input$multi_btn, {
    #progress <- shiny::Progress$new()
    #progress$set(message = "Recuperando Datos", value = 1)
    #on.exit(progress$close())
    
    current_data<-getData(input$multi_atributo, c("CICLO=",input$multi_ciclo))
    
    ggpairs(current_data[sample.int(nrow(current_data),1000), ])
  })
  
  output$multi_plot <- renderPlot({
    multi_graph()
  })
  
  
  # Pestaña Time ---------------------------------
  
  time_graph <- eventReactive(input$time_btn, {
    #progress <- shiny::Progress$new()
    #progress$set(message = "Recuperando Datos", value = 1)
    #on.exit(progress$close())
    
    dframe <- na.omit(getData(c(input$time_atributo, "CICLO, FACTOREL"),c("CICLO>=", input$time_ciclo_from, "AND CICLO<=", input$time_ciclo_to), toString = FALSE))
    #Traducir los valores
    dframe[1]<-mapToString(dframe[1])
    df<-dframe %>% group_by_(.dots=lapply(c("CICLO",input$time_atributo), as.symbol)) %>% summarise(n=sum(FACTOREL))
    
    resplot <- ggplot(data = df, aes_string(x = "CICLO", y = "n")) +
      geom_area(aes_string(fill = input$time_atributo))
    
    ggplotly(resplot)
  })
  
  output$time_plot <- renderPlotly({
    time_graph()
  })
  
  # Pestaña Report ---------------------------------
  
  get_export_filename <- function() {
    paste(c(gsub("\\.Rmd$","",input$rpt_file),".docx"),collapse="")
  }
  
  output$rpt_generate <- downloadHandler(
    
    filename = get_export_filename,
    contentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    content = function(file) {
      
      tempReport <- file.path(tempdir(), input$rpt_file)
      file.copy(paste(c("reports/",input$rpt_file),collapse=""), tempReport, overwrite = TRUE)
      
      params <- list(ciclo = as.numeric(input$rpt_ciclo), underShiny = TRUE)
      
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
    
    progress <- shiny::Progress$new()
    progress$set(message = "Actualización", detail = input$cfg_file, value = 1)
    
    update_database(input$cfg_file)
    rv$db_patches <- names(getMapValues("CICLO", forceCheck = TRUE))
    updateSelectInput(session, "cfg_file", choices = check_for_updates()$Name)
    updateSelectInput(session, "single_ciclo",choices = rev(getMapValues("CICLO")))
    updateSelectInput(session, "pair_ciclo",choices = rev(getMapValues("CICLO")))
    updateSelectInput(session, "multi_ciclo",choices = rev(getMapValues("CICLO")))
    updateSelectInput(session, "cluster_train_ciclo",choices = rev(getMapValues("CICLO")))
    updateSelectInput(session, "arules_train_ciclo",choices = rev(getMapValues("CICLO")))
    updateSelectInput(session, "rpt_ciclo",choices = rev(getMapValues("CICLO")[-(1:25)]))
    
    progress$set(detail = "Finalizado")
    progress$close()
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
    
    #selected_atributes <- c("CCAA","PROV","EDAD5", "SEXO", "NAC", "MUN", "REGNA", "ECIV", "NFORMA", "CURSR", "CURSNR", "TRAREM", "AOI", "OFEMP")
    selected_atributes <- input$arules_train_atributo
    
    #dframe<-getData(selected_atributes,c("CICLO=",input$arules_train_ciclo, "AND NIVEL=1"))
    dframe<-getData(selected_atributes,c("CICLO=",input$arules_train_ciclo))
    
    dframe <- as.data.frame(unclass(dframe))
    
    indx <- sapply(dframe, is.numeric)

    if(input$arules_cut_type == "Igual Tamaño")
      dframe[indx] <- lapply(dframe[indx], function(x) cut(x,breaks = input$arules_train_breaks, include.lowest = TRUE, ordered_result = TRUE))
    else
      dframe[indx] <- lapply(dframe[indx], function(x) cut2(x,g = input$arules_train_breaks))
    
        
    #☻sample_df <- dframe[sample.int(nrow(dframe),100000), ]
    
    progress <- shiny::Progress$new()
    progress$set(message = "ARules", detail = "Ocupado", value = 1)
    
    # find association rules with default settings
    rules <- apriori(na.omit(dframe), parameter=list(support = input$arules_train_support, minlen = input$arules_train_minlen[1], maxlen = input$arules_train_minlen[2], target= "rules", confidence = input$arules_train_confidence))
    
    progress$set(detail = "Finalizado")
    progress$close()
    
    dir.create("model/arules", showWarnings = FALSE, recursive = TRUE)
    
    saveRDS(rules, file = paste(c("model/arules/",format(Sys.time(), "%y%m%d_%H.%M.%S"),".rds"),collapse=""))
    
    updateSelectInput(session, "arules_view_file",choices = rev(dir("./model/arules", pattern="*.rds")), selected = rev(dir("./model/arules", pattern="*.rds"))[1])
  })
  
  output$arules_train_text <- renderPrint({
    arules_train_data()
  })
  
  
  # Pestaña ARules_View ---------------------------------
  
  arules_model <- reactive({
    readRDS(paste(c("model/arules/",input$arules_view_file),collapse=""))
  })
  
  output$arules_view_text <- renderPrint({
    summary(arules_model())
  })
  
  output$arules_view_plot <- renderPlot({
    plot(arules_model())
  })
  
  output$arules_view_graph <- renderPlot({
    plot(sort(arules_model(), by = "lift")[1:20], method="graph", control=list(type="items"))
  })
  
  output$arules_view_explore <- DT::renderDataTable({
    DT::datatable(as(arules_model(),"data.frame"), options = list(pageLength = 20))
  })
  
  output$arules_downloadData <- downloadHandler(
    filename = function() {
      paste("arules-data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv2(as(arules_model(),"data.frame"), file)
    }
  )
  
  
  
  # Pestaña Cluster_Train ---------------------------------
  
  cluster_train_data <- eventReactive(input$cluster_train_btn, {
    
    set.seed(12345)
    
    #selected_atributes <- c("CCAA","PROV","EDAD5", "SEXO", "NAC", "MUN", "REGNA", "ECIV", "NFORMA", "CURSR", "CURSNR", "TRAREM", "AOI", "OFEMP")
    selected_atributes <- input$cluster_train_atributo
    
    #dframe<-getData(selected_atributes,c("CICLO=",input$cluster_train_ciclo, "AND NIVEL=1"))
    dframe<-getData(selected_atributes,c("CICLO=",input$cluster_train_ciclo))
    
    dframe <- as.data.frame(unclass(dframe))
    
    indx <- sapply(dframe, is.numeric)
    
    if(input$cluster_cut_type == "Igual Tamaño")
      dframe[indx] <- lapply(dframe[indx], function(x) cut(x,breaks = input$cluster_train_breaks, include.lowest = TRUE, ordered_result = TRUE))
    else
      dframe[indx] <- lapply(dframe[indx], function(x) cut2(x,g = input$cluster_train_breaks))

    dframe <- na.omit(dframe)
    dframe <- dframe[ sample.int(nrow(dframe),1000), ]
    
    # find association rules with default settings
    
    progress <- shiny::Progress$new()
    progress$set(message = "Clustering", detail = "Ocupado", value = 1)
    
    clusters <- kmodes(dframe, input$cluster_train_groups, iter.max = input$cluster_train_itermax)
    
    clusters$data <- dframe
    
    progress$set(detail = "Finalizado")
    progress$close()
    
    dir.create("model/cluster", showWarnings = FALSE, recursive = TRUE)
    
    saveRDS(clusters, file = paste(c("model/cluster/",format(Sys.time(), "%y%m%d_%H.%M.%S"),".rds"),collapse=""))
    
    updateSelectInput(session, "cluster_view_file",choices = rev(dir("./model/cluster", pattern="*.rds")), selected = rev(dir("./model/cluster", pattern="*.rds"))[1])
    
    #Valor de retorno
    clusters
    
  })
  
  output$cluster_train_text_modes <- renderPrint({
    cluster_train_data()$modes
  })

  output$cluster_train_text_size <- renderPrint({
    cluster_train_data()$size
  })

  output$cluster_train_text_withindiff <- renderPrint({
    cluster_train_data()$withindiff
  })
  

  # Pestaña Cluster_View ---------------------------------
  
  cluster_model <- reactive({
    readRDS(paste(c("model/cluster/",input$cluster_view_file),collapse=""))
  })
  
  output$cluster_view_text_modes <- renderPrint({
    cluster_model()$modes
  })
  
  output$cluster_view_text_size <- renderPrint({
    cluster_model()$size
  })
  
  output$cluster_view_text_withindiff <- renderPrint({
    cluster_model()$withindiff
  })

  output$cluster_view_graph <- renderPlot({
    dframe<-cluster_model()$data
    cluster<-cluster_model()$cluster
    clusplot(dframe, cluster, color=TRUE, shade=TRUE,labels=2, lines=0)
  })
  
  output$cluster_view_explore <- DT::renderDataTable({
    dframe <- cbind(CLUSTER = cluster_model()$cluster, cluster_model()$data)
    DT::datatable(as(dframe,"data.frame"), options = list(pageLength = 20))
  })
  
  output$cluster_downloadData <- downloadHandler(
    filename = function() {
      paste("cluster-data-", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      dframe <- cbind(CLUSTER = cluster_model()$cluster, cluster_model()$data)
      write.csv2(dframe, file)
    }
  )

  # Pestaña Help ---------------------------------
  
  output$help_attr_table <- renderTable({
    getSQL("SELECT * FROM list_attrdef")
  })
  
  output$help_pack_table <- renderTable({
    packinfo <- installed.packages(fields = c("Package", "Version"))
    packinfo <- packinfo[.packages(),c("Package", "Version", "License", "Built")]
    packinfo[ order(packinfo[,1]), ]
  })

  
})