# Write .rwl files

setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData") # Ellen's pc
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData") # laptop

# clear environment
rm(list=ls(all=TRUE))
list.files()

library(dplR)

# South Coast
#####

# Read in csv files
SouthFOX <- read.csv("SouthFoxPC.csv")
SouthFOX <- SouthFOX[,-1] # get rid of Year col
# x <- colnames(SouthFOX)
# y <- substring(x, 2)
# colnames(SouthFOX) <- c("row.names", y[2:length(y)])
write.rwl(rwl.df = SouthFOX, fname = "SouthFOXPC_dtr.rwl", format = "auto")
data1 <- read.rwl("SouthFOXPC_dtr.rwl", format = "tucson")

# West Coast
#####

# Read in csv files
WestFOX <- read.csv("WestFOXPC.csv")
WestFOX <- WestFOX[,-1]
x <- colnames(WestFOX)
y <- substring(x, 2)
colnames(WestFOX) <- c("row.names", y[2:length(y)])
write.rwl(rwl.df = WestFOX, fname = "WestFOXPC_dtr.rwl", format = "auto")
data2 <- read.rwl("WestFOXPC_dtr.rwl", format = "tucson")
