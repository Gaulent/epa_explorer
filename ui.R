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
                            selectInput("single_ciclo","Ciclo:",choices = rev(list_ciclo$CICLO)),
                            selectInput("single_atributo","Atributo:",choices = list_attrdef$name)
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
                            selectInput("multi_ciclo","Ciclo:",choices = rev(list_ciclo$CICLO)),
                            selectInput("multi_atributo1","Atributo:",choices = list_attrdef$name),
                            selectInput("multi_atributo2","Atributo2:",choices = list_attrdef$name)
                          ),
                          mainPanel(plotOutput("multi_plot"),
                                    verbatimTextOutput("multi_text"))
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
