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
        "Big Pharma Performance", tabName = "BigPharmaPerformance", icon = icon("chart-line")
      )
    )),
  dashboardBody(
    tabItems(
      tabItem("Home", homepagetext),
      tabItem("PrescriptionDrugInvestment", InvestmentStates)
    )
  ))

