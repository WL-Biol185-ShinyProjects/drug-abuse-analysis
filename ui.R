library(shiny)
library(shinydashboard)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(lubridate)
library(leaflet)
library(stringr)

source("DrugInvestment2.R")
source("HomePage.R")
source("StateDrugDataPage.R")
source("BigPharmaPerformance.R")
source("AboutPage.R")



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
        "Big Pharma Performance", tabName = "BigPharmaPerformance", icon = icon("chart-line")),
        menuItem(
          "About", tabName = "About", icon = icon("pills"))
    )),
  dashboardBody(
    tabItems(
      tabItem(tabName = "Home", homepagetext),
      tabItem(tabName = "PrescriptionDrugInvestment", InvestmentStates),
      tabItem(tabName = "States", StateDrugData),
      tabItem(tabName = "BigPharmaPerformance", BigPharmaPerformanceText),
      tabItem(tabName = "About", AboutPageText)
      )
    )
  )

