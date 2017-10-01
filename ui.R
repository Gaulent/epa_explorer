#
# Definicion de la vista de la aplicacion EPA Explorer
#

library(shiny)

shinyUI(
  
  navbarPage(title = div(
    img(
      src = "logo.png",
      height = 50,
      width = 100
    )), windowTitle = "EPA Explorer",
    
    navbarMenu("Explorar",
               tabPanel("Una variable",
                        
                        tags$head(
                          HTML('<link rel="icon", href="icon.png", 
                                   type="image/png" />'),
                          tags$style(HTML("
                      
                            .navbar-brand {
                              padding: 0;
                            }
                      "))),
                        wellPanel(fluidRow(
                          column(width=4,
                                 selectInput("single_ciclo","Ejercicio:",choices = rev(getMapValues("CICLO")))),
                          column(width=8,
                                 selectInput("single_atributo","Atributo:",choices = getAttrDef("NUMERIC")))
                        )),
                        
                        tabsetPanel(type = "tabs", 
                                    tabPanel("Histograma",plotlyOutput("single_hist_plot")), 
                                    tabPanel("Líneas",plotlyOutput("single_freq_plot")), 
                                    tabPanel("Cajas", plotlyOutput("single_box_plot")),
                                    tabPanel("Resumen", verbatimTextOutput("single_text1"),verbatimTextOutput("single_text2"))
                        ),
                        wellPanel(fluidRow(
                          column(width=6,
                                 sliderInput("single_bins", "Granularidad",1,100,30)
                          ),
                          column(width=6,
                                 selectInput("single_group","Agrupar por:",choices = getAttrDef("FACTOR",withDesc=TRUE, withNone=TRUE)),
                                 radioButtons("single_scale","Función de escalado:",choices = c("Ninguna"="none", "Logarítmica"="Log10", "Raiz cuadrada"="SQRT"))
                          )
                        ))
               ),
               tabPanel("Dos variables",
                        wellPanel(fluidRow(
                          column(width=4,
                                 selectInput("pair_ciclo","Ejercicio:",choices = rev(getMapValues("CICLO")))),
                          column(width=8,
                                 selectizeInput("pair_atributos","Atributos:",choices = getAttrDef("NUMERIC"), multiple = TRUE, options = list(maxItems = 2)))
                        )),
                        plotOutput("pair_plot", height = "600px"),
                        wellPanel(fluidRow(
                          column(width=6,
                                 sliderInput("pair_limit_x", "Filtrar eje X", min = 0, max = 100, value = c(0,100)),
                                 sliderInput("pair_limit_y", "Filtrar eje Y", min = 0, max = 100, value = c(0,100)),
                                 sliderInput("pair_alpha", "Transparencia",1,100,1)
                          ),
                          column(width=6,
                                 selectInput("pair_group","Agrupar por:",choices = getAttrDef("FACTOR",withDesc=FALSE, withNone=TRUE)),
                                 radioButtons("pair_scale","Función de escalado:",choices = c("Ninguna"="none", "Raiz cuadrada"="SQRT")),
                                 checkboxInput("pair_add_jitter", "Jitter"),
                                 checkboxInput("pair_add_mean", "Incluir Media"),
                                 checkboxInput("pair_add_10perc", "Incluir Percentil 10"),
                                 checkboxInput("pair_add_50perc", "Incluir Percentil 50"),
                                 checkboxInput("pair_add_90perc", "Incluir Percentil 90"),
                                 checkboxInput("pair_add_cov", "Covarianza")
                          )
                        ))                        
               ),
               tabPanel("Múltiples Variables",
                        wellPanel(fluidRow(
                          column(width=4,
                                 selectInput("multi_ciclo","Ejercicio:",choices = rev(getMapValues("CICLO"))),
                                 actionButton("multi_btn", "Ejecutar!")
                          ),
                          column(width=8,
                                 selectizeInput("multi_atributo","Atributos:",choices = getAttrDef(withDesc=FALSE), multiple = TRUE, options = list(maxItems = 8))
                          )
                        )),
                        plotOutput("multi_plot")
                        
               ),
               tabPanel("Evolución Temporal",
                        wellPanel(selectInput("time_atributo","Atributo:",choices = getAttrDef("FACTOR", withNone=FALSE))),
                        plotlyOutput("time_plot")
               )
    ),
    navbarMenu("Clustering",
               tabPanel("Entrenamiento",
                        fluidPage(wellPanel(fluidRow(
                          column(width=4,
                                 selectInput("cluster_train_ciclo","Ejercicio:",choices = rev(getMapValues("CICLO"))),
                                 sliderInput("cluster_train_groups","Numero de Clusters:", min = 1, max = 10, value = 4),
                                 sliderInput("cluster_train_breaks","Conjuntos para Numericos:", min = 2, max = 10, value = 5),
                                 sliderInput("cluster_train_itermax","Número máximo de iteraciones:", min = 2, max = 10, value = 2),
                                 actionButton("cluster_train_btn", "Ejecutar!")
                          ),
                          column(width=8,
                                 selectizeInput("cluster_train_atributo","Atributos:",choices = getAttrDef(withDesc=TRUE), multiple = TRUE, options = list(maxItems = 8)),
                                 h4("Salida del algoritmo:"),
                                 h5("Modos"),
                                 verbatimTextOutput("cluster_train_text_modes"),
                                 h5("Tamaños de cluster"),
                                 verbatimTextOutput("cluster_train_text_size"),
                                 h5("Distancia interna de cluster"),
                                 verbatimTextOutput("cluster_train_text_withindiff")
                          )))
                        )),
               tabPanel("Visualizar",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("cluster_view_file","Fichero:", choices = rev(dir("./model/cluster", pattern="*.rds")), selectize = FALSE, size = 5),
                            h4("Resumen:"),
                            h5("Modos"),
                            verbatimTextOutput("cluster_view_text_modes"),
                            h5("Tamaños de cluster"),
                            verbatimTextOutput("cluster_view_text_size"),
                            h5("Distancia interna de cluster"),
                            verbatimTextOutput("cluster_view_text_withindiff")
                          ),
                          mainPanel(
                            tabsetPanel(type = "tabs", 
                                        tabPanel("Puntos",plotOutput("cluster_view_graph", height = "800px")),
                                        tabPanel("Explorar", DT::dataTableOutput("cluster_view_explore"))
                            )
                          )
                        )))
    ),
    navbarMenu("Reglas de Asociación",
               tabPanel("Entrenamiento",
                        fluidPage(wellPanel(fluidRow(
                          column(width=4,
                                 selectInput("arules_train_ciclo","Ejercicio:",choices = rev(getMapValues("CICLO"))),
                                 sliderInput("arules_train_support","Soporte:", min = 0, max = 1, value = 0.1),
                                 sliderInput("arules_train_confidence","Confianza:", min = 0, max = 1, value = 0.7),
                                 sliderInput("arules_train_minlen","Longitud:", min = 1, max = 10, value = c(2,3)),
                                 sliderInput("arules_train_breaks","Conjuntos para Numericos:", min = 2, max = 10, value = 5),
                                 actionButton("arules_train_btn", "Ejecutar!")
                          ),
                          column(width=8,
                                 selectizeInput("arules_train_atributo","Atributos:",choices = getAttrDef(withDesc=TRUE), multiple = TRUE, options = list(maxItems = 8)),
                                 h4("Salida del algoritmo:"),
                                 verbatimTextOutput("arules_train_text")
                          )))
                        )),               
               tabPanel("Visualizar",
                        fluidPage(sidebarLayout(
                          sidebarPanel(#width = 5,
                            selectInput("arules_view_file","Fichero:", choices = rev(dir("./model/arules", pattern="*.rds")), selectize = FALSE, size = 5),
                            h4("Resumen:"),
                            verbatimTextOutput("arules_view_text")
                          ),
                          mainPanel(#width = 7,
                            tabsetPanel(type = "tabs", 
                                        tabPanel("Puntos",plotOutput("arules_view_plot", height = "800px")), 
                                        tabPanel("Grafo", plotOutput("arules_view_graph", height = "800px")),
                                        #tabPanel("Paracoord", plotOutput("arules_view_paracoord", height = "800px"))
                                        tabPanel("Explorar", DT::dataTableOutput("arules_view_explore"))
                            )
                          )
                        )))
    ),
    tabPanel("Informes",
             fluidPage(sidebarLayout(
               sidebarPanel(
                 selectInput("rpt_file","Fichero:", choices = dir("./reports", pattern="*.Rmd"), selectize = FALSE, size = 5),
                 selectInput("rpt_ciclo","Ejercicio:",choices = rev(getMapValues("CICLO")[-(1:25)])),
                 downloadButton("rpt_generate", "Generar Informe") #Markdown test
               ),
               mainPanel()
             ))
    ),
    tabPanel("Actualizar",
             fluidPage(sidebarLayout(
               sidebarPanel(
                 selectInput("cfg_file","Fichero:", choices = check_for_updates()$Name, selectize = FALSE, size = 5),
                 actionButton("cfg_update_btn", "Actualizar!")
               ),
               mainPanel(
                 h3("Paquetes Instalados:"),verbatimTextOutput("cfg_db_summary")
               )
             ))
    ),
    tabPanel("Ayuda",
             navlistPanel(widths = c(3, 9),
               tabPanel("1.- Introducción",
                        includeHTML("www/manual/manual_1.html")
               ),
               tabPanel("2.- Puesta en Marcha",
                        includeHTML("www/manual/manual_2.html")
               ),
               tabPanel("→ 2.1.- Requisitos Mínimos",
                        includeHTML("www/manual/manual_2.1.html")
               ),
               tabPanel("→ 2.2.- Instalación",
                        includeHTML("www/manual/manual_2.2.html")
               ),
               tabPanel("3.- Manual Operativo",
                        includeHTML("www/manual/manual_3.html")
               ),
               tabPanel("→ 3.1.- Análisis Exploratorio",
                        includeHTML("www/manual/manual_3.1.html")
               ),
               tabPanel("→ 3.2.- Clustering",
                        includeHTML("www/manual/manual_3.2.html")
               ),
               tabPanel("→ 3.3.- Reglas de Asociación",
                        includeHTML("www/manual/manual_3.3.html")
               ),               
               tabPanel("→ 3.4.- Generación de informes",
                        includeHTML("www/manual/manual_3.4.html")
               ),
               tabPanel("→ 3.5.- Actualización de datos",
                        includeHTML("www/manual/manual_3.5.html")
               )
             )
    )

  ))