library(shiny)
library(leaflet)
library(tidyverse)
library(rgdal)
library(dplyr)
library(lubridate)

OverdosesData <- read.csv("overdose_all.csv")
statepops <- read.csv("nst-est2018-alldata.csv")

#cleaning nonstates out of data
Statepops2 <- statepops[-c((1), (2), (3), (4), (5)),]

#selecting for state and population for 2015
Statepops3 <- Statepops2 %>%
  select(POPESTIMATE2015, NAME)
#Filtering for year and month
OverdosesData1 <- filter(OverdosesData, Year == "2015", Month == "January")

#Joining overdose data set and Population estimate data set
OverDoseDataWPopEst <- left_join(OverdosesData1, Statepops3, by = c("StateName" = "NAME"))

#Creating column with overdose per capita
OverDoseDataWPopEst$IOverdosePerCapita2015 <- OverDoseDataWPopEst$NumberOfDrugOverdoseDeaths / OverDoseDataWPopEst$POPESTIMATE2015

write.csv(OverDoseDataWPopEst, "OverdoseDataWPopEst2015.csv")