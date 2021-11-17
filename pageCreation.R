library(shiny)
library(shinydashboard)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(lubridate)
library(leaflet)
library(stringr)

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
        "Home", tabName = "home", icon = icon("home")
      ),
      menuItem(
        "National Drug Abuse Breakdown", tabName = "States", icon = icon("map-marked")
      ),
      menuItem(
        "Healthcare Investment Compared to Drug Rates", tabName = "Healthcare", icon = icon("dollar-sign")
      ),
      menuItem(
        "About", tabName = "about", icon = icon("info-circle")
      )
    )
  ))

