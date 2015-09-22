#################
### Synchrony ###
#################

##################
### Initialize ###
##################

setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData") # Ellen's pc
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData") # laptop
# clear environment
rm(list=ls(all=TRUE))

library(dplR)

# Read in csv files
list.files()

SouthFOX <- read.csv("SouthFOX.csv")
WestFOX <- read.csv("WestFOX.csv")

# merge two data frames by ID
total <- merge(SouthFOX,WestFOX,by="Year")
Whole <- total[,-2]

# write to ring-width file
write.rwl(rwl.df = Whole, fname = "Whole.rwl", format = "tucson")
data <- read.rwl("Whole.rwl", format = "tucson")

# X-dating in dplR
# Read in data, explore
dat <- data
dat.sum <- summary(dat)
mean(dat.sum$year) # length of series
mean(dat.sum$stdev)
mean(dat.sum$median)
mean(dat.sum$ar1) # first order correlation
mean(interseries.cor(dat)[,1]) # mean intereseries correlation

# Create output
Output <- dat.sum
Age.range.min <- min(Output$year)
Age.range.max <- max(Output$year)
Age.range <- paste(Age.range.min, Age.range.max, sep = "-")
Mean.incs <- mean(Output$year)
Interseries.correlation <- mean(interseries.cor(dat)[,1])
Mean.sensitivity <- mean(Output$sens1)
Standard.deviation <- mean(Output$stdev)
n <- length(Output$series)
South.Coast <- data.frame(Age.range, Mean.incs, Interseries.correlation, Mean.sensitivity, Standard.deviation,n)

the <- dat[,c(-1,-31)]
plot(the, plot.type = "spag")
rwl.2 <- corr.rwl.seg(dat, seg.length=4, bin.floor=0,pcrit = 0.05)
# seg.2 <- corr.series.seg(rwl=dat, series = "060089", seg.length=4, bin.floor=0) # of a single fish



##################################################################################################################
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData") # Ellen's pc

# SouthMIC <- read.csv("Master_SouthFOX_Dtr.csv")
# WestMIC <- read.csv("Master_WestFOX_Dtr.csv")

SouthMIC <- read.csv("MIC_Dbl_South.csv")
WestMIC <- read.csv("MIC_Dbl_West.csv")

colnames(SouthMIC) <- c("Year", "MIC", "Depth")
colnames(WestMIC) <- c("Year", "MIC", "Depth")

plot(SouthMIC$MIC~SouthMIC$Year, type="l", col = "blue")
lines(WestMIC$MIC~WestMIC$Year, col = "red")

plot(WestMIC$MIC, type="l")

Data <- merge(SouthMIC, WestMIC, by = "Year", by.x = "Year")
names(Data) <- c("Year", "South", "SDepth", "West", "WDepth")
#write.csv(Data, "MIC_Combined.csv")

plot(Data$South~Data$West, pch = 18)
M1 <- lm(Data$South~Data$West)
summary(M1)


setwd("C:/Users/User/Google Drive/Honours/Results/Env/SST")
list.files()
Data <- read.csv("South_Coast_SST.csv")

library(dplR)
# Detrend with a spline with 
#rigidity parameter equal to 67% of series length

# SSTdr = detrend(Data[,-1], method = "Spline")
# SST <- data.frame(Data[,1], SSTdr)

Mean <- colMeans(Data[,3:ncol(Data)], na.rm = TRUE)
Year <- rep(2013:1931, each=1)
df <- data.frame(Mean, Year, row.names = NULL)
plot(Year,Mean, type="l")


plot(SouthMIC$MIC~SouthMIC$Year, type="l", col = "blue")
lines(WestMIC$MIC~WestMIC$Year, col = "red")

plot(SouthMIC$MIC~WestMIC$MIC, pch = 18)
M1 <- lm(SouthMIC$MIC~WestMIC$MIC)
summary(M1)



plot (c(1945,2010),c(0.8, 1.1),type="n", xaxt = 'n', yaxt='n', # sets the x and y axes scales 

      xlab="Year",ylab="Detrended Mean Index Chronology (MIC)") # adds titles to the axes 

lines(SouthMIC$MIC~SouthMIC$Year,col="blue",lwd=1.5) # adds a line for South MIC

lines(WestMIC$MIC~WestMIC$Year,col="red",lwd=1.5) # adds a line for West MIC


axis(1, tck=0.02) # changing ticks to inside
axis(2, tck=0.02) # changing ticks to inside

legend(1944, 0.86, # places a legend at the appropriate place 
       c("South coast MIC","Lower-west MIC"), # puts text in the legend 
       
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       
       lwd=c(1.5,1.5),col=c("blue","red")) # gives the legend lines the correct color and width


##################
### Initialize ###
##################

setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData") # Ellen's pc
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData") # laptop
# clear environment
rm(list=ls(all=TRUE))
# Read in csv files
list.files()
source("Initialize_Incs_Fox.R")
source("Initialize_Dtr_Fig.R")

library(ggplot2)
library(reshape2)
library(gridExtra)
library(dplR)


MICs <- read.csv("MIC_Dbl_South.csv")
colnames(MICs) <- c("Year", "South", "Depth")

NewSouthFOX <- merge(MICs[,-3], DblSouthFOXDtr, by = "Year")
df7 <- melt(NewSouthFOX, id.vars = 'Year')


MICw <- read.csv("MIC_Dbl_West.csv")
colnames(MICw) <- c("Year", "West", "Depth")

NewWestFOX <- merge(MICw[,-3], DblWestFOXDtr, by = "Year")
df8 <- melt(NewWestFOX, id.vars = 'Year')


p5 <- ggplot(df7, aes(x = Year, y = value, group = variable)) +
  geom_line(data=subset(df7, variable == "South"),colour="blue",size=0.5) + 
  geom_line(data=subset(df8, variable == "West"),colour="red",size=0.5) + 
  ylab("Detrended MIC") + xlab("Year") +
  scale_x_continuous(breaks = seq(1950, 2010, by=10), limits = c(1950, 2010),expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0.85, 1.1, by=0.05), limits = c(0.85, 1.1), expand = c(0,0)) +
  theme(axis.ticks.length=unit(-0.25, "cm"), axis.ticks.margin=unit(0.5, "cm"), 
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        axis.text.x = element_text(colour="black"),
      #  axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.title.y = element_text(vjust=2),
        axis.text.y = element_text(colour="black"),
        axis.line = element_line(colour = "black"),
        axis.text=element_text(size=10),
        axis.ticks = element_line(colour = "black"),
        axis.title=element_text(size=10))

ggsave(file="Synchrony_new.png", p5, width = 20, 
       height = 15, 
       units = "cm", dpi = 300) #saves g
