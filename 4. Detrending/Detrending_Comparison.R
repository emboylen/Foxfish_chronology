##################
### Detrending ###
##################

setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData") # pc
rm(list=ls(all=TRUE))

list.files()

library(dplR)

Sdata <- read.rwl("SouthFOXPC_dtr.rwl", format = "tucson")
Wdata <- read.rwl("WestFOXPC_dtr.rwl", format = "tucson")

Sdata.rwi <- i.detrend(chron(Sdata), y.name = "South Coast", pos.slope = TRUE)
Wdata.rwi <- i.detrend(chron(Wdata), y.name = "West Coast", pos.slope = TRUE)
