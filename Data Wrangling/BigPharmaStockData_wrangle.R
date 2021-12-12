library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)

#opens the files and puts them into a data frame
BigPharmaPercent <- read_csv("~/drug-abuse-analysis/BigPharmaStockData34.csv")

BigPharmaPercent$pct_change <- 0
BigPharmaPercent <- BigPharmaPercent %>%
  group_by(conm) %>% 
  mutate(pct_change = (prccm/lag(prccm) - 1) * 100)

View(BigPharmaPercent)

write.csv(BigPharmaPercent, file = 'BigPharmaStockData.csv')