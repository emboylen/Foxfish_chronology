# Part 1:
# simple correlations


########################################################################
# Raw Data
########################################################################

########################################################################
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace
list.files()


########################################################################
### Detrended data ###
########################################################################
# Initialize
# Read in mean chronologies
West <- read.csv("MIC_Dbl_West.csv")
South <- read.csv("MIC_Dbl_South.csv")
# Environmental data
WestSST <- read.csv("West_SST_comb.csv")
SouthSST <- read.csv("South_SST_comb.csv")
# Reverse the order of years in SST data
WestSST <- WestSST[with(WestSST, order(-Year)), ]
SouthSST <- SouthSST[with(SouthSST, order(-Year)), ]

# Leeuwin current
FSL <- read.csv('FSL_comb.csv')
# Reverse the order of years in FSL data
FSL <- FSL[with(FSL, order(-Year)), ]
colnames(FSL) <- paste("FSL", colnames(FSL), sep = "_")

# Create some data frames where SST and master chronologies line up

Data_West <- data.frame(West, WestSST[10:60,], FSL[9:59,], row.names = NULL)
Data_South <- data.frame(South, SouthSST[9:60,], FSL[8:59,],  row.names=NULL)
# check that the years line up

########################################################################
# Correlations
########################################################################

# 
library(lattice)  #For fancy multipanel graphs
source("HighstatLibV6.R")

# West data
MyVar <- c("xxxstd","Annual", "Summer", "Autumn", "Winter", "Spring")
MyVar2 <- c("xxxstd", "FSL_Annual", "FSL_Summer", "FSL_Autumn", "FSL_Winter", "FSL_Spring")
pairs(Data_West[,MyVar],lower.panel = panel.cor)
pairs(Data_West[,MyVar2],lower.panel = panel.cor)
cor(Data_West[,MyVar])
 

# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_West))

res <- rcorr(as.matrix(Data_West))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/West_dat.csv")

# South data
MyVar <- c("xxxstd","Annual", "Summer", "Autumn", "Winter", "Spring")
MyVar2 <- c("xxxstd", "FSL_Annual", "FSL_Summer", "FSL_Autumn", "FSL_Winter", "FSL_Spring")
pairs(Data_South[,MyVar],lower.panel = panel.cor)
pairs(Data_South[,MyVar2],lower.panel = panel.cor)
cor(Data_South[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_South))

res <- rcorr(as.matrix(Data_South))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/South_dat.csv")


###################
# Monthly levels
###
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace

# Read in mean chronologies
West <- read.csv("MIC_Dbl_West.csv")
South <- read.csv("MIC_Dbl_South.csv")
# Environmental data
# Environmental data
WestSST <- read.csv("SST_West_Months.csv")
SouthSST <- read.csv("SST_South_Months.csv")
# Reverse the order of years in SST data
WestSST <- WestSST[with(WestSST, order(-Year)), ]
SouthSST <- SouthSST[with(SouthSST, order(-Year)), ]

# Leeuwin current
FSL <- read.csv('FSL_months.csv')
# Reverse the order of years in FSL data
FSL <- FSL[with(FSL, order(-X)), ]
colnames(FSL) <- paste("FSL", colnames(FSL), sep = "_")

# Create some data frames where SST and master chronologies line up

# Create some data frames where SST and master chronologies line up

Data_West <- data.frame(West, WestSST[10:60,], FSL[9:59,], row.names = NULL)
Data_South <- data.frame(South, SouthSST[9:60,], FSL[8:59,],  row.names=NULL)

# check that the years line up

########################################################################
# Correlations
########################################################################

# 
library(lattice)  #For fancy multipanel graphs
source("HighstatLibV6.R")

# West data
MyVar <- c("xxxstd", month.abb)
MyVar2 <- c("xxxstd", month.abb)
pairs(Data_West[,MyVar],lower.panel = panel.cor)
pairs(Data_West[,MyVar2],lower.panel = panel.cor)
cor(Data_West[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_West))

res <- rcorr(as.matrix(Data_West))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/West_months.csv")

# South data
MyVar <- c("xxxstd", month.abb)
MyVar2 <- c("xxxstd", month.abb)
pairs(Data_South[,MyVar],lower.panel = panel.cor)
pairs(Data_South[,MyVar2],lower.panel = panel.cor)
cor(Data_South[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_South))


res <- rcorr(as.matrix(Data_South))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/South_months.csv")



###################
# Financial calender
# Checking that the relationship is linear or not
###
# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData/Analysis") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis") # pc
# Read in csv files
rm(list=ls()) # clears whole workspace

# Read in mean chronologies
West <- read.csv("MIC_Dbl_West.csv")
South <- read.csv("MIC_Dbl_South.csv")
# Environmental data
WestSST <- read.csv("Financial_SST_West.csv")
SouthSST <- read.csv("Financial_SST_South.csv")
# Reverse the order of years in SST data
WestSST <- WestSST[with(WestSST, order(-Years)), ]
SouthSST <- SouthSST[with(SouthSST, order(-Years)), ]

# Leeuwin current
FSL <- read.csv("Financial_FSL.csv")
# Reverse the order of years in FSL data
FSL <- FSL[with(FSL, order(-Years)), ]
colnames(FSL) <- paste("FSL", colnames(FSL), sep = "_")

# Create some data frames where SST and master chronologies line up

Data_West <- data.frame(West, WestSST[10:60,], FSL[9:59,], row.names = NULL)
Data_South <- data.frame(South, SouthSST[9:60,], FSL[8:59,],  row.names=NULL)

# check that the years line up

# check that the years line up

########################################################################
# Correlations
########################################################################

# 
library(lattice)  #For fancy multipanel graphs
source("HighstatLibV6.R")

# West data
MyVar <- c("xxxstd", "Month")
MyVar2 <- c("xxxstd", "Month")
pairs(Data_West[,MyVar],lower.panel = panel.cor)
pairs(Data_West[,MyVar2],lower.panel = panel.cor)
cor(Data_West[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_West))


res <- rcorr(as.matrix(Data_West))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/West_Fin.csv")


# South data
MyVar <- c("xxxstd", month.abb)
MyVar2 <- c("xxxstd", month.abb)
pairs(Data_South[,MyVar],lower.panel = panel.cor)
pairs(Data_South[,MyVar2],lower.panel = panel.cor)
cor(Data_South[,MyVar])


# Correlations with significance levels
library(Hmisc)
#Data_West is a data frame 
rcorr(as.matrix(Data_South))


res <- rcorr(as.matrix(Data_South))
P <- res[[3]] ; P <- P[,2]
r <- res[[1]] ; r <- r[,2]
dat <- cbind(P,r)
write.csv(dat, "C:/Users/User/Google Drive/Honours/Results/IncrementData/Analysis/Correlations/South_Fin.csv")


##################################
### Making the presentation plot

colnames(Data_South)[1] <- "Year"
colnames(Data_West)[1] <- "Year"

library(ggplot2)
library(gridExtra)

dat <- merge(Data_South, Data_West, by = "Year")
S <- data.frame(dat$xxxstd.x, dat$AnnEsts.x)
S$Region <- "South"
colnames(S) <- c("OtoWidth", "SST", "Region")
W <- data.frame(dat$xxxstd.y, dat$AnnEsts.y)
W$Region <- "West"
colnames(W) <- c("OtoWidth", "SST", "Region")
newdat <- rbind(S,W)

p1 <- ggplot(newdat, aes(x = SST, y = OtoWidth, colour = Region)) +
  geom_point() + stat_smooth(method = "lm", se=F) +
  scale_color_manual(values=c("Blue", "Red")) +
  labs(x = expression("Sea surface temperature (" *
                        degree * "C)"), y = "") + 
  scale_x_continuous(limits = c(17, 21.5), breaks = seq(17, 21.5, by=0.5), expand = c(0,0)) +
  scale_y_continuous(limits = c(0.85, 1.1),breaks = seq(0.8, 1.1, by=0.05), expand = c(0,0)) +
  ylab("MIC") +
  theme(axis.ticks.length=unit(-0.25, "cm"), axis.ticks.margin=unit(0.5, "cm"), 
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text.x = element_text(colour="black"),
#         axis.title.x = element_blank(),
        legend.position="none",
        axis.text.x = element_blank(),
        axis.title.y = element_text(vjust=2),
        axis.text.y = element_text(colour="black"),
        axis.line = element_line(colour = "black"),
        axis.text=element_text(size=12),
        axis.ticks = element_line(colour = "black"),
        axis.title=element_text(size=14))

p1 <- p1 + annotate("text", x = 17.125, y = 1.075, label = "a)")


mods <- lm(data = Data_South, xxxstd ~ AnnEsts)
summary(mods)
modw <- lm(data = Data_West, xxxstd ~ AnnEsts)
summary(modw)

S <- data.frame(dat$xxxstd.x, dat$FSL_AnnEsts.x)
S$Region <- "South"
colnames(S) <- c("OtoWidth", "FSL", "Region")
W <- data.frame(dat$xxxstd.y, dat$FSL_AnnEsts.y)
W$Region <- "West"
colnames(W) <- c("OtoWidth", "FSL", "Region")
newdat <- rbind(S,W)

p2 <- ggplot(newdat, aes(x = FSL, y = OtoWidth, colour = Region)) +
  geom_point() + stat_smooth(method = "lm", se=F) +
  scale_color_manual(values=c("Blue", "Red")) +
  labs(x = "Fremantle sea level (cm)", y = "") + 
  ylab("MIC") +
  scale_x_continuous(limits = c(0.64, 0.90), breaks = seq(0.64, 0.9, by=0.02), expand = c(0,0)) +
  scale_y_continuous(limits = c(0.85, 1.1),breaks = seq(0.8, 1.1, by=0.05), expand = c(0,0)) +
  theme(axis.ticks.length=unit(-0.25, "cm"), axis.ticks.margin=unit(0.5, "cm"), 
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text.x = element_text(colour="black"),
        #         axis.title.x = element_blank(),
        legend.position="none",
        axis.text.x = element_blank(),
        axis.title.y = element_text(vjust=2),
        axis.text.y = element_text(colour="black"),
        axis.line = element_line(colour = "black"),
        axis.ticks = element_line(colour = "black"),
        axis.text=element_text(size=12),
        axis.title=element_text(size=14))

p2 <- p2 + annotate("text", x = 0.65, y = 1.075, label = "b)")

grid.arrange(p1, p2, ncol=1)


g <- arrangeGrob(p1, p2, ncol=1) #generates g
ggsave(g, file="NewCorrelationSumm.png", width = 30, height = 30, units = "cm", dpi = 300) #saves g



mods <- lm(data = Data_South, xxxstd ~ FSL_AnnEsts)
summary(mods)
modw <- lm(data = Data_West, xxxstd ~ FSL_AnnEsts)
summary(modw)



dat <- merge(Data_South, Data_West, by = "Year")
S1 <- data.frame(dat$xxxstd.x, dat$FSL_SummerDat.x)
colnames(S1) <- c("OtoWidth", "FSLSummer")

W1 <- data.frame(dat$xxxstd.y, dat$SummerDat.y)
colnames(W1) <- c("OtoWidth", "SSTSummer")


p3 <- ggplot(S1, aes(x = FSLSummer, y = OtoWidth)) +
  geom_point() + stat_smooth(method = "lm", se=F) +
  #scale_color_manual(values=c("Blue", "Red")) +
  labs(x = "Fremantle sea level (cm)", y = "") + 
  scale_x_continuous(limits = c(0.55, 0.90), breaks = seq(0.55, 0.9, by=0.05), expand = c(0,0)) +
    scale_y_continuous(limits = c(0.85, 1.1),breaks = seq(0.8, 1.1, by=0.05), expand = c(0,0)) +
  ylab("MIC") +
  theme(axis.ticks.length=unit(-0.25, "cm"), axis.ticks.margin=unit(0.5, "cm"), 
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text.x = element_text(colour="black"),
        #         axis.title.x = element_blank(),
        legend.position="none",
        axis.text.x = element_blank(),
        axis.title.y = element_text(vjust=2),
        axis.text.y = element_text(colour="black"),
        axis.line = element_line(colour = "black"),
        axis.text=element_text(size=12),
        axis.ticks = element_line(colour = "black"),
        axis.title=element_text(size=14))

p3 <- p3 + annotate("text", x = 0.565, y = 1.075, label = "a)")


p4 <- ggplot(W1, aes(x = SSTSummer, y = OtoWidth)) +
  geom_point() + stat_smooth(method = "lm", se=F, colour="red") +
  scale_color_manual(values=c("Blue", "Red")) +
  labs(x = expression("Sea surface temperature (" *
                        degree * "C)"), y = "") + 
  ylab("MIC") +
  scale_x_continuous(limits = c(19.5, 22), breaks = seq(19.5, 22, by=0.5), expand = c(0,0)) +
  scale_y_continuous(limits = c(0.85, 1.1),breaks = seq(0.8, 1.1, by=0.05), expand = c(0,0)) +
  theme(axis.ticks.length=unit(-0.25, "cm"), axis.ticks.margin=unit(0.5, "cm"), 
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text.x = element_text(colour="black"),
        #         axis.title.x = element_blank(),
        legend.position="none",
        axis.text.x = element_blank(),
        axis.title.y = element_text(vjust=2),
        axis.text.y = element_text(colour="black"),
        axis.line = element_line(colour = "black"),
        axis.ticks = element_line(colour = "black"),
        axis.text=element_text(size=12),
        axis.title=element_text(size=14))

p4 <- p4 + annotate("text", x = 19.6, y = 1.075, label = "b)")

grid.arrange(p3, p4, ncol=1)


g <- arrangeGrob(p3, p4, ncol=1) #generates g
ggsave(g, file="MostSig_NewCorrelationSumm.png", width = 30, height = 30, units = "cm", dpi = 300) #saves g

