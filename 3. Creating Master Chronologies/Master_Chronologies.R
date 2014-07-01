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
SFoxPC <- read.csv("SouthFoxPC.csv")
WFoxPC <- read.csv("WestFoxPC.csv")


# Creating master chronologies using dplR
# remove measurements with < 5 observations
MinN <- 6
SFoxPC1 <- SFoxPC[,-1]
WFoxPC1 <- WFoxPC[,-1]


library(dplR)
dat1 <- chron(x=SFoxPC1, prefix = "xxx", biweight = TRUE, prewhiten = FALSE)
dat1 <- data.frame(SFoxPC[,1], dat1)
dat2 <- dat1[dat1$samp.depth >= MinN,]
dat3 <- chron(x=WFoxPC1, prefix = "xxx", biweight = TRUE, prewhiten = FALSE)
dat3 <- data.frame(WFoxPC[,1], dat3)
dat4 <- dat1[dat1$samp.depth >= MinN,]

# write data to csv
write.csv(dat2, file = "Master_SouthFOX.csv", row.names=F)
write.csv(dat4, file = "Master_WestFOX.csv", row.names=F)


# Alternatively: creating master chronologies - manually
# library(reshape2)
# 
# SouthFOXMean <- rowMeans(SFoxPC[,-1], na.rm = TRUE, dims = 1)
# NewSouthFOX <- data.frame(SFoxPC[,1], SouthFOXMean)
# colnames(NewSouthFOX) <- c("Year", "Mean")
# WestFOXMean <- rowMeans(WFoxPC[,-1], na.rm = TRUE, dims = 1)
# NewWestFOX <- data.frame(WFoxPC[,1], WestFOXMean)
# colnames(NewWestFOX) <- c("Year", "Mean")
# 
# # Plotting
# plot(NewWestFOX, type="l")
# plot(NewSouthFOX, type="l")
