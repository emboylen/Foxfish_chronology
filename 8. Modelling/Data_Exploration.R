# Data exploration Foxfish

########################################################################
# Initialize
setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData") # laptop
# setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
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
#source("HighstatLibV6.R")

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

##############################################
#C Normality

par(mfrow=c(1,2))

#png("C_Normality.png", width=1280,height=738)
qqnorm(ReSouth$value, main = "South Normal QQ plot")
qqnorm(ReWest$value, main = "West Normal QQ plot")

##############################################
#D Zero inflation
sum(ReSouth$variable == 0)
sum(ReSouth$variable == 0) / nrow(ReSouth)
sum(ReWest$variable == 0)
sum(ReWest$variable == 0) / nrow(ReWest)

##############################################
#E Collinearity X
# Only measured one response variable (growth incrmenets)

# is there a correlation between the FSL and the temperautre (testing on the west coast data)
x <- FSLdat[33:(nrow(FSLdat)-1),]
x <- x$Annual
y <- WestSST
y <- y$Annual

par(mfrow=c(1,1))
png("E_collinearity.png", width=1280,height=738)
plot(y~x, main = "West Coast",
     xlab = "Mean Annual FSL",
     ylab = "Mean Annual SST ")
library(ggplot2)
M1 <- lm(y~x)
abline(M1)
summary(M1)

dev.off()

# Call:
#   lm(formula = y ~ x)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -0.90794 -0.38005 -0.01868  0.31817  0.99144 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  18.7957     0.5756  32.654   <2e-16 ***
#   x             1.7898     0.7971   2.245   0.0275 *  
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 0.4461 on 81 degrees of freedom
# Multiple R-squared:  0.0586,  Adjusted R-squared:  0.04698 
# F-statistic: 5.042 on 1 and 81 DF,  p-value: 0.02747


##############################################
#F Relationships Y vs X

# variables: mean annual FSL, annual SST, summer SST, financial year SST, jan:dec SST
# #Plot every covariate versus Y

Smean <- rowMeans(SFoxPC[,-1],na.rm=T)
Wmean <- rowMeans(WFoxPC[,-1],na.rm=T)

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


