# Part 1:
# simple correlations


########################################################################
# Raw Data
########################################################################

########################################################################
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace
list.files()
# Read in mean chronologies
West <- read.csv("Master_WestFOX.csv")
South <- read.csv("Master_SouthFOX.csv")
# Environmental data
WestSST <- read.csv("West_SST_comb.csv")
SouthSST <- read.csv("South_SST_comb.csv")
# Reverse the order of years in SST data
WestSST <- WestSST[with(WestSST, order(-Year)), ]
SouthSST <- SouthSST[with(SouthSST, order(-Year)), ]

# Leeuwin current
FSL <- read.csv('FSL_comb.csv')
# Reverse the order of years in FSL data
FSL <- FSL[with(FSL, order(-Year)), ]
colnames(FSL) <- paste("FSL", colnames(FSL), sep = "_")

# Create some data frames where SST and master chronologies line up

Data_West <- data.frame(West, WestSST[10:59,], FSL[9:58,], row.names = NULL)
Data_South <- data.frame(South, SouthSST[9:61,], FSL[8:60,],  row.names=NULL)
# check that the years line up

########################################################################
# Correlations
########################################################################

# 
library(lattice)  #For fancy multipanel graphs
source("HighstatLibV6.R")

# West data
MyVar <- c("xxxstd","Annual", "Summer", "Autumn", "Winter", "Spring")
MyVar2 <- c("xxxstd", "FSL_Annual", "FSL_Summer", "FSL_Autumn", "FSL_Winter", "FSL_Spring")
pairs(Data_West[,MyVar],lower.panel = panel.cor)
pairs(Data_West[,MyVar2],lower.panel = panel.cor)
cor(Data_West[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_West))

# South data
MyVar <- c("xxxstd","Annual", "Summer", "Autumn", "Winter", "Spring")
MyVar2 <- c("xxxstd", "FSL_Annual", "FSL_Summer", "FSL_Autumn", "FSL_Winter", "FSL_Spring")
pairs(Data_South[,MyVar],lower.panel = panel.cor)
pairs(Data_South[,MyVar2],lower.panel = panel.cor)
cor(Data_South[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_South))

########################################################################
### Detrended ###
########################################################################
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace

# Read in mean chronologies
WestDtr <- read.csv("Master_WestFOX_Dtr.csv")
SouthDtr <- read.csv("Master_SouthFOX_Dtr.csv")
# Environmental data
WestSST <- read.csv("West_SST_comb.csv")
SouthSST <- read.csv("South_SST_comb.csv")
# Reverse the order of years in SST data
WestSST <- WestSST[with(WestSST, order(-Year)), ]
SouthSST <- SouthSST[with(SouthSST, order(-Year)), ]

# Leeuwin current
FSL <- read.csv('FSL_comb.csv')
# Reverse the order of years in FSL data
FSL <- FSL[with(FSL, order(-Year)), ]
colnames(FSL) <- paste("FSL", colnames(FSL), sep = "_")

# Create some data frames where SST and master chronologies line up

Data_West <- data.frame(WestDtr, WestSST[10:59,], FSL[9:58,], row.names = NULL)
Data_South <- data.frame(SouthDtr, SouthSST[9:61,], FSL[8:60,],  row.names=NULL)
# check that the years line up

########################################################################
# Correlations
########################################################################

# 
library(lattice)  #For fancy multipanel graphs
source("HighstatLibV6.R")

# West data
MyVar <- c("xxxstd","Annual", "Summer", "Autumn", "Winter", "Spring")
MyVar2 <- c("xxxstd", "FSL_Annual", "FSL_Summer", "FSL_Autumn", "FSL_Winter", "FSL_Spring")
pairs(Data_West[,MyVar],lower.panel = panel.cor)
pairs(Data_West[,MyVar2],lower.panel = panel.cor)
cor(Data_West[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_West))

res <- rcorr(as.matrix(Data_West))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/West_dat.csv")

# South data
MyVar <- c("xxxstd","Annual", "Summer", "Autumn", "Winter", "Spring")
MyVar2 <- c("xxxstd", "FSL_Annual", "FSL_Summer", "FSL_Autumn", "FSL_Winter", "FSL_Spring")
pairs(Data_South[,MyVar],lower.panel = panel.cor)
pairs(Data_South[,MyVar2],lower.panel = panel.cor)
cor(Data_South[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_South))

res <- rcorr(as.matrix(Data_South))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/South_dat.csv")

########################################################################
### Lag 1 year Detrended ###
########################################################################
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace

# Read in mean chronologies
WestDtr <- read.csv("Master_WestFOX_Dtr.csv")
SouthDtr <- read.csv("Master_SouthFOX_Dtr.csv")
# Environmental data
WestSST <- read.csv("West_SST_comb.csv")
SouthSST <- read.csv("South_SST_comb.csv")
# Reverse the order of years in SST data
WestSST <- WestSST[with(WestSST, order(-Year)), ]
SouthSST <- SouthSST[with(SouthSST, order(-Year)), ]

# Leeuwin current
FSL <- read.csv('FSL_comb.csv')
# Reverse the order of years in FSL data
FSL <- FSL[with(FSL, order(-Year)), ]
colnames(FSL) <- paste("FSL", colnames(FSL), sep = "_")

# Create some data frames where SST and master chronologies line up

Data_West <- data.frame(WestDtr, WestSST[11:60,], FSL[10:59,], 
                        row.names = NULL)
Data_South <- data.frame(SouthDtr, SouthSST[10:62,], FSL[9:61,], 
                         row.names=NULL)
# check that the years line up

########################################################################
# Correlations
########################################################################

# 
library(lattice)  #For fancy multipanel graphs
source("HighstatLibV6.R")

# West data
MyVar <- c("xxxstd","Annual", "Summer", "Autumn", "Winter", "Spring")
MyVar2 <- c("xxxstd", "FSL_Annual", "FSL_Summer", "FSL_Autumn", "FSL_Winter", "FSL_Spring")
pairs(Data_West[,MyVar],lower.panel = panel.cor)
pairs(Data_West[,MyVar2],lower.panel = panel.cor)
cor(Data_West[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_West))

res <- rcorr(as.matrix(Data_West))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/West_Lag.csv")

# South data
MyVar <- c("xxxstd","Annual", "Summer", "Autumn", "Winter", "Spring")
MyVar2 <- c("xxxstd", "FSL_Annual", "FSL_Summer", "FSL_Autumn", "FSL_Winter", "FSL_Spring")
pairs(Data_South[,MyVar],lower.panel = panel.cor)
pairs(Data_South[,MyVar2],lower.panel = panel.cor)
cor(Data_South[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_South))

res <- rcorr(as.matrix(Data_South))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/South_Lag.csv")


###################
# Monthly levels
###
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace

# Read in mean chronologies
WestDtr <- read.csv("Master_WestFOX_Dtr.csv")
SouthDtr <- read.csv("Master_SouthFOX_Dtr.csv")
# Environmental data
WestSST <- read.csv("SST_West_Months.csv")
SouthSST <- read.csv("SST_South_Months.csv")
# Reverse the order of years in SST data
WestSST <- WestSST[with(WestSST, order(-Year)), ]
SouthSST <- SouthSST[with(SouthSST, order(-Year)), ]

# Leeuwin current
FSL <- read.csv('FSL_months.csv')
# Reverse the order of years in FSL data
FSL <- FSL[with(FSL, order(-X)), ]
colnames(FSL) <- paste("FSL", colnames(FSL), sep = "_")

# Create some data frames where SST and master chronologies line up

Data_West <- data.frame(WestDtr, WestSST[10:59,], FSL[9:58,], 
                        row.names = NULL)
Data_South <- data.frame(SouthDtr, SouthSST[9:61,], FSL[8:60,], 
                         row.names=NULL)
# check that the years line up

########################################################################
# Correlations
########################################################################

# 
library(lattice)  #For fancy multipanel graphs
source("HighstatLibV6.R")

# West data
MyVar <- c("xxxstd", month.abb)
MyVar2 <- c("xxxstd", month.abb)
pairs(Data_West[,MyVar],lower.panel = panel.cor)
pairs(Data_West[,MyVar2],lower.panel = panel.cor)
cor(Data_West[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_West))

res <- rcorr(as.matrix(Data_West))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/West_months.csv")

# South data
MyVar <- c("xxxstd", month.abb)
MyVar2 <- c("xxxstd", month.abb)
pairs(Data_South[,MyVar],lower.panel = panel.cor)
pairs(Data_South[,MyVar2],lower.panel = panel.cor)
cor(Data_South[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_South))


res <- rcorr(as.matrix(Data_South))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/South_months.csv")


###################
# Lag 1 year Monthly levels
###
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace

# Read in mean chronologies
WestDtr <- read.csv("Master_WestFOX_Dtr.csv")
SouthDtr <- read.csv("Master_SouthFOX_Dtr.csv")
# Environmental data
WestSST <- read.csv("SST_West_Months.csv")
SouthSST <- read.csv("SST_South_Months.csv")
# Reverse the order of years in SST data
WestSST <- WestSST[with(WestSST, order(-Year)), ]
SouthSST <- SouthSST[with(SouthSST, order(-Year)), ]

# Leeuwin current
FSL <- read.csv('FSL_months.csv')
# Reverse the order of years in FSL data
FSL <- FSL[with(FSL, order(-X)), ]
colnames(FSL) <- paste("FSL", colnames(FSL), sep = "_")

# Create some data frames where SST and master chronologies line up

Data_West <- data.frame(WestDtr, WestSST[11:60,], FSL[10:59,], 
                        row.names = NULL)
Data_South <- data.frame(SouthDtr, SouthSST[10:62,], FSL[9:61,], 
                         row.names=NULL)
# check that the years line up

########################################################################
# Correlations
########################################################################

# 
library(lattice)  #For fancy multipanel graphs
source("HighstatLibV6.R")

# West data
MyVar <- c("xxxstd", month.abb)
MyVar2 <- c("xxxstd", month.abb)
pairs(Data_West[,MyVar],lower.panel = panel.cor)
pairs(Data_West[,MyVar2],lower.panel = panel.cor)
cor(Data_West[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_West))


res <- rcorr(as.matrix(Data_West))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/West_Lag_months.csv")

# South data
MyVar <- c("xxxstd", month.abb)
MyVar2 <- c("xxxstd", month.abb)
pairs(Data_South[,MyVar],lower.panel = panel.cor)
pairs(Data_South[,MyVar2],lower.panel = panel.cor)
cor(Data_South[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_South))


res <- rcorr(as.matrix(Data_South))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/South_Lag_months.csv")


###################
# Financial calender
###
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace

# Read in mean chronologies
WestDtr <- read.csv("Master_WestFOX_Dtr.csv")
SouthDtr <- read.csv("Master_SouthFOX_Dtr.csv")
# Environmental data
WestSST <- read.csv("Financial_SST_West.csv")
SouthSST <- read.csv("Financial_SST_South.csv")
# Reverse the order of years in SST data
WestSST <- WestSST[with(WestSST, order(-Years)), ]
SouthSST <- SouthSST[with(SouthSST, order(-Years)), ]

# Leeuwin current
FSL <- read.csv("Financial_FSL.csv")
# Reverse the order of years in FSL data
FSL <- FSL[with(FSL, order(-Years)), ]
colnames(FSL) <- paste("FSL", colnames(FSL), sep = "_")

# Create some data frames where SST and master chronologies line up

Data_West <- data.frame(WestDtr, WestSST[10:59,], FSL[9:58,], 
                        row.names = NULL)
Data_South <- data.frame(SouthDtr, SouthSST[9:61,], FSL[8:60,], 
                         row.names=NULL)
# check that the years line up

########################################################################
# Correlations
########################################################################

# 
library(lattice)  #For fancy multipanel graphs
source("HighstatLibV6.R")

# West data
MyVar <- c("xxxstd", "Month")
MyVar2 <- c("xxxstd", "Month")
pairs(Data_West[,MyVar],lower.panel = panel.cor)
pairs(Data_West[,MyVar2],lower.panel = panel.cor)
cor(Data_West[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_West))


res <- rcorr(as.matrix(Data_West))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/West_Fin.csv")


# South data
MyVar <- c("xxxstd", month.abb)
MyVar2 <- c("xxxstd", month.abb)
pairs(Data_South[,MyVar],lower.panel = panel.cor)
pairs(Data_South[,MyVar2],lower.panel = panel.cor)
cor(Data_South[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_South))


res <- rcorr(as.matrix(Data_South))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/South_Fin.csv")



###################
# Financial calender lag -1 year
###
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace

# Read in mean chronologies
WestDtr <- read.csv("Master_WestFOX_Dtr.csv")
SouthDtr <- read.csv("Master_SouthFOX_Dtr.csv")
# Environmental data
WestSST <- read.csv("Financial_SST_West.csv")
SouthSST <- read.csv("Financial_SST_South.csv")
# Reverse the order of years in SST data
WestSST <- WestSST[with(WestSST, order(-Years)), ]
SouthSST <- SouthSST[with(SouthSST, order(-Years)), ]

# Leeuwin current
FSL <- read.csv("Financial_FSL.csv")
# Reverse the order of years in FSL data
FSL <- FSL[with(FSL, order(-Years)), ]
colnames(FSL) <- paste("FSL", colnames(FSL), sep = "_")

# Create some data frames where SST and master chronologies line up

Data_West <- data.frame(WestDtr, WestSST[11:60,], FSL[10:59,], 
                        row.names = NULL)
Data_South <- data.frame(SouthDtr, SouthSST[10:62,], FSL[9:61,], 
                         row.names=NULL)
# check that the years line up

########################################################################
# Correlations
########################################################################

# 
library(lattice)  #For fancy multipanel graphs
source("HighstatLibV6.R")

# West data
MyVar <- c("xxxstd", "Month")
MyVar2 <- c("xxxstd", "Month")
pairs(Data_West[,MyVar],lower.panel = panel.cor)
pairs(Data_West[,MyVar2],lower.panel = panel.cor)
cor(Data_West[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_West))


res <- rcorr(as.matrix(Data_West))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/West_Lag_Fin.csv")

# South data
MyVar <- c("xxxstd", month.abb)
MyVar2 <- c("xxxstd", month.abb)
pairs(Data_South[,MyVar],lower.panel = panel.cor)
pairs(Data_South[,MyVar2],lower.panel = panel.cor)
cor(Data_South[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_South))

res <- rcorr(as.matrix(Data_South))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/South_Lag_Fin.csv")
