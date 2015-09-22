########################################################################

# Inializing for GAMM

########################################################################
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
 setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace
list.files()
# Read in mean chronologies
SFoxPC <- read.csv("MIC_Dbl_West.csv")
WFoxPC <- read.csv("MIC_Dbl_South.csv")
colnames(SFoxPC) <- c("Year", "MIC", "Depth")
colnames(WFoxPC) <- c("Year", "MIC", "Depth")
# library(reshape2)
# ReSouth <- melt(SFoxPC, id.vars = "Year")
# ReWest <- melt(WFoxPC, id.vars = "Year")

## Env data

# West sig variables
WestSST <- read.csv("West_SST_comb.csv")
FinWestSST <- read.csv("Financial_SST_West.csv")
SST_West_Months <- read.csv("SST_West_Months.csv")

# South sig variables
SouthSST <- read.csv("South_SST_comb.csv")
FinSouthSST <- read.csv("Financial_SST_South.csv")
SST_South_Months <- read.csv("SST_South_Months.csv")

# FSL variables
FSLdat <- read.csv("FSL_comb.csv")
FinFSLdat <- read.csv("Financial_FSL.csv")
FSL_months <- read.csv("FSL_months.csv")

# Lag variables
LagWestSST <- WestSST; LagWestSST$Year <- LagWestSST$ Year-1
LagFinWestSST <- FinWestSST; LagFinWestSST$Year <- LagFinWestSST$Year -1
LagSST_South_Months <- SST_South_Months; LagSST_South_Months$Year <- LagSST_South_Months$Year -1

LagSouthSST <- SouthSST; LagSouthSST$Year <- LagSouthSST$Year -1
LagFinSouthSST <- FinSouthSST; LagFinSouthSST$Year <- LagFinSouthSST$Year -1
LagSST_West_Months <- SST_West_Months; LagSST_West_Months$Year <- LagSST_West_Months$Year -1

LagFSLdat <- FSLdat; LagFSLdat$Year <- LagFSLdat$Year -1
LagFinFSLdat <- FinFSLdat; LagFinFSLdat$Year <- LagFinFSLdat$Year -1
LagFSL_months <- FSL_months; LagFSL_months$X <- LagFSL_months$X -1
#source("HighstatLibV6.R")

##############################################

# Make a big data frame of environmental variables

##############################################


# calender year variables
colnames(FSLdat) = paste("FSLdat", colnames(FSLdat), sep="_")
colnames(SouthSST) = paste("SouthSST", colnames(SouthSST), sep="_")
colnames(WestSST) = paste("WestSST", colnames(WestSST), sep="_")

# monthly variables
colnames(FSL_months) = paste("FSL_months", colnames(FSL_months), sep="_")
colnames(SST_South_Months) = paste("SST_South_Months", colnames(SST_South_Months), sep="_")
colnames(SST_West_Months) = paste("SST_West_Months", colnames(SST_West_Months), sep="_")

# lag 1 year calender variables
colnames(LagFSLdat) = paste("LagFSLdat", colnames(LagFSLdat), sep="_")
colnames(LagSouthSST) = paste("LagSouthSST", colnames(LagSouthSST), sep="_")
colnames(LagWestSST) = paste("LagWestSST", colnames(LagWestSST), sep="_")

# lag 1 year monthly variables
colnames(LagFSL_months) = paste("LagFSL_months", colnames(LagFSL_months), sep="_")
colnames(LagSST_South_Months) = paste("LagSST_South_Months", colnames(LagSST_South_Months), sep="_")
colnames(LagSST_West_Months) = paste("LagSST_West_Months", colnames(LagSST_West_Months), sep="_")

# financial year variables
colnames(FinFSLdat) = paste("FinFSLdat", colnames(FinFSLdat), sep="_")
colnames(FinSouthSST) = paste("FinSouthSST", colnames(FinSouthSST), sep="_")
colnames(FinWestSST) = paste("FinWestSST", colnames(FinWestSST), sep="_")

# lag 1 year financial year variables
colnames(LagFinFSLdat) = paste("LagFinFSLdat", colnames(LagFinFSLdat), sep="_")
colnames(LagFinSouthSST) = paste("LagFinSouthSST", colnames(LagFinSouthSST), sep="_")
colnames(LagFinWestSST) = paste("LagFinWestSST", colnames(LagFinWestSST), sep="_")


###############
##### Select the correct years to make a nice data frame
##

# ** Be careful here ** don't run this more than once

#Remove year 2013 from SST data
SouthSST <- SouthSST[-(nrow(SouthSST)),]
SST_South_Months <- SST_South_Months[-(nrow(SST_South_Months)),]
FinSouthSST <- FinSouthSST[-(nrow(FinSouthSST)),]
LagSouthSST <- LagSouthSST[-(nrow(LagSouthSST)),]
LagFinSouthSST <- LagFinSouthSST[-(nrow(LagFinSouthSST)),]

WestSST <- WestSST[-(nrow(WestSST)),]
SST_West_Months <- SST_West_Months[-(nrow(SST_West_Months)),]
FinWestSST <- FinWestSST[-(nrow(FinWestSST)),]
LagWestSST <- LagWestSST[-(nrow(LagWestSST)),]
LagFinWestSST <- LagFinWestSST[-(nrow(LagFinWestSST)),]

# ** Be careful here ** don't run this more than once
# Make 1931:2012 in FSL data
FSLdat <- FSLdat[35:nrow(FSLdat),]
FSL_months <- FSL_months[35:nrow(FSL_months),]
FinFSLdat <- FinFSLdat[35:nrow(FinFSLdat),]
LagFSLdat <- LagFSLdat[36:nrow(LagFSLdat),]
LagFinFSLdat <- LagFinFSLdat[36:nrow(LagFinFSLdat),]
LagFSL_months <- LagFSL_months[36:nrow(LagFSL_months),]

##############################################

# Make a big data frame of fish variables

##############################################


MyFunction <- function(DataSet, IT) {
  Fishdat <- DataSet[,IT]
  FishName <- names(DataSet)[IT]
  YrFsDat <- cbind(Year=DataSet[,1], OtoWidth=Fishdat)
  newYrFsDat <- na.omit(YrFsDat)
  MaxCalcAge <- nrow(newYrFsDat)
  Ages <- seq(from=MaxCalcAge, by=-1, length=nrow(newYrFsDat))
  outputDat <- data.frame(FishName, newYrFsDat, Ages)
  return (outputDat)
}

DataSet <- WFoxPC

TotObs <- ncol(DataSet) - 1

WestDF <- NULL

for (X in 2:TotObs) WestDF <- rbind(WestDF,MyFunction(DataSet, IT=X))

DataSet <- SFoxPC

TotObs <- ncol(DataSet) - 1

SouthDF <- NULL

for (X in 2:TotObs) SouthDF <- rbind(SouthDF,MyFunction(DataSet, IT=X))

WestDF <- WestDF[order(WestDF$Year) , ] # re order the data
SouthDF <- SouthDF[order(SouthDF$Year) , ] # re order the data


# SouthDF$Site <- "West"
# WestDF$Site <- "South"
# 
# BigDF <- rbind(WestDF, SouthDF)


##############################################

# Merge fish and env data frames

##############################################



FSL <- data.frame(FSLdat[-nrow(FSLdat),], FSL_months[-nrow(FSL_months),], LagFSLdat, LagFSL_months,
                  FinFSLdat[-nrow(FinFSLdat),], LagFinFSLdat,row.names = NULL)

Sth <- data.frame(SouthSST, SST_South_Months, LagSouthSST, LagSST_South_Months[-1,], FinSouthSST, LagFinSouthSST, row.names=NULL)

Wst <- data.frame(WestSST, SST_West_Months, LagWestSST, LagSST_West_Months[-1,], FinWestSST, LagFinWestSST, row.names=NULL)

# trim year 2012 from Sth and Wst
Sth <- Sth[-nrow(Sth),]
Sth$Year <- Sth$SouthSST_Year
Wst <- Wst[-nrow(Wst),]
Wst$Year <- Wst$WestSST_Year

South1 <- data.frame(FSL, Sth, row.names=NULL)
West1 <- data.frame(FSL, Wst, row.names=NULL)


South_Full <- merge(South1, SFoxPC, by="Year")

write.csv(South_Full, "South_Full.csv", row.names=F, )


West_Full <- merge(West1, WFoxPC, by="Year")

write.csv(West_Full, "West_Full.csv", row.names=F, )

##############################################
# Create a data frame with sig variables + MIC
##############################################

attach(South_Full)

SouthSig <- data.frame( Year,  SouthSST_Annual ,  SST_South_Months_Jun ,
                          LagSouthSST_Spring ,  LagSST_South_Months_Sep ,
                        LagSST_South_Months_Nov ,  FinSouthSST_AnnEsts ,  LagFinSouthSST_AnnEsts ,
                          LagFinSouthSST_SpringDat ,
                         #FSL
                          FSLdat_Annual ,  FSLdat_Summer ,  FSLdat_Autumn ,
                          FSLdat_Spring ,  FSL_months_Jan ,  FSL_months_Feb ,
                          FSL_months_Mar ,  FSL_months_Apr ,  FSL_months_May ,
                          FSL_months_Oct ,  LagFSLdat_Annual ,
                          LagFSLdat_Summer ,  LagFSLdat_Autumn , LagFSLdat_Winter ,
                          LagFSLdat_Spring ,  LagFSL_months_Feb , LagFSL_months_Apr ,
                          LagFSL_months_May ,  LagFSL_months_Jun ,  LagFSL_months_Jul ,
                          LagFSL_months_Aug ,  LagFSL_months_Sep ,  LagFSL_months_Oct ,
                          LagFSL_months_Nov ,  FinFSLdat_AnnEsts  ,  FinFSLdat_SummerDat ,
                          FinFSLdat_AutumnDat , FinFSLdat_SpringDat ,  LagFinFSLdat_AnnEsts  ,
                          LagFinFSLdat_SummerDat ,  LagFinFSLdat_AutumnDat ,
                          LagFinFSLdat_SpringDat  )
detach(South_Full)

attach(West_Full)
WestSig <- data.frame( Year,  
                        WestSST_Annual ,  WestSST_Winter , 
                        WestSST_Spring ,  SST_West_Months_Jun , 
                        SST_West_Months_Jul ,  SST_West_Months_Sep , 
                        SST_West_Months_Oct ,  LagWestSST_Spring ,  LagSST_West_Months_Oct ,
                        LagSST_West_Months_Nov ,  LagSST_West_Months_Dec ,
                        FinWestSST_AnnEsts   ,  FinWestSST_SummerDat ,
                        FinWestSST_SpringDat ,  LagFinWestSST_AnnEsts ,  LagFinWestSST_SpringDat ,
                       #FSL
                        FSLdat_Spring ,  FSL_months_Apr ,  FinFSLdat_AnnEsts)
                        
detach(West_Full)
##############################################

write.csv(SouthSig, "SouthSig.csv", row.names=F, )
write.csv(WestSig, "WestSig.csv", row.names=F, )




SouthSig <- read.csv("SouthSig.csv")
WestSig <- read.csv("WestSig.csv")
df <- read.csv("BigD.csv")
South <- df[df$Site == "South",] #using non-detrended chron data
West <- df[df$Site == "West",] #using non-detrended chron data

Southdat <- merge(SouthSig, South, by="Year")
Westdat <- merge(WestSig, West, by = "Year")

write.csv(Southdat, "Final_South_GAMM.csv")
write.csv(Westdat, "Final_West_GAMM.csv")