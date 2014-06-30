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

library(dplR)

# South Coast
#####

# Read in csv files
list.files()
SouthFOX <- read.csv("SouthFoxPC.csv")
SouthFOX <- SouthFOX[,-1] # get rid of Year col
x <- colnames(SouthFOX)
y <- substring(x, 2)
colnames(SouthFOX) <- c("row.names", y[2:length(y)])
write.rwl(rwl.df = SouthFOX, fname = "SouthFOXPC.rwl", format = "tucson")
data <- read.rwl("SouthFOXPC.rwl", format = "tucson")

# X-dating in dplR
# Read in data, explore
dat <- data
dat.sum <- summary(dat)
mean(dat.sum$year) # length of series
mean(dat.sum$stdev)
mean(dat.sum$median)
mean(dat.sum$ar1) # first order correlation
mean(interseries.cor(dat)[,1], method = "kendall") # mean intereseries correlation

# Create output
Output <- dat.sum[-1,] # take out the row.names variable (row 1)
Age.range.min <- min(Output$year)
Age.range.max <- max(Output$year)
Age.range <- paste(Age.range.min, Age.range.max, sep = "-")
Mean.incs <- mean(Output$year)
Interseries.correlation <- mean(interseries.cor(dat)[,1])
Mean.sensitivity <- mean(Output$sens1)
Standard.deviation <- mean(Output$stdev)
n <- length(Output$series)
South.Coast <- data.frame(ID = "South Coast",Age.range, Mean.incs, Interseries.correlation, Mean.sensitivity, Standard.deviation,n)

plot(dat[,-1], plot.type = "spag")
rwl.2 <- corr.rwl.seg(dat, seg.length=4, bin.floor=0,pcrit = 0.05)
# seg.2 <- corr.series.seg(rwl=dat, series = "060089", seg.length=4, bin.floor=0) # of a single fish


# West Coast
#####


WestFOX <- read.csv("WestFOX.csv")
WestFOX <- WestFOX[,-1]
x <- colnames(WestFOX)
y <- substring(x, 2)
colnames(WestFOX) <- c("row.names", y[2:length(y)])
write.rwl(rwl.df = WestFOX, fname = "WestFOX.rwl", format = "tucson")
data <- read.rwl("WestFOX.rwl", format = "tucson")

# X-dating in dplR
library(dplR)
# Read in data, explore
dat <- data
dat.sum <- summary(dat)
mean(dat.sum$year) # length of series
mean(dat.sum$stdev)
mean(dat.sum$median)
mean(dat.sum$ar1) # first order correlation
mean(interseries.cor(dat)[,1]) # mean intereseries correlation

# Create output
Output <- dat.sum[-1,] # take out the row.names variable (row 1)
Age.range.min <- min(Output$year)
Age.range.max <- max(Output$year)
Age.range <- paste(Age.range.min, Age.range.max, sep = "-")
Mean.incs <- mean(Output$year)
Interseries.correlation <- mean(interseries.cor(dat)[,1])
Mean.sensitivity <- mean(Output$sens1)
Standard.deviation <- mean(Output$stdev)
n <- length(Output$series)
West.Coast <- data.frame(ID = "West Coast",Age.range, Mean.incs, Interseries.correlation, Mean.sensitivity, Standard.deviation,n)

plot(dat[,-1], plot.type = "spag")
rwl.2 <- corr.rwl.seg(dat, seg.length=4, bin.floor=0,pcrit = 0.05)
# seg.2 <- corr.series.seg(rwl=data, series = "060089", seg.length=4, bin.floor=0) # of a single fish

# Combine 2 data frames, export as csv
total <- rbind(West.Coast, South.Coast)
write.csv(total, "Xdating_Output_PC.csv", row.names=F)
