##########################
### Increment Analysis ###
##########################

##################
### Initialize ###
##################

setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData") # Ellen's pc
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData") # laptop
# clear environment
rm(list=ls(all=TRUE))
# Read in csv files
list.files()
SFoxEB <- read.csv("SouthFoxEB.csv")
SFoxPC <- read.csv("SouthFoxPC.csv")
WFoxEB <- read.csv("WestFoxEB.csv")
WFoxPC <- read.csv("WestFoxPC.csv")

# Combine (mean) EB's and PC's measurements
library(abind)

SouthFOX <- data.frame(apply(abind(SFoxEB,SFoxPC,along=3),c(1,2),mean))
WestFOX <- data.frame(apply(abind(WFoxEB,WFoxPC,along=3),c(1,2),mean))

# Write to CSV 
write.csv(SouthFOX, file = "SouthFOX.csv")
write.csv(WestFOX, file = "WestFOX.csv")
