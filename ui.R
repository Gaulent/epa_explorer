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
                   
             tabPanel("Explore",tabsetPanel(
               tabPanel("Single",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("single_ciclo","Ciclo:",choices = rev(getMapValues("CICLO")[-(1:25)])),
                            selectInput("single_atributo","Atributo:",choices = list_attrdef$name),
                            downloadButton("report", "Generate report") #Markdown test
                          ),
                          mainPanel(plotOutput("single_plot1"),
                                    plotOutput("single_plot11"),
                                    p("Summary:"),
                                    verbatimTextOutput("single_text1"),
                                    verbatimTextOutput("single_text2"),
                                    plotOutput("single_plot2"),
                                    plotOutput("single_plot3"))
                        ))
               ),
               tabPanel("Multiple",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("multi_ciclo","Ciclo:",choices = rev(getMapValues("CICLO")[-(1:25)])),
                            selectInput("multi_atributo1","Atributo:",choices = list_attrdef$name),
                            selectInput("multi_atributo2","Atributo2:",choices = list_attrdef$name)
                          ),
                          mainPanel(plotOutput("multi_plot"),
                                    verbatimTextOutput("multi_text"))
                        ))
               ),
               tabPanel("Test Graph",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("graph_ciclo","Ciclo:",choices =  rev(getMapValues("CICLO")[-(1:25)])),
                            actionButton("graph_btn", "Go!")
                          ),
                          mainPanel(plotOutput("graph_plot"))
                        ))
               )
             )),
             tabPanel("Clustering",tabsetPanel(
               tabPanel("SubTab1",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("ciclo","Ciclo:",choices =  rev(getMapValues("CICLO")[-(1:25)]))
                          ),
                          mainPanel()
                        ))
               )
             )),
             tabPanel("Association Rules",tabsetPanel(
               tabPanel("SubTab1",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("ciclo","Ciclo:",choices =  rev(getMapValues("CICLO")[-(1:25)]))
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
             tabPanel("Settings",tabsetPanel(
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
  ))
