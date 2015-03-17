# Exploratory analysis of the relationship between SST and FSL

# Initialize
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") #laptop
rm(list=ls()) # clears whole workspace
list.files()
FSL <- read.csv("FSL_months.csv")
# head(FSL)
# X   Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
# 1 1897 0.542 0.524 0.557 0.655 0.648 0.729 0.641 0.518 0.499 0.465 0.499 0.498
# 2 1898 0.527 0.664 0.400 0.620 0.827 0.781 0.736 0.622 0.534 0.628 0.534 0.541
# 3 1899 0.585 0.646 0.704 0.732 0.638 0.705 0.695 0.599    NA    NA    NA    NA
# 4 1900 0.519 0.538 0.526 0.686    NA 0.803 0.714    NA 0.546 0.611 0.546 0.550
# 5 1901 0.478 0.516 0.607 0.677 0.745 0.777 0.714 0.639 0.558 0.528 0.558 0.599
SSTw <- read.csv("SST_West_Months.csv")
# head(SSTw)
# Year   Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
# 1 1931 20.98 21.42 21.31 21.29 20.17 19.09 17.90 17.14 17.60 17.97 19.21 20.66
# 2 1932 20.98 22.13 21.76 21.34 20.60 19.44 18.75 17.99 17.92 18.13 18.61 19.84
# 3 1933 20.53 22.07 21.97 21.30 20.71 19.51 18.90 18.01 18.10 18.32 18.55 19.88
# 4 1934 21.04 22.08 21.64 21.01 20.08 19.38 18.50 17.68 17.63 18.08 18.88 20.28
# 5 1935 20.39 20.99 21.07 20.96 20.54 19.23 18.75 17.49 17.39 17.73 18.23 19.33
# 6 1936 20.37 21.27 21.76 21.35 20.38 18.72 18.24 17.93 17.65 18.31 18.83 19.70
SSTs <- read.csv("SST_South_Months.csv")
# head(SSTs)
# Year   Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
# 1 1931 18.74 19.22 18.76 18.52 17.87 16.62 16.02 14.67 15.77 15.87 16.38 18.27
# 2 1932 18.87 20.10 19.55 19.11 19.09 17.57 16.57 15.41 15.67 15.81 16.26 17.60
# 3 1933 18.20 19.66 19.60 18.68 18.08 17.42 16.08 15.79 15.75 15.91 16.48 17.95
# 4 1934 19.29 20.27 19.45 18.94 18.30 17.49 16.26 16.03 15.48 15.92 16.64 18.14
# 5 1935 18.65 19.24 19.00 18.68 18.11 17.13 16.27 15.15 15.63 15.69 15.97 17.45
# 6 1936 18.60 19.44 19.45 18.80 18.05 16.80 16.32 15.69 15.88 16.33 16.80 17.63

# All the datasets are in the same format...how am I going to plot this?
# I could either do a combined plot or a grid.arrange lattice plot for each month
# and for each region

# to start I need to reshape the data, using "melt" from the package reshape
library(reshape)
moltenFSL <- melt(FSL, id.vars = "Year") # well that didn't work, need to recode X
names(FSL) <- c("Year","Jan","Feb","Mar","Apr","May","Jun","Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
moltenFSL <- melt(FSL, id.vars = "Year")
moltenSSTw <- melt(SSTw, id.vars = "Year")
moltenSSTs <- melt(SSTs, id.vars = "Year")

# I need to create a Date-structure variable before plotting
moltenFSL$Date <- paste(1, month.abb[moltenFSL$variable], moltenFSL$Year, sep="" )
moltenFSL$Date <- as.Date(moltenFSL$Date, format = "%d%b%Y")

moltenSSTs$Date <- paste(1, month.abb[moltenSSTs$variable], moltenSSTs$Year, sep="" )
moltenSSTs$Date <- as.Date(moltenSSTs$Date, format = "%d%b%Y")

moltenSSTw$Date <- paste(1, month.abb[moltenSSTw$variable], moltenSSTw$Year, sep="" )
moltenSSTw$Date <- as.Date(moltenSSTw$Date, format = "%d%b%Y")

# Everything's coming up Ellen! Let's plot the single variables

ggplot(moltenFSL, aes(x=Date, y=value)) + geom_point() + theme_classic()

ggplot(moltenSSTs, aes(x=Date, y=value)) + geom_point() + theme_classic()

ggplot(moltenSSTw, aes(x=Date, y=value)) + geom_point() + theme_classic()


# Need to merge the data frames so ggplot2 can deal with it, emotionally

WestCor <- merge(x=moltenFSL, y=moltenSSTw, by=c("Date"))
SouthCor <- merge(x=moltenFSL, y=moltenSSTs, by=c("Date"))

# OK, that's Beautiful
# Now I just need to get plotting with ggplot2 using facet_wrap for the months

library(ggplot2)

ggplot(WestCor, aes(x=value.x, y=value.y)) + geom_point() + theme_classic() + labs(title = "West Coast", x = "FSL", y="SST")

ggplot(SouthCor, aes(x=value.x, y=value.y)) + geom_point() + theme_classic() + labs(title = "South Coast", x = "FSL", y="SST")

# Now with a lm line
ggplot(WestCor, aes(x=value.x, y=value.y)) + geom_point() + theme_classic() + labs(title = "West Coast", x = "FSL", y="SST") + stat_smooth(method="lm", se=FALSE)

ggplot(SouthCor, aes(x=value.x, y=value.y)) + geom_point() + theme_classic() + labs(title = "South Coast", x = "FSL", y="SST") + stat_smooth(method="lm", se=FALSE)

# Initial imporessions - that is surprisingly un-related. I thought there was going to be a large correlation between the two

# Now that we've done that, time to export the graphs
W<-ggplot(WestCor, aes(x=value.x, y=value.y)) + geom_point() + theme_classic() + labs(title = "West Coast", x = "FSL", y="SST")
S<-ggplot(SouthCor, aes(x=value.x, y=value.y)) + geom_point() + theme_classic() + labs(title = "South Coast", x = "FSL", y="SST")
Wa<-ggplot(WestCor, aes(x=value.x, y=value.y)) + geom_point() + theme_classic() + labs(title = "West Coast", x = "FSL", y="SST") + stat_smooth(method="lm", se=FALSE)
Sa<-ggplot(SouthCor, aes(x=value.x, y=value.y)) + geom_point() + theme_classic() + labs(title = "South Coast", x = "FSL", y="SST") + stat_smooth(method="lm", se=FALSE)
require(gridExtra)
pdf("SSTvsFSL.pdf")
grid.arrange(W,S, ncol=2, nrow=1)
W
S
Wa
Sa
dev.off()

# Now to do some correlation analyses
# H[0] = There is a relationship between sea surface temperature and Fremantle sea level
# H[1] = There is no relationship between sea surface temperature and Fremantle sea level

# Correlations with significance levels
library(Hmisc)
Wct <- cor.test(x=WestCor$value.x, y=WestCor$value.y, method = "pearson") 
write.csv(unlist(Wct), "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/WestSSTvsFSL.csv")

Sct <- cor.test(x=SouthCor$value.x, y=SouthCor$value.y, method = "pearson") 
write.csv(unlist(Sct), "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/SouthSSTvsFSL.csv")
