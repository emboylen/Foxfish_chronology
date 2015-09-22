########################################################################

# generalised additive mixed model for increment chronology(s)

# Initialize
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") #laptop
#source("Initialize_gamm.R") # make sure the final datasets are made
rm(list=ls()) # clears whole workspace
South <- read.csv("Final_South_GAMM.csv") #using detrended chron data
West <- read.csv("Final_West_GAMM.csv") #using detrended chron data
library(gamm4)

#######################################################################

#### West Coast a priori model

aPWest = gamm4(OtoWidth ~ s(Ages) + FinWestSST_AnnEsts, random = ~(1|FishName), data = West)

plot(aPWest$gam, pages=1, main=substitute(paste(italic('a priori'), " Model West " )), ylab = substitute(paste(italic('f'), "(Ages)" )))
vis.gam(aPWest$gam)
vis.gam(aPWest$gam, theta = 50)
vis.gam(aPWest$gam, theta = 100)
vis.gam(aPWest$gam, theta = 200)
aPWest$gam
summary(aPWest$gam)
aPWest$mer
summary(aPWest$mer)

#######################################################################

#### South Coast a priori model

aPSouth = gamm4(OtoWidth ~ s(Ages) + FinSouthSST_AnnEsts, random = ~(1|FishName), data = South)

plot(aPSouth$gam, pages=1, main=substitute(paste(italic('a priori'), " Model South " )),ylab = substitute(paste(italic('f'), "(Ages)" )))
vis.gam(aPSouth$gam)
vis.gam(aPSouth$gam, theta = 50)
vis.gam(aPSouth$gam, theta = 100)
vis.gam(aPSouth$gam, theta = 200)
aPSouth$gam
summary(aPSouth$gam)
aPSouth$mer
summary(aPSouth$mer)

#######################################################################


#### West Coast a priori model

aPWest1 = gamm4(OtoWidth ~ s(Ages) + FinFSLdat_AnnEsts, random = ~(1|FishName), data = West)

plot(aPWest1$gam, pages=1, main=substitute(paste(italic('a priori'), " Model West " )), ylab = substitute(paste(italic('f'), "(Ages)" )))
vis.gam(aPWest1$gam)
vis.gam(aPWest1$gam, theta = 50)
vis.gam(aPWest1$gam, theta = 100)
vis.gam(aPWest1$gam, theta = 200)
aPWest1$gam
summary(aPWest1$gam)
aPWest1$mer
summary(aPWest1$mer)


#######################################################################

#### South Coast a priori model

aPSouth1 = gamm4(OtoWidth ~ s(Ages) + FinFSLdat_AnnEsts, random = ~(1|FishName), data = South)

plot(aPSouth1$gam, pages=1, main=substitute(paste(italic('a priori'), " Model South " )),ylab = substitute(paste(italic('f'), "(Ages)" )))
vis.gam(aPSouth1$gam)
vis.gam(aPSouth1$gam, theta = 50)
vis.gam(aPSouth1$gam, theta = 100)
vis.gam(aPSouth1$gam, theta = 200)
aPSouth1$gam
summary(aPSouth1$gam)
aPSouth1$mer
summary(aPSouth1$mer)

#######################################################################

#### Compare the models
par(mfrow=c(2,3), mar=c(1,1,1,1))

vis.gam(aPSouth$gam, theta = 200)
vis.gam(aPSouth$gam, theta = 100)
vis.gam(aPSouth$gam, theta = 50)

vis.gam(aPWest$gam, theta = 200)
vis.gam(aPWest$gam, theta = 100)
vis.gam(aPWest$gam, theta = 50)


#### Compare the models
par(mfrow=c(2,3), mar=c(1,1,1,1))

# vis.gam(aPSouth1$gam, theta = 200)
# vis.gam(aPSouth1$gam, theta = 100)
# vis.gam(aPSouth1$gam, theta = 50)

vis.gam(aPWest1$gam, theta = 200)
vis.gam(aPWest1$gam, theta = 100)
vis.gam(aPWest1$gam, theta = 50)

#######################################################################

#### Compare ALL models
par(mfrow=c(3,3), mar=c(1,1,1,1))

vis.gam(aPSouth$gam, theta = 200)
vis.gam(aPSouth$gam, theta = 100)
vis.gam(aPSouth$gam, theta = 50)

vis.gam(aPWest$gam, theta = 200)
vis.gam(aPWest$gam, theta = 100)
vis.gam(aPWest$gam, theta = 50)

vis.gam(aPWest1$gam, theta = 200)
vis.gam(aPWest1$gam, theta = 100)
vis.gam(aPWest1$gam, theta = 50)

#######################################################################

####  GAMM selection


#Method: The kitchen sink
library(MuMIn)


#### South Coast GAMM selection

SouthFull = uGamm(OtoWidth ~ s(Ages) + 
                    SST_South_Months_Jun +
                    FinSouthSST_AnnEsts +
                    FSLdat_Autumn +
                    FSL_months_Jan+
                    FSL_months_Apr +
                    FSL_months_May +
                    FSL_months_Oct +
                    FinFSLdat_AnnEsts +
                    FinFSLdat_SummerDat +
                    FinFSLdat_SpringDat, random = ~(1|FishName), data = South)


getCall(SouthFull)
update(SouthFull) 
a <- dredge(SouthFull) # takes around 30 minutes to run
# Visualize the model selection table:
par(mfrow = c(1,1),mar = c(3,5,8,4), cex.axis = 0.7)
plot(a)
plot(a$gam,pages=1)
aa <- summary(model.avg(a, subset = delta <= 8))
# export the data frame into excel
write.csv(a, "South_dredge.csv")
write.csv(aa[[1]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge1.csv")
write.csv(aa[[2]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge2.csv")
write.csv(aa[[3]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge3.csv")
write.csv(aa[[4]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge4.csv")
write.csv(aa[[5]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge5.csv")
write.csv(aa[[6]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge6.csv")
write.csv(aa[[7]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge7.csv")
write.csv(aa[[8]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge8.csv")
write.csv(aa[[9]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge9.csv")
write.csv(aa[[10]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge10.csv")
write.csv(aa[[11]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge11.csv")
write.csv(aa[[12]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge12.csv")
write.csv(aa[[13]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge13.csv")
write.csv(aa[[14]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge14.csv")
write.csv(aa[[15]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\South_dredge15.csv")



#### West Coast GAMM selection

WestFull = uGamm(OtoWidth ~ s(Ages) + 
                   WestSST_Winter +
                   WestSST_Spring +
                   SST_West_Months_Jun +
                   SST_West_Months_Jul +
                   SST_West_Months_Sep +
                   SST_West_Months_Oct +
                   FinWestSST_AnnEsts +
                   FinWestSST_SummerDat +
                   FSLdat_Spring +
                   FSL_months_Apr +
                   FinFSLdat_AnnEsts, random = ~(1|FishName), data = West)


getCall(WestFull)
update(WestFull) 
b <- dredge(WestFull) # takes around 4 minutes to run
# b1 <- subset(b, delta <= 4, recalc.weights = FALSE)
write.csv(b1, "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredgeDelta4.csv")
# Visualize the model selection table:
par(mfrow = c(1,1),mar = c(3,5,6,4), )
plot(b)
bb <- summary(model.avg(b, subset = delta <= 8))
# export the data frame into excel
write.csv(b, "West_dredge.csv")
write.csv(bb[[1]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge1.csv")
write.csv(bb[[2]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge2.csv")
write.csv(bb[[3]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge3.csv")
write.csv(bb[[4]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge4.csv")
write.csv(bb[[5]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge5.csv")
write.csv(bb[[6]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge6.csv")
write.csv(bb[[7]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge7.csv")
write.csv(bb[[8]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge8.csv")
write.csv(bb[[9]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge9.csv")
write.csv(bb[[10]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge10.csv")
write.csv(bb[[11]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge11.csv")
write.csv(bb[[12]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge12.csv")
write.csv(bb[[13]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge13.csv")
write.csv(bb[[14]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge14.csv")
write.csv(bb[[15]], "C:\\Users\\User\\Google Drive\\Honours\\Results\\IncrementData\\Analysis\\Dredge Results\\West_dredge15.csv")

# Hack a word doc friendly summary
summary(aa)
head(aa[[1]])
aa[[2]]
head(aa[[3]])
aa[[4]]
aa[[6]]
aa[[7]]
aa[[8]]
aa[[9]]
head(aa[[10]])
head(aa[[11]])
head(aa[[12]])
head(aa[[13]])
head(aa[[14]])
aa[[15]]

summary(bb)
head(bb[[1]])
bb[[2]]
head(bb[[3]])
bb[[4]]
bb[[6]]
bb[[7]]
bb[[8]]
bb[[9]]
head(bb[[10]])
head(bb[[11]])
head(bb[[12]])
head(bb[[13]])
head(bb[[14]])
bb[[15]]



#######################################################################

#### West Coast Model Selection

DrWest = uGamm(OtoWidth ~ s(Ages) + FinWestSST_AnnEsts, random = ~(1|FishName), data = West)

plot(DrWest$gam, pages=1, main=substitute(paste(italic('a priori'), " Model West " )), ylab = substitute(paste(italic('f'), "(Ages)" )))
par(mfrow=c(2,2), mar=c(2,1,1,1))
vis.gam(DrWest$gam)
vis.gam(DrWest$gam, theta = 50)
vis.gam(DrWest$gam, theta = 100)
vis.gam(DrWest$gam, theta = 200)
DrWest$gam
summary(DrWest$gam)
DrWest$mer
summary(DrWest$mer)


M1 = uGamm(OtoWidth ~ s(Ages) + 
             WestSST_Winter +
             WestSST_Spring +
             SST_West_Months_Jun +
             SST_West_Months_Jul +
             SST_West_Months_Sep +
             SST_West_Months_Oct +
             FinWestSST_AnnEsts +
             FinWestSST_SummerDat +
             FSLdat_Spring +
             FSL_months_Apr +    FinFSLdat_AnnEsts, random = ~(1|FishName), data = West)
summary(M1$gam)
get.models(dredge(M1,rank="AIC"))[1]
#######################################################################

#### South Coast model selection

DrSouth = uGamm(OtoWidth ~ s(Ages) + 
                  FSLdat_Autumn +
                  FSL_months_Jan+
                  FSL_months_Apr +
                  FSL_months_May +
                  FSL_months_Oct +
                  FinFSLdat_AnnEsts +
                  FinFSLdat_SummerDat +
                  FinFSLdat_SpringDat, random = ~(1|FishName), data = South)


plot(DrSouth$gam, pages=1, main=" Model Dredge South " ,ylab = substitute(paste(italic('f'), "(Ages)" )))
par(mfrow=c(2,2), mar=c(2,1,1,1))
vis.gam(DrSouth$gam)
vis.gam(DrSouth$gam, theta = 50)
vis.gam(DrSouth$gam, theta = 100)
vis.gam(DrSouth$gam, theta = 200)
DrSouth$gam
summary(DrSouth$gam)
DrSouth$mer
summary(DrSouth$mer)

