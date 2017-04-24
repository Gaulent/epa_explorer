#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram

shinyUI(
  navbarPage(title = "EPA Database",
                   
             navbarMenu("Explore",
               tabPanel("One Variable",
                        wellPanel(fluidRow(
                          column(width=4,
                                 selectInput("single_ciclo","Ciclo:",choices = rev(getMapValues("CICLO")))),
                          column(width=8,
                                 selectInput("single_atributo","Atributo:",choices = getAttrDef("NUMERIC")))
                        )),
                        
                        tabsetPanel(type = "tabs", 
                                    tabPanel("Histogram",plotOutput("single_hist_plot")), 
                                    tabPanel("Freqpoly",plotOutput("single_freq_plot")), 
                                    tabPanel("Boxplot", plotOutput("single_box_plot")),
                                    tabPanel("Summary", verbatimTextOutput("single_text1"),verbatimTextOutput("single_text2"))
                        ),
                        wellPanel(fluidRow(
                          column(width=6,
                                 sliderInput("single_limit", "Limit", min = 0, max = 100, value = c(0,100)),
                                 sliderInput("single_bins", "Bins",1,100,30)
                                 ),
                          column(width=6,
                                 selectInput("single_group","Group by:",choices = getAttrDef("FACTOR",withDesc=FALSE, withNone=TRUE)),
                                 radioButtons("single_scale","Scale",choices = c("None", "Log10", "SQRT"))
                                 )
                        ))
               ),
               tabPanel("Two Variable",
                        wellPanel(fluidRow(
                          column(width=4,
                                 selectInput("pair_ciclo","Ciclo:",choices = rev(getMapValues("CICLO")))),
                          column(width=8,
                                 selectInput("pair_atributo1","Atributo:",choices = getAttrDef("NUMERIC")),
                                 selectInput("pair_atributo2","Atributo:",choices = getAttrDef("NUMERIC")))
                        )),
                        plotOutput("pair_plot", height = "800px"),
                        wellPanel(fluidRow(
                          column(width=6,
                                 sliderInput("pair_limit_x", "Limit X", min = 0, max = 100, value = c(0,100)),
                                 sliderInput("pair_limit_y", "Limit Y", min = 0, max = 100, value = c(0,100)),
                                 sliderInput("pair_alpha", "Alpha",1,100,1)
                          ),
                          column(width=6,
                                 selectInput("pair_group","Group by:",choices = getAttrDef("FACTOR",withDesc=FALSE, withNone=TRUE)),
                                 radioButtons("pair_scale","Scale",choices = c("None", "SQRT")),
                                 checkboxInput("pair_add_jitter", "Jitter"),
                                 checkboxInput("pair_add_mean", "Mean"),
                                 checkboxInput("pair_add_10perc", "10 Percentile"),
                                 checkboxInput("pair_add_50perc", "50 Percentile"),
                                 checkboxInput("pair_add_90perc", "90 Percentile"),
                                 checkboxInput("pair_add_cov", "Covariance")
                          )
                        ))                        
               ),
               tabPanel("Multi Variable",
                        wellPanel(fluidRow(
                          column(width=4,
                                 selectInput("multi_ciclo","Ciclo:",choices = rev(getMapValues("CICLO"))),
                                 actionButton("multi_btn", "Go!")
                          ),
                          column(width=8,
                                 selectizeInput("multi_atributo","Atributos:",choices = getAttrDef(withDesc=FALSE), multiple = TRUE, options = list(maxItems = 8))
                                 )
                        )),
                        plotOutput("multi_plot")
                        
               )
             ),
             tabPanel("Clustering",tabsetPanel(
               tabPanel("SubTab1",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("ciclo","Ciclo:",choices =  rev(getMapValues("CICLO")))
                          ),
                          mainPanel()
                        ))
               )
             )),
             tabPanel("Association Rules",tabsetPanel(
               tabPanel("SubTab1",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("ciclo","Ciclo:",choices =  rev(getMapValues("CICLO")))
                          ),
                          mainPanel()
                        ))
               )
             )),
             tabPanel("Reports",
                      fluidPage(sidebarLayout(
                        sidebarPanel(
                          selectInput("rpt_file","Fichero:", choices = dir("./reports", pattern="*.Rmd"), selectize = FALSE, size = 5),
                          selectInput("rpt_ciclo","Ciclo:",choices = rev(getMapValues("CICLO")[-(1:25)])),
                          downloadButton("rpt_generate", "Generate report") #Markdown test
                        ),
                        mainPanel()
                      ))
             ),
             tabPanel("Update",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("cfg_file","Fichero:", choices = check_for_updates()$Name, selectize = FALSE, size = 5),
                            actionButton("cfg_update_btn", "Update!")
                          ),
                          mainPanel(
                            verbatimTextOutput("cfg_db_summary")
                          )
                        ))
             )
  ))