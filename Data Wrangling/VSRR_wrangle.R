library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)



#opens the files and puts them into a data frame
overdose_df <- read_csv("~/drug-abuse-analysis/Data Wrangling/VSRR_Provisional_Drug_Overdose_Death_Counts.csv")

#renames column names to remove space from them
overdose_df <- overdose_df %>%
  rename(DataValue = 'Data Value',
         PercentComplete = 'Percent Complete',
         PercentPendingInvestigation = 'Percent Pending Investigation',
         StateName = 'State Name',
         FootnoteSymbol = 'Footnote Symbol',
         PredictedValue = 'Predicted Value')

#Removes predicted value column
overdose_df <- subset(overdose_df, select = -PredictedValue)

#Filters out unwanted Indicators and unwanted 'States'
overdose_df <- overdose_df %>%
  filter(Indicator != "Number of Deaths" & Indicator != "Percent with drugs specified") %>% #  Indicator != "Number of Drug Overdose Deaths"
  filter(State != 'US') # removes states that contain US, these numbers are sum of overdoses

#This is to make the DataValue column numeric (possibly needed)
overdose_df$DataValue <- as.numeric(as.character( overdose_df$DataValue ))

#Selects 4 columns and filters out number of deaths that are not associated with overdose
overdose_df <- overdose_df %>%
  select('StateName','Year','Month','Indicator', 'DataValue')

write.csv(overdose_df, file = 'overdose_heatmap.csv')

#Spread function to turn Indicators of drug names into columns
overdose_df <- overdose_df %>%
  spread(key=Indicator, value='DataValue')

#renames column names to clean up drug names
colnames(overdose_df)[4:13] <- c("Cocaine", 
                                 "Heroin", 
                                 "Methadone", 
                                 "Natural&Semi-SyntheticOpioids", 
                                 "Natural&Semi-SyntheticOpioids_inclMethadone", 
                                 "Natural_Semi-SyntheticOpioids_&SyntheicOpioids_inclMethadone",
                                 "NumberOfDrugOverdoseDeaths",
                                 "Opioids", 
                                 "PsychostimulantsWithAbusePotnetial", 
                                 "SyntheticOpioids_exclMethadone")

#Reorders columns to put drug overdose death column towards left of data frame
overdose_df <- overdose_df[, c(1, 2, 3, 10, 4, 5, 6, 7, 8, 9, 11, 12, 13)]

#Replaces NA values with zero to allow for indicator variable of specific drug type counts
overdose_specific <- overdose_df

overdose_specific[is.na(overdose_specific)] <- 0

#Gets the total overdose deaths and the drug that caused in for the whole country for every year (Dr. Whitworth showed me this method), now used as indicator for specific drug identified
overdose_specific$TotalKnownDeath <- sapply(1:nrow(overdose_specific), function(row) { sum (overdose_specific[row, 5:13])})
overdose_specific$TotalKnownDeath <- ifelse(overdose_specific$TotalKnownDeath>0, 1, 0)

#Filter dataframe for values of TotalDeath that do not equal zero, this gives data frame with drug use specified
#Also creates a general data frame with all states/months regeardless of specificty
overdose_specific <- overdose_specific %>%
  filter(TotalKnownDeath == 1)

overdose_all <- overdose_df

#Saves wrangled data frame into a csv file
write.csv(overdose_all, file = 'overdose_all.csv')
write.csv(overdose_specific, file = 'overdose_specific.csv')

#Function to count when specific drug breakdown data would work best
  #Decided on January 2021 due to there being 43 states with data by drug category for this period, other time periods had less state data available
overdose_count <- overdose_specific %>%
  filter(Year == 2021) %>%
  filter(Month == 'January')
length(unique(overdose_count$StateName))

