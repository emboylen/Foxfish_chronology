# Initialize the comparison dtr methods

setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData") # Ellen's pc
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData") # laptop
# clear environment
rm(list=ls(all=TRUE))
# Read in csv files
list.files()
source("Initialize_Incs_Fox.R")

library(ggplot2)
library(reshape2)
library(gridExtra)
library(dplR)

##############################################################
### Detrend entire rwl
##############################################################


# Detrend with a spline with 
#rigidity parameter equal to 67% of series length

SplSouthFOXDtr = detrend(SouthFOX[,-1], method = "Spline")
SplSouthFOXDtr <- data.frame(SouthFOX[,1], SplSouthFOXDtr)
colnames(SplSouthFOXDtr) <- c("Year", colnames(SouthFOX[,-1]))

SplWestFOXDtr = detrend(WFoxEB[,-1], method = "Spline")
SplWestFOXDtr <- data.frame(WFoxEB[,1], SplWestFOXDtr)
colnames(SplWestFOXDtr) <- c("Year", colnames(WFoxEB[,-1]))

# Detrend with a negative exponential

NegSouthFOXDtr = detrend(SouthFOX[,-1], method = "ModNegExp")
NegSouthFOXDtr <- data.frame(SouthFOX[,1], NegSouthFOXDtr)
colnames(NegSouthFOXDtr) <- c("Year", colnames(SouthFOX[,-1]))

NegWestFOXDtr = detrend(WFoxEB[,-1], method = "ModNegExp")
NegWestFOXDtr <- data.frame(WFoxEB[,1], NegWestFOXDtr)
colnames(NegWestFOXDtr) <- c("Year", colnames(WFoxEB[,-1]))

# Detrend with a negative exponential, then spline with 
#rigidity parameter equal to 67% of series length

DblSouthFOXDtr = detrend(detrend(SouthFOX[,-1], method = "Mod"), method = "Spl")
DblSouthFOXDtr <- data.frame(SouthFOX[,1], DblSouthFOXDtr)
colnames(DblSouthFOXDtr) <- c("Year", colnames(SouthFOX[,-1]))

DblWestFOXDtr = detrend(detrend(WFoxEB[,-1], method = "Mod"), method = "Spl")
DblWestFOXDtr <- data.frame(WFoxEB[,1], DblWestFOXDtr)
colnames(DblWestFOXDtr) <- c("Year", colnames(WFoxEB[,-1]))


##############################################################
### Generatie the MIC lines
##############################################################
## Detrend with a spline with 
#rigidity parameter equal to 67% of series length

SouthFOXDtr = detrend(SouthFOX[,-1], method = "Spline")
SouthFOXDtr <- data.frame(SouthFOX[,1], SouthFOXDtr)
colnames(SouthFOXDtr) <- c("Year", colnames(SouthFOX[,-1]))

WestFOXDtr = detrend(WestFOX[,-1], method = "Spline")
WestFOXDtr <- data.frame(WestFOX[,1], WestFOXDtr)
colnames(WestFOXDtr) <- c("Year", colnames(WestFOX[,-1]))


# Creating master chronologies using dplR
# remove measurements with < 5 observations

MinN <- 6
SouthFOXDtr <- SouthFOXDtr[,-1]
WestFOXDtr <- WestFOXDtr[,-1]


dat1 <- chron(x=SouthFOXDtr, prefix = "xxx", biweight = TRUE, prewhiten = FALSE)
dat2 <- data.frame(SouthFOX[,1], dat1)
dat3 <- dat2[dat2$samp.depth >= MinN,]

dat4 <- chron(x=WestFOXDtr, prefix = "xxx", biweight = TRUE, prewhiten = FALSE)
dat5 <- data.frame(WestFOX[,1], dat4)
dat6 <- dat5[dat5$samp.depth >= MinN,]

# write data to csv
write.csv(dat3, file = "MIC_spline_South.csv", row.names=F)
write.csv(dat6, file = "MIC_spline_West.csv", row.names=F)


#################################################################
## Negative Exponential 

SouthFOXDtr = detrend(SouthFOX[,-1], method = "ModNegExp")
SouthFOXDtr <- data.frame(SouthFOX[,1], SouthFOXDtr)
colnames(SouthFOXDtr) <- c("Year", colnames(SouthFOX[,-1]))

WestFOXDtr = detrend(WestFOX[,-1], method = "ModNegExp")
WestFOXDtr <- data.frame(WestFOX[,1], WestFOXDtr)
colnames(WestFOXDtr) <- c("Year", colnames(WestFOX[,-1]))


# Creating master chronologies using dplR
# remove measurements with < 5 observations
MinN <- 6
SouthFOXDtr <- SouthFOXDtr[,-1]
WestFOXDtr <- WestFOXDtr[,-1]


dat1 <- chron(x=SouthFOXDtr, prefix = "xxx", biweight = TRUE, prewhiten = FALSE)
dat2 <- data.frame(SouthFOX[,1], dat1)
dat3 <- dat2[dat2$samp.depth >= MinN,]

dat4 <- chron(x=WestFOXDtr, prefix = "xxx", biweight = TRUE, prewhiten = FALSE)
dat5 <- data.frame(WestFOX[,1], dat4)
dat6 <- dat5[dat5$samp.depth >= MinN,]

# write data to csv
write.csv(dat3, file = "MIC_NegEXP_South.csv", row.names=F)
write.csv(dat6, file = "MIC_NegEXP_West.csv", row.names=F)


#################################################################
## Double detrending

SouthFOXDtr = detrend(detrend(SouthFOX[,-1], method = "Mod"), method = "Spl")
SouthFOXDtr <- data.frame(SouthFOX[,1], SouthFOXDtr)
colnames(SouthFOXDtr) <- c("Year", colnames(SouthFOX[,-1]))

WestFOXDtr = detrend(detrend(WFoxEB[,-1], method = "Mod"), method = "Spl")
WestFOXDtr <- data.frame(WestFOX[,1], WestFOXDtr)
colnames(WestFOXDtr) <- c("Year", colnames(WestFOX[,-1]))


# Creating master chronologies using dplR
# remove measurements with < 5 observations
MinN <- 6
SouthFOXDtr <- SouthFOXDtr[,-1]
WestFOXDtr <- WestFOXDtr[,-1]


dat1 <- chron(x=SouthFOXDtr, prefix = "xxx", biweight = TRUE, prewhiten = FALSE)
dat2 <- data.frame(SouthFOX[,1], dat1)
dat3 <- dat2[dat2$samp.depth >= MinN,]

dat4 <- chron(x=WestFOXDtr, prefix = "xxx", biweight = TRUE, prewhiten = FALSE)
dat5 <- data.frame(WestFOX[,1], dat4)
dat6 <- dat5[dat5$samp.depth >= MinN,]

# write data to csv
write.csv(dat3, file = "MIC_Dbl_South.csv", row.names=F)
write.csv(dat6, file = "MIC_Dbl_West.csv", row.names=F)