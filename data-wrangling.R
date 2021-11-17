library(dplyr)
library(ggplot2)
library(readr)
library(tidyverse)



#opens the files and puts them into a data frame
overdose_df <- read_csv("~/drug-abuse-analysis/VSRR_Provisional_Drug_Overdose_Death_Counts.csv")

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

#Replaces NA values with zero
overdose_df[is.na(overdose_df)] <- 0

#Reorders columns to put drug overdose death column towards left of data frame
overdose_df <- overdose_df[, c(1, 2, 3, 10, 4, 5, 6, 7, 8, 9, 11, 12, 13)]

#Gets the total overdose deaths and the drug that caused in for the whole country for every year (Dr. Whitworth showed me this method), now used as indicator for specific drug identified
overdose_df$TotalKnownDeath <- sapply(1:nrow(overdose_df), function(row) { sum (overdose_df[row, 5:13])})
overdose_df$TotalKnownDeath <- ifelse(overdose_df$TotalKnownDeath>0, 1, 0)

#Filter dataframe for values of TotalDeath that do not equal zero, this gives data frame with drug use specified
#Also creates a general data frame with all states/months regeardless of specificty
overdose_specific <- overdose_df %>%
  filter(TotalKnownDeath != 0)
View(overdose_specific)

overdose_all <- overdose_df
View(overdose_all)

#Saves wrangled data frame into a csv file
#write.csv(overdose_df, file = "home/kohlj22/drug-abuse-analysis/overdose_df.csv")

#Going forward: decide on which month to use for a given state in a given year and finish creating totalDeath column based on sapply function & save each data frame as .csv files

