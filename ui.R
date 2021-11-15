library(shiny)
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
      )
    )),
  dashboardBody(
    tabItems(
      tabItem("Healthcare", InvestmentStates)
    )
  ))

