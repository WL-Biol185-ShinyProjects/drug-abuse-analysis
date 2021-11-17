library(shiny)
<<<<<<< HEAD
fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("number",
                  label = "Choose a number",
                  min = 0,
                  max = 100,
                  value = 50
                  ),
      selectInput("distribution",
                  label = "Choose a distribution",
                  choices = c("normal", "uniform", "poisson"))
    ),
  mainPanel(
    plotOutput("histogram"),
    textOutput("summary")
  )
    )
)
=======
library(shinydashboard)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(lubridate)
library(leaflet)
library(stringr)

source("DrugInvestment2.R")

#making the dashboard
dashboardPage(
  
  #dashboard heading
  
  dashboardHeader(
    title = 'US Drug Abuse Analysis',
    titleWidth = 300
  ),
  
  #Sidebar menu of Dashboard
  
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        "Home", tabName = "Home", icon = icon("home")),
      menuItem(
        "National Drug Abuse", tabName = "States", icon = icon("map-marked")),
      menuItem(
        "Prescription Drug Investment", tabName = "PrescriptionDrugInvestment", icon = icon("dollar-sign")),
      menuItem(
        "Pharmaceutical Industry Effects", tabName = "PharmaceuticalIndustryEffects", icon = icon("pills")),
      menuItem(
        "About", tabName = "about", icon = icon("info-circle")
        "Big Pharma Performance", tabName = "BigPharmaPerformance", icon = icon("chart-line")
      )
    )),
  dashboardBody(
    tabItems(
      tabItem("Healthcare", InvestmentStates)
    )
  ))

>>>>>>> e177167ad2caa92ee95b4df1b30d23c5cc3e5ac8
