# To run them all
rm(list = ls(all = TRUE)) 
ItVec <<- 999
SampVec <<- 800
setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Bio Data")
Sys.time()
source("Power_Analysis_SouthFox_5Sig.R")
setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Bio Data")
Sys.time()
source("Power_Analysis_SouthFox_1Sig.R")
setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Bio Data")
Sys.time()
source("Power_Analysis_WestFox_5Sig.R")
setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Bio Data")
Sys.time()
source("Power_Analysis_WestFox_1Sig.R")
setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Bio Data")
Sys.time()
source("Power_Analysis_Boar_5Sig.R")
setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Bio Data")
Sys.time()
source("Power_Analysis_Boar_1Sig.R")
Sys.time()

library(gridExtra)

setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Results/Fox Fish/South Coast")

png("Power_South_Fox_Smooth.png", width=600, height=800)
grid.arrange(p1, p3, ncol=1)
dev.off()

png("Power_South_Fox.png", width=600, height=800)
grid.arrange(p2, p4, ncol=1)
dev.off()

setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Results/Fox Fish/West Coast")

png("Power_West_Fox_Smooth.png", width=600, height=800)
grid.arrange(p5, p7, ncol=1)
dev.off()

png("Power_West_Fox.png", width=600, height=800)
grid.arrange(p6, p8, ncol=1)
dev.off()

setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Results/Boarfish")

png("Power_South_Boar_Smooth.png", width=600, height=800)
grid.arrange(p9, p11, ncol=1)
dev.off()

png("Power_South_Boar.png", width=600, height=800)
grid.arrange(p10, p12, ncol=1)
dev.off()

setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Results")

png("Power_All_Smooth.png", width=1000, height=800)
grid.arrange(p1, p5, p9, p3, p7, p11, ncol=3)
dev.off()

png("Power_All.png", width=1000, height=800)
grid.arrange(p2, p6, p10, p4, p8, p12, ncol=3)
dev.off()


