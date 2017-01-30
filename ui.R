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
                            selectInput("ciclo","Ciclo:",choices = rev(list_ciclo$CICLO)),
                            selectInput("atributo","Atributo:",choices = list_attrdef$name)
                          ),
                          mainPanel(plotOutput("plot1"),
                                    plotOutput("plot11"),
                                    p("Summary:"),
                                    verbatimTextOutput("text1"),
                                    verbatimTextOutput("text2"),
                                    plotOutput("plot2"),
                                    plotOutput("plot3"))
                        ))
               ),
               tabPanel("Multiple",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("ciclo","Ciclo:",choices = list_ciclo$CICLO)
                          ),
                          mainPanel()
                        ))
               )
             )),
             tabPanel("Clustering",tabsetPanel(
               tabPanel("SubTab1",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("ciclo","Ciclo:",choices = list_ciclo$CICLO)
                          ),
                          mainPanel()
                        ))
               )
             )),
             tabPanel("Association Rules",tabsetPanel(
               tabPanel("SubTab1",
                        fluidPage(sidebarLayout(
                          sidebarPanel(
                            selectInput("ciclo","Ciclo:",choices = list_ciclo$CICLO)
                          ),
                          mainPanel()
                        ))
               )
             ))
  ))
