library(shiny)
library(plotly)
library(stringr)
library(rvest)
library(httr)

shinyUI(fluidPage(
  titlePanel("Plot New Game Releases by Platform (according to Metacritic.com) - Date 6/27/18 (by Victor Ceron)"),
  sidebarLayout(
    sidebarPanel(
      p("This Shiny application scrapes the data from metacritic.com for top new releases for either PS4, X-Box one or PC games. The plot is interactive, the user can hover on the data point to display title details. "),
#      numericInput("numeric", "How Many Random Numbers Should be Plotted?", 
#                   value = 1000, min = 1, max = 1000, step = 1),
      sliderInput("sliderX", "Pick Minimum and Maximum User Score",
                  0, 10, value = c(0,10)),
      sliderInput("sliderY", "Pick Minimum and Maximum Metascore",
                  0, 100, value = c(0,100)),
      checkboxInput("show_PS4", "Show/Hide PS4", value = TRUE),
      checkboxInput("show_XOne", "Show/Hide X-Box One", value = FALSE),
      checkboxInput("show_PC", "Show/Hide PC", value = FALSE),
      submitButton("Submit")
    ),
    mainPanel(
      h3("Graph of Top New Game Releases"),
      plotlyOutput("plot1")
    )
  )
))