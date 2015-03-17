########################################################################

# generalised additive mixed model for increment chronology(s)

# Initialize
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") #laptop
source("Initialize_gamm.R") # make sure the final datasets are made
rm(list=ls()) # clears whole workspace
South <- read.csv("Final_South_GAMM.csv") #using detrended chron data
West <- read.csv("Final_West_GAMM.csv") #using detrended chron data
library(gamm4)

#######################################################################

#### West Coast a priori model

aPWest = gamm4(OtoWidth ~ s(Ages) + FinWestSST_AnnEsts, random = ~(1|FishName), data = West)

plot(aPWest$gam, pages=1, main = "aPWest")
vis.gam(aPWest$gam)
vis.gam(aPWest$gam, theta = 50)
vis.gam(aPWest$gam, theta = 100)
vis.gam(aPWest$gam, theta = 200)
aPWest$gam
aPWest$mer



#######################################################################

#### South Coast a priori model

aPSouth = gamm4(OtoWidth ~ s(Ages) + FinSouthSST_AnnEsts, random = ~(1|FishName), data = South)

plot(aPSouth$gam, pages=1, main = "aPSouth")
vis.gam(aPSouth$gam)
vis.gam(aPSouth$gam, theta = 50)
vis.gam(aPSouth$gam, theta = 100)
vis.gam(aPSouth$gam, theta = 200)
aPSouth$gam
aPSouth$mer

#######################################################################

#### Compare the models
par(mfrow=c(2,3), mar=c(1,1,1,1))
vis.gam(aPWest$gam, theta = 50)
vis.gam(aPWest$gam, theta = 100)
vis.gam(aPWest$gam, theta = 200)
vis.gam(aPSouth$gam, theta = 50)
vis.gam(aPSouth$gam, theta = 100)
vis.gam(aPSouth$gam, theta = 200)

#######################################################################

# Extending MuMIn's functionality to support gamm
source("Extgamm4.R")

#######################################################################

#### South Coast GAMM selection


#Method: The kitchen sink



library(MuMIn)
SouthFull = gamm4(OtoWidth ~ s(Ages) + 
                 LagFinFSLdat_AnnEsts +
                 FSL_months_Feb +
                 LagFSLdat_Annual +
                 LagFSLdat_Spring +
                 LagFSL_months_Oct+
                 FinFSLdat_SummerDat +
                 FinFSLdat_AutumnDat +
                 LagFSL_months_Nov , random = ~(1|FishName), data = South)


(dd <- dredge(global.model=SouthFull))
# Visualize the model selection table:
par(mfrow = c(1,1),mar = c(3,5,6,4))
plot(dd, labAsExpr = TRUE)
summary(model.avg(dd, subset = delta <= 8))


