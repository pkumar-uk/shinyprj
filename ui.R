
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(googleVis)

shinyUI(pageWithSidebar(
  # Application title
        headerPanel("Life Expectancy across Globe - visual representation"),
        

  # Sidebar with a slider input for number of bins
 
    sidebarPanel(
            h5("Type of Life Expectancy"),
            
            radioButtons("sghoc", "", 
                         choices = c("Life expectancy at birth" = "WHOSIS_000001", 
                                     "Healthy life expectancy (HALE) at birth" = "WHOSIS_000002", 
                                     "Life expectancy at age 60" = "WHOSIS_000015")),
#            br(),
            h5("Life Expectancy greater than(in Years)"),
            sliderInput("year",
                  "",
                  min = 0,
                  max = 100,
                  value = 0),
#      br(),
      h5("Select Year for which the data should be shown"),
      
      radioButtons("syear", "", selected="2012",
                  choices = c("1990" = "1990", "2000" = "2000", "2012" = "2012")),
#      br(),
      h5("Select for which population:"),
      
      selectInput("spop", "", 
                   choices = c("Both Sexes" = "BTSX", "Male" = "MLE", "Female" = "FMLE")),
      
#      br(),
      h5("Select type of Country to be shown               "),
      
      checkboxInput("WB_HI" , "High Income countries        :", TRUE), 
      checkboxInput("WB_UMI", "Upper Middle Income countries:", TRUE),
      checkboxInput("WB_LMI", "Lower Middle Income countries:", TRUE),
      checkboxInput("WB_LI" , "Lower Income countries       :", TRUE)            
    ,width=3),

    # Show a plot of the generated distribution
    mainPanel(                 
                 tabsetPanel(
                         tabPanel("Geo",
                                  h4("GeoMap View of Life expectancy"),
                                  textOutput("caption1"),
                                  p("(Data used is from WHO)"),
                                  textOutput("caption"),
                                  htmlOutput("mplot1")),
                         tabPanel("Trend",h4("Life expectancy trend"),
                                  textOutput("caption2"),
                                  p("(Data used is from WHO)"),
                                  textOutput("caption3"),
                                  htmlOutput("mplot2")),
                         tabPanel("Help",h4("Help"),includeMarkdown("help1.md"))
                                                  
                         )
    )
  )
)
