# Data exploration Foxfish

########################################################################
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace
list.files()
SFoxPC <- read.csv("SouthFoxPC.csv")
WFoxPC <- read.csv("WestFoxPC.csv")
library(reshape2)
ReSouth <- melt(SFoxPC, id.vars = "Year")
ReWest <- melt(WFoxPC, id.vars = "Year")
FSLdat <- read.csv("FSL_comb.csv")
SouthSST <- read.csv("South_SST_comb.csv")
WestSST <- read.csv("West_SST_comb.csv")
source("HighstatLibV6.R")
library(lattice)  #For fancy multipanel graphs

########################################################################
#Data exploration
#A Outliers in Y / Outliers in X
#B Homogeneity
#C Normaility
#D Collinearity
#E Relationships Y~X
#F Interactions (is the quality of the data good enough to include them?)
#G Zero inflation Y
#H Independence

########################################################################
# A. Outliers

par(mfrow = c(1, 2))
boxplot(ReSouth$value, 
        main = "South Coast Increment Size")
dotchart(ReSouth$value, 
         xlab = "Range of data", 
         ylab = "Values")
boxplot(ReWest$value, 
        main = "West Coast Increment Size")
dotchart(ReWest$value, 
         xlab = "Range of data", 
         ylab = "Values")

# To make all these plots in a nice grid to assess outliers

SMyVar <- colnames(SFoxPC[,-1])
Mydotplot(SFoxPC[,SMyVar])
WMyVar <- colnames(WFoxPC[,-1])
Mydotplot(WFoxPC[,WMyVar])

#png("eg", width=1280,height=738)


##############################################
#B Homogeneity

# Conditional boxplots
par(mfrow = c(1, 1))

png("B_homogeneity_south.png", width=1280,height=738)
boxplot(SFoxPC[,-1], 
        main = "South Coast")
dev.off()

png("B_homogeneity_west.png", width=1280,height=738)
boxplot(WFoxPC[,-1], 
        main = "West Coast")
dev.off()


M1 <- lm(ReWest$value ~ ReWest$Year)
M2 <- lm(ReSouth$value ~ ReSouth$Year)
E <- resid(M1)
D <- resid(M2)


plot(M1)


# homogeneity
par(mfrow = c(2,2))
plot(M2, which = 1, main = "(a) South Coast")
boxplot(SFoxPC[,-1], main = "(b) South Coast Outliers")
plot(M1, which = 1, main = "(c) West Coast")
boxplot(WFoxPC[,-1], main = "(d) West Coast Outliers")



##############################################
#C Normality

par(mfrow=c(1,2))

#png("C_Normality.png", width=1280,height=738)
qqnorm(ReSouth$value, main = "South Normal QQ plot")
qqnorm(ReWest$value, main = "West Normal QQ plot")



# normality
par(mfrow = c(2,2))
plot(M2, which = 2, main = "(a) South Coast QQ Plot")
hist(D, xlab = "Residuals", main ="(b) South Coast Residuals")
plot(M1, which = 2, main = "(c) West Coast QQ Plot")
hist(E, xlab = "Residuals", main ="(d) West Coast Residuals")

##############################################
#D Zero inflation
sum(ReSouth$variable == 0)
sum(ReSouth$variable == 0) / nrow(ReSouth)
sum(ReWest$variable == 0)
sum(ReWest$variable == 0) / nrow(ReWest)

##############################################
#E Collinearity X
# Only measured one response variable (growth incrmenets)
library(ggplot2)


x <- FSLdat[33:(nrow(FSLdat)-1),]
x <- x$Annual
y <- SouthSST
y <- y$Annual


df7 <- data.frame(x, y)
df7$Region = "South"
colnames(df7) <- c("FSL", "SST", "Region")

x1 <- FSLdat[33:(nrow(FSLdat)-1),]
x1 <- x1$Annual
y1 <- WestSST
y1 <- y1$Annual

df8 <- data.frame(x1, y1)
df8$Region <- "West"
colnames(df8) <- c("FSL", "SST", "Region")

newdat <- rbind(df7, df8)

p1 <- ggplot(newdat, aes(x = FSL, y = SST, colour = Region)) +
  geom_point() + stat_smooth(method = "lm", se=F) +
  scale_color_manual(values=c("Blue", "Red")) +
  labs(y = expression("Sea surface temperature (" *
                        degree * "C)"), x = "Fremantle sea level") + 
  scale_x_continuous(limits = c(0.5, 1), breaks = seq(0.5,1, by=0.1), expand = c(0,0)) +
  scale_y_continuous(limits = c(17,22),breaks = seq(17,22, by=1), expand=c(0,0)) +
  theme(axis.ticks.length=unit(-0.25, "cm"), axis.ticks.margin=unit(0.5, "cm"), 
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text.x = element_text(colour="black"),
        axis.title.x = element_text(size =14),
        legend.position="none",
        axis.text.x = element_blank(),
        axis.title.y = element_text(vjust=2, size = 14),
        axis.text.y = element_text(colour="black"),
        axis.line = element_line(colour = "black"),
        axis.text=element_text(size=12),
        axis.ticks = element_line(colour = "black"),
        axis.title=element_text(size=12))

ggsave(p1, file="Collinearity_redone.png", width = 20, height = 20, units = "cm", dpi = 300) #saves g
##############################################
#F Relationships Y vs X

# variables: mean annual FSL, annual SST, summer SST, financial year SST, jan:dec SST
# #Plot every covariate versus Y

par(mfrow = c(2, 5), mar = c(4, 3, 3, 2))
FSL <- FSLdat[47:nrow(FSLdat),]
SSST <- SouthSST[14:nrow(SouthSST),]
plot(FSL$Annual~Smean, main="South Annual FSL", xlab="Increment Size")
plot(FSL$Summer~Smean, main="South Summer FSL", xlab="Increment Size")
plot(FSL$Autumn~Smean, main="South Autumn FSL", xlab="Increment Size")
plot(FSL$Winter~Smean, main="South Winter FSL", xlab="Increment Size")
plot(FSL$Spring~Smean, main="South Spring FSL", xlab="Increment Size")
plot(SSST$Annual~Smean, main="South Annual SST", xlab="Increment Size")
plot(SSST$Summer~Smean, main="South Summer SST", xlab="Increment Size")
plot(SSST$Autumn~Smean, main="South Autumn SST", xlab="Increment Size")
plot(SSST$Winter~Smean, main="South Winter SST", xlab="Increment Size")
plot(SSST$Spring~Smean, main="South Spring SST", xlab="Increment Size")

# png("E_collinearity.png", width=1280,height=738)

par(mfrow = c(2, 5), mar = c(4, 3, 3, 2))
FSL <- FSLdat[57:nrow(FSLdat),]
WSST <- WestSST[24:nrow(WestSST),]
plot(FSL$Annual~Wmean, main="West Annual FSL", xlab="Increment Size")
plot(FSL$Summer~Wmean, main="West Summer FSL", xlab="Increment Size")
plot(FSL$Autumn~Wmean, main="West Autumn FSL", xlab="Increment Size")
plot(FSL$Winter~Wmean, main="West Winter FSL", xlab="Increment Size")
plot(FSL$Spring~Wmean, main="West Spring FSL", xlab="Increment Size")
plot(WSST$Annual~Wmean, main="West Annual SST", xlab="Increment Size")
plot(WSST$Summer~Wmean, main="West Summer SST", xlab="Increment Size")
plot(WSST$Autumn~Wmean, main="West Autumn SST", xlab="Increment Size")
plot(WSST$Winter~Wmean, main="West Winter SST", xlab="Increment Size")
plot(WSST$Spring~Wmean, main="West Spring SST", xlab="Increment Size")


##############################################
#G Interactions


##############################################
#H Independence
South <- read.csv("Final_South_GAMM.csv") #using detrended chron data
West <- read.csv("Final_West_GAMM.csv") #using detrended chron data
z <- acf(South$OtoWidth)
# Check class of the object
class(z)
# View attributes of the "acf" object
attributes(z)
# Use "acf" attribute to view the first 13 elements (1 = lag at 0)
z$acf
# Get rid of the first element (i.e. lag 0)
z$acf[2:30]
# Plot the autocorrelation function without lag 0
plot(z[2:30])


acf(West$OtoWidth)
x <- acf(West$OtoWidth)
# Check class of the object
class(x)
# View attributes of the "acf" object
attributes(x)
# Use "acf" attribute to view the first 13 elements (1 = lag at 0)
x$acf
# Get rid of the first element (i.e. lag 0)
x$acf[2:30]
# Plot the autocorrelation function without lag 0
plot(x[2:30])

par(mfrow=c(1,2)) #c(bottom, left, top, right)
plot(z[2:30], main = "South Coast")
plot(x[2:30], main = "West Coast")


############
##### Plotting acf with ggplot2
bacf <- acf(South$OtoWidth, plot = F)
bacfdf <- with(bacf, data.frame(lag, acf))

r <- ggplot(data = bacfdf[-1,], mapping = aes(x = lag, y = acf)) +
  geom_hline(aes(yintercept = 0)) +
  geom_hline(yintercept = 0.06, linetype="dotted") +
  labs (x = "Lag (years)", y = "Autocorrelation function") + theme_classic() +
  geom_segment(mapping = aes(xend = lag, yend = 0)) +
  scale_x_continuous(limits = c(0,30), breaks = seq(0,30, by=2), 
                     expand = c(0,0), labels = rep("", 16)) +
  scale_y_continuous(limits = c(0, 0.3),
                     breaks = seq(0, 0.3, by=0.05), expand = c(0,0)) +
  theme(axis.ticks.length=unit(-0.25, "cm"), axis.ticks.margin=unit(0.5, "cm"), 
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text.x = element_text(colour="black"),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.title.y = element_text(vjust=2),
        axis.text.y = element_text(colour="black"),
        axis.line = element_line(colour = "black"),
        axis.text=element_text(size=12),
        axis.title=element_text(size=12))



bacf <- acf(West$OtoWidth, plot = F)
bacfdf <- with(bacf, data.frame(lag, acf))

q <- ggplot(data = bacfdf[-1,], mapping = aes(x = lag, y = acf)) +
  geom_hline(aes(yintercept = 0)) + theme_classic() +
  geom_hline(yintercept = 0.06, linetype="dotted") +
  labs (x = "Lag (years)", y = "Autocorrelation function") +
  geom_segment(mapping = aes(xend = lag, yend = 0)) +
  scale_x_continuous(limits = c(0,30), breaks = seq(0,30, by=2), 
                     expand = c(0,0)) +
  scale_y_continuous(limits = c(0, 0.3),breaks = seq(0, 0.3, by=0.05), 
                     expand = c(0,0)) +
  theme(axis.ticks.length=unit(-0.25, "cm"), axis.ticks.margin=unit(0.5, "cm"), 
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text.x = element_text(colour="black"),
        axis.title.x = element_text(hjust=0.5),
        axis.title.y = element_text(vjust=2),
        axis.text.y = element_text(colour="black"),
        axis.line = element_line(colour = "black"),
        axis.text=element_text(size=12),
        axis.title=element_text(size=12))

grid.arrange(r, q, ncol=1)


g <- arrangeGrob(r, q, ncol=1) #generates g
ggsave(g, file="ACF_redone.png", width = 20,  height = 15, units = "cm", dpi = 300) #saves g

# 
# setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# # Read in csv files
# rm(list=ls()) # clears whole workspace
# 
# # Read in mean chronologies
# WestDtr <- read.csv("Master_WestFOX_Dtr.csv")
# SouthDtr <- read.csv("Master_SouthFOX_Dtr.csv")
# # Environmental data
# WestSST <- read.csv("West_SST_comb.csv")
# SouthSST <- read.csv("South_SST_comb.csv")
# # Reverse the order of years in SST data
# WestSST <- WestSST[with(WestSST, order(-Year)), ]
# SouthSST <- SouthSST[with(SouthSST, order(-Year)), ]
# 
# # Leeuwin current
# FSL <- read.csv('FSL_comb.csv')
# # Reverse the order of years in FSL data
# FSL <- FSL[with(FSL, order(-Year)), ]
# colnames(FSL) <- paste("FSL", colnames(FSL), sep = "_")
# 
# # Create some data frames where SST and master chronologies line up
# 
# Data_West <- data.frame(WestDtr, WestSST[10:59,], FSL[9:58,], row.names = NULL)
# Data_South <- data.frame(SouthDtr, SouthSST[9:61,], FSL[8:60,],  row.names=NULL)
# # check that the years line up
# 
# par(mfrow=c(1,2))
# x <- ts(Data_South$xxxstd)
# acf(x)
# xlag1=lag(x,-1) # Creates a lag 1 of x variable. See note 2
# y=cbind(x,xlag1) # See note 3 below
# ar1fit=lm(y[,1]~y[,2])#Does regression, stores results object named ar1fit
# acf(ar1fit$residuals, xlim=c(1,18)) # ACF of the residuals for lags 1 to 18
# 
# par(mfrow=c(1,2))
# x <- ts(Data_West$xxxstd)
# acf(x)
# xlag1=lag(x,-1) # Creates a lag 1 of x variable. See note 2
# y=cbind(x,xlag1) # See note 3 below
# ar1fit=lm(y[,1]~y[,2])#Does regression, stores results object named ar1fit
# acf(ar1fit$residuals, xlim=c(1,18)) # ACF of the residuals for lags 1 to 18
# 
# par(mfrow=c(1,2))
# x <- ts(na.omit(SFoxPC$X050229))
# acf(x)
# xlag1=lag(x,-1) # Creates a lag 1 of x variable. See note 2
# y=cbind(x,xlag1) # See note 3 below
# ar1fit=lm(y[,1]~y[,2])#Does regression, stores results object named ar1fit
# acf(ar1fit$residuals, xlim=c(1,18)) # ACF of the residuals for lags 1 to 18
