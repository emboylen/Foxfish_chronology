setwd("C:/Users/User/Google Drive/Honours/Results/Env/SST") # ellen's pc
list.files()
rm(list=ls(all=TRUE))
# Get the mean of the West Coast Data
library(abind)
# Read in all the csvs
Rotto <- read.csv("SST_Data_Rotto.csv")
Rotto1 <- read.csv("SST_Data_Rotto1.csv")
Rotto2 <- read.csv("SST_Data_Rotto2.csv")
Rotto3 <- read.csv("SST_Data_Rotto3.csv")
Rotto4 <- read.csv("SST_Data_Rotto4.csv")

# Get rid of month column
Rotto <- Rotto[,-1]
Rotto1 <- Rotto1[,-1]
Rotto2 <- Rotto2[,-1]
Rotto3 <- Rotto3[,-1]
Rotto4 <- Rotto4[,-1]

# Find the mean of the 4 sites
WestSST <- data.frame(apply(abind(Rotto, Rotto1, Rotto2, Rotto3, Rotto4, along=3),c(1,2),mean))

# Add in the month column
Month <- month.abb
West_Coast_SST <- cbind(Month, WestSST)

# Export the data as a csv
write.csv(West_Coast_SST, file = "West_Coast_SST.csv")


# Get the mean of the South Coast Data
list.files()
rm(list=ls(all=TRUE))
library(abind)
# Read in all the csvs
Aug <- read.csv("SST_Data_Aug.csv")
Aug1 <- read.csv("SST_Data_Aug1.csv")
Aug2 <- read.csv("SST_Data_Aug2.csv")
Alb <- read.csv("SST_Data_Albany.csv")
Alb1 <- read.csv("SST_Data_Albany1.csv")
Esp <- read.csv("SST_Data_Esp.csv")
Esp1 <- read.csv("SST_Data_Esp1.csv")


# Get rid of month column
Aug <- Aug[,-1]
Aug1 <- Aug1[,-1]
Aug2 <- Aug2[,-1]
Alb <- Alb[,-1]
Alb1 <- Alb1[,-1]
Esp <- Esp[,-1]
Esp1 <- Esp1[,-1]


# Find the mean of the 4 sites
SouthSST <- data.frame(apply(abind(Aug, Aug1, Aug2, Alb, Alb1, Esp, Esp1, along=3),c(1,2),mean))

# Add in the month column
Month <- month.abb
South_Coast_SST <- cbind(Month, SouthSST)

# Export the data as a csv
write.csv(South_Coast_SST, file = "South_Coast_SST.csv")