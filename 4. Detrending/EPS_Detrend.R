##################
### Detrending ###
##################

setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData") # pc
rm(list=ls(all=TRUE))

list.files()
SouthFOX <- read.csv("SouthFOX.csv")
WestFOX <- read.csv("WestFOX.csv")

library(dplR)
library(detrendeR)

#evaluate chronology, pre-detrending
SRaw <- rwi.stats(SouthFOX)
WRaw <- rwi.stats(WestFOX)


# Detrend with a spline with 
#rigidity parameter equal to 67% of series length


SplSouthFOXDtr = detrend(SouthFOX[,-1], method = "Spline")
SplSouthFOXDtr <- data.frame(SouthFOX[,1], SplSouthFOXDtr)
colnames(SplSouthFOXDtr) <- c("Year", colnames(SouthFOX[,-1]))

SplWestFOXDtr = detrend(WestFOX[,-1], method = "Spline")
SplWestFOXDtr <- data.frame(WestFOX[,1], SplWestFOXDtr)
colnames(SplWestFOXDtr) <- c("Year", colnames(WestFOX[,-1]))


SSpl <- rwi.stats(SplSouthFOXDtr)
WSpl <- rwi.stats(SplWestFOXDtr)

# Detrend with a negative exponential

NegSouthFOXDtr = detrend(SouthFOX[,-1], method = "ModNegExp")
NegSouthFOXDtr <- data.frame(SouthFOX[,1], NegSouthFOXDtr)
colnames(NegSouthFOXDtr) <- c("Year", colnames(SouthFOX[,-1]))

NegWestFOXDtr = detrend(WestFOX[,-1], method = "ModNegExp")
NegWestFOXDtr <- data.frame(WestFOX[,1], NegWestFOXDtr)
colnames(NegWestFOXDtr) <- c("Year", colnames(WestFOX[,-1]))

SNeg <- rwi.stats(NegSouthFOXDtr)
WNeg <- rwi.stats(NegWestFOXDtr)

# Detrend with a negative exponential, then spline with 
#rigidity parameter equal to 67% of series length

DblSouthFOXDtr = detrend(detrend(SouthFOX[,-1], method = "Mod"), method = "Spl")
DblSouthFOXDtr <- data.frame(SouthFOX[,1], DblSouthFOXDtr)
colnames(DblSouthFOXDtr) <- c("Year", colnames(SouthFOX[,-1]))

DblWestFOXDtr = detrend(detrend(WestFOX[,-1], method = "Mod"), method = "Spl")
DblWestFOXDtr <- data.frame(WestFOX[,1], DblWestFOXDtr)
colnames(DblWestFOXDtr) <- c("Year", colnames(WestFOX[,-1]))


SDbl <- rwi.stats(DblSouthFOXDtr)
WDbl <- rwi.stats(DblWestFOXDtr)

#EPS data
rownam <- c("Raw", "NegExp", "Spline", "Double")
Sou <- data.frame(rownam, c(SRaw$eps, SNeg$eps, SSpl$eps, SDbl$eps))
Wes <- data.frame(rownam, c(WRaw$eps, WNeg$eps, WSpl$eps, WDbl$eps))
dat <- data.frame(Sou, Wes[,2])
colnames(dat) <- c("Type", "South", "West")

# R bar data
Sou1 <- data.frame(rownam, c(SRaw$rbar.eff, SNeg$rbar.eff, SSpl$rbar.eff, SDbl$rbar.eff))
Wes1 <- data.frame(rownam, c(WRaw$rbar.eff, WNeg$rbar.eff, WSpl$rbar.eff, WDbl$rbar.eff))
dat1 <- data.frame(Sou1, Wes1[,2])
colnames(dat1) <- c("Type", "South", "West")

write.csv(dat, "Foxfish_EPS.csv")
write.csv(dat1, "Foxfish_rbareff.csv")
