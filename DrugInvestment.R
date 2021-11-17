

library("readxl")
StateInvestmentInDrugs <- read_excel("StateInvestmentInDrugs.xlsx")

#Getting rid of regional rows
UpdatedSIID <- StateInvestmentInDrugs[-c(2, 3, 10, 17, 23, 31, 44, 49, 55), ]

names(UpdatedSIID) <- as.matrix(UpdatedSIID[1, ])
UpdatedSIID <- UpdatedSIID[-1, ]
UpdatedSIID [] <- lapply(UpdatedSIID, function(x) type.convert(as.character(x)))

UpdatedSIID <- UpdatedSIID[-c(26)]

names(UpdatedSIID)[names(UpdatedSIID) == 'Region/state of residence'] <- 'States'

library(leaflet)
library(rgdal)

geo <- readOGR("states.geo.json")

library(dplyr)
newData  <- left_join(geo@data, UpdatedSIID, by = c("NAME" = "States"))
geo@data <- newData
View(geo@data)


library(tidyverse)

devtools::install_github("nsgrantham/uspops")

library(uspops)

View(state_pops)

NewPops <- state_pops %>%
  select(year, state, pop) %>%
  filter(year > "1990" & year < "2015")
View(NewPops)

NewPops2 <- spread(NewPops, key = year, value = pop)
View(NewPops2)

NewPops2 <- NewPops2 %>% slice(-c(40))

geo@data <- geo@data %>% slice(-c(17))

NewPops3 <- data.frame(t(NewPops2[-1]))
colnames(NewPops3) <- NewPops2[, 1]
View(NewPops3)

library(tidyr)
NewPops4 <- NewPops3 %>% gather("states", "pops", 1:51) 
View(NewPops4)

NewPops5 <- NewPops2 %>% gather("years", "pops", 2:25)

geo@data <- geo@data %>% gather("years", "Investments", 6:29)
View(geo@data)

geo@data$Investments <- geo@data$Investments * 1000000
View(geo@data)

NewData3 <- left_join(geo@data, NewPops5, by = c("NAME" = "state", "years" = "years"))
geo@data <- NewData3
View(geo@data)

geo@data$pops.y <- NULL
View(geo@data)

geo@data$InvestmentPerCapita <- geo@data$Investments / geo@data$pops.x
View(geo@data)

InvestmentStates <- 
  fluidRow(
    box(
      titlePanel("Timeline of State Investment in Drugs"),
      "The Growth of Statewide Investment in Drugs in the United States from 1991 to 2014 using a log scale to view the change in values.",
      width = 12,
      leafletOutput("InvestmentOvertime"),
      sliderInput("yearsforinvestment", "year", min(geo@data$InvestmentPerCapita), max(geo@data$InvestmentPerCapita), value = min(geo@data$InvestmentPerCapita), animate = TRUE)
    )
  )


