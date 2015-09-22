##########################
### Increment Analysis ###
##########################

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


#### Plotting detrended data
### Mean Line  ###
##################

# Raw

MICs <- read.csv("Master_SouthFOX.csv")
colnames(MICs) <- c("Year", "South", "Depth")

NewSouthFOX <- merge(MICs[,-3], SouthFOX, by = "Year")
df7 <- melt(NewSouthFOX, id.vars = 'Year')

s <- ggplot(df7, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ylab(expression(paste("Increment width (", mu, "m)"))) +
  geom_line(data=subset(df7, variable == "South"),colour="blue",size=0.8) +
  scale_x_continuous(breaks = seq(1950, 2010, by=10), limits = c(1950, 2010), labels = rep("", 7),expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 80, by=10), limits = c(0,80), expand = c(0,0)) +
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

MICw <- read.csv("Master_WestFOX.csv")
colnames(MICw) <- c("Year", "West", "Depth")

NewWestFOX <- merge(MICw[,-3], WestFOX, by = "Year")
df8 <- melt(NewWestFOX, id.vars = 'Year')

w <- ggplot(df8, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ylab(expression(paste("Increment width (", mu, "m)"))) +
  geom_line(data=subset(df8, variable == "West"),colour="red",size=0.8) +
  scale_x_continuous(breaks = seq(1950, 2010, by=10), limits = c(1950, 2010),expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 80, by=10), limits = c(0,80), expand = c(0,0)) +
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


# Splines
MICs <- read.csv("MIC_spline_South.csv")
colnames(MICs) <- c("Year", "South", "Depth")

NewSouthFOX <- merge(MICs[,-3], SplSouthFOXDtr, by = "Year")
df7 <- melt(NewSouthFOX, id.vars = 'Year')

p1 <- ggplot(df7, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ylab("") +
  geom_line(data=subset(df7, variable == "South"),colour="blue",size=0.8) +
  scale_x_continuous(breaks = seq(1950, 2010, by=10), limits = c(1950, 2010), labels = rep("", 7),expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 2, by=0.5), limits = c(0,2), expand = c(0,0)) +
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


MICw <- read.csv("MIC_spline_West.csv")
colnames(MICw) <- c("Year", "West", "Depth")

NewWestFOX <- merge(MICw[,-3], SplWestFOXDtr, by = "Year")
df8 <- melt(NewWestFOX, id.vars = 'Year')

p2 <- ggplot(df8, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ylab("") +
  geom_line(data=subset(df8, variable == "West"),colour="red",size=0.8) +
  scale_x_continuous(breaks = seq(1950, 2010, by=10), limits = c(1950, 2010),expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 2, by=0.5), limits = c(0,2), expand = c(0,0)) +
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


# Neg Exp
MICs <- read.csv("MIC_NegEXP_South.csv")
colnames(MICs) <- c("Year", "South", "Depth")

NewSouthFOX <- merge(MICs[,-3], NegSouthFOXDtr, by = "Year")
df7 <- melt(NewSouthFOX, id.vars = 'Year')

p3 <- ggplot(df7, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ylab("") +
  geom_line(data=subset(df7, variable == "South"),colour="blue",size=0.8) +
  scale_x_continuous(breaks = seq(1950, 2010, by=10), limits = c(1950, 2010), labels = rep("", 7),expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 3.5, by=0.5), limits = c(0,3.5), expand = c(0,0)) +
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


MICw <- read.csv("MIC_NegEXP_West.csv")
colnames(MICw) <- c("Year", "West", "Depth")

NewWestFOX <- merge(MICw[,-3], NegWestFOXDtr, by = "Year")
df8 <- melt(NewWestFOX, id.vars = 'Year')

p4 <- ggplot(df8, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ylab("") +
  geom_line(data=subset(df8, variable == "West"),colour="red",size=0.8) +
  scale_x_continuous(breaks = seq(1950, 2010, by=10), limits = c(1950, 2010),expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 3.5, by=0.5), limits = c(0,3.5), expand = c(0,0)) +
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


# Double
MICs <- read.csv("MIC_Dbl_South.csv")
colnames(MICs) <- c("Year", "South", "Depth")

NewSouthFOX <- merge(MICs[,-3], DblSouthFOXDtr, by = "Year")
df7 <- melt(NewSouthFOX, id.vars = 'Year')

p5 <- ggplot(df7, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ylab("") +
  geom_line(data=subset(df7, variable == "South"),colour="blue",size=0.8) +
  scale_x_continuous(breaks = seq(1950, 2010, by=10), limits = c(1950, 2010), labels = rep("", 7),expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 2, by=0.5), limits = c(0,2), expand = c(0,0)) +
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



MICw <- read.csv("MIC_Dbl_West.csv")
colnames(MICw) <- c("Year", "West", "Depth")

NewWestFOX <- merge(MICw[,-3], DblWestFOXDtr, by = "Year")
df8 <- melt(NewWestFOX, id.vars = 'Year')

p6 <- ggplot(df8, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ylab("") +
  geom_line(data=subset(df8, variable == "West"),colour="red",size=0.8) +
  scale_x_continuous(breaks = seq(1950, 2010, by=10), limits = c(1950, 2010), expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 2.0, by=0.5), limits = c(0,2), expand = c(0,0)) +
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


grid.arrange(s, p3, p1, p5, w, p4, p2, p6, ncol=4)


g <- arrangeGrob(s, p3, p1, p5, w, p4, p2, p6, ncol=4) #generates g

ggsave(file="Detrending_Comparison_Final.png", g,  width = 60, 
       height = 30, 
       units = "cm", dpi = 300) #saves g