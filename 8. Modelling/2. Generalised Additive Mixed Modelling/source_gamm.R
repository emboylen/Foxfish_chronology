setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis")
list.files()
rm(list=ls()) # clears whole workspace
system.time(source("gamm_analysis.R")) # will take an hour to run
