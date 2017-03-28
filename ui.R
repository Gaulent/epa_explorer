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
               tabPanel("Single",
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
                                 sliderInput("single_limit", "Limit", min = 1, max = 1000, value = c(200,500)),
                                 sliderInput("single_bins", "Bins",1,100,30)
                                 ),
                          column(width=6,
                                 selectInput("single_group","Ciclo:",choices = getAttrDef("FACTOR",withDesc=FALSE, withNone=TRUE)),
                                 radioButtons("single_scale","Scale",choices = c("None", "Log10", "SQRT"))
                                 )
                        ))
               ),
               tabPanel("Multiple",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("multi_ciclo","Ciclo:",choices = rev(getMapValues("CICLO"))),
                            selectInput("multi_atributo1","Atributo:",choices = getAttrDef("NUMERIC")),
                            selectInput("multi_atributo2","Atributo2:",choices = getAttrDef("NUMERIC"))
                          ),
                          mainPanel(plotOutput("multi_plot"),
                                    verbatimTextOutput("multi_text"))
                        ))
               ),
               tabPanel("Test Graph",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("graph_ciclo","Ciclo:",choices =  rev(getMapValues("CICLO"))),
                            actionButton("graph_btn", "Go!")
                          ),
                          mainPanel(plotOutput("graph_plot"))
                        ))
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