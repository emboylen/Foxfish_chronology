# ##################
# ### Detrending ###
# ##################
# 
# ##################################
# ### Run: Initialize_Incs_Fox.R ###
# ##################################
# 
#
##################
#### Plotting ####
# Raw Increments #
##################

library(ggplot2)
library(reshape2)
library(gridExtra)

df1 <- melt(SouthFOX, id.vars = 'Year')
p1 <- ggplot(df1, aes(x = Year, y = value, group = variable)) +
  geom_line() + theme_classic() + theme(legend.position="none") +
  ggtitle("South Coast Fox Fish") +
  ylab("Increment Width (um)")

df2 <- melt(WFoxEB, id.vars = 'Year')
p2 <- ggplot(df2, aes(x = Year, y = value, group = variable)) +
  geom_line() + theme_classic() + theme(legend.position="none") +
  ggtitle("West Coast Fox Fish")+
  ylab("Increment Width (um)")


##################
### Detrending ###
##################

library(dplR)
# Detrend with a ModNegExp with 
#rigidity parameter equal to 67% of series length

SouthFOXDtr = detrend(SouthFOX[,-1], method = "ModNegExp")
SouthFOXDtr <- data.frame(SouthFOX[,1], SouthFOXDtr)
colnames(SouthFOXDtr) <- c("Year", colnames(SouthFOX[,-1]))

WestFOXDtr = detrend(WFoxEB[,-1], method = "ModNegExp")
WestFOXDtr <- data.frame(WFoxEB[,1], WestFOXDtr)
colnames(WestFOXDtr) <- c("Year", colnames(WFoxEB[,-1]))


# Plotting detrended data

df4 <- melt(SouthFOXDtr, id.vars = 'Year')
p4 <- ggplot(df4, aes(x = Year, y = value, group = variable)) +
  geom_line() + theme_classic() + theme(legend.position="none") +
  ggtitle("Detrended South Coast Fox Fish\nModNegExp")+
  ylab("Standardised Increment Index")

df5 <- melt(WestFOXDtr, id.vars = 'Year')
p5 <- ggplot(df5, aes(x = Year, y = value, group = variable)) +
  geom_line() + theme_classic() + theme(legend.position="none") +
  ggtitle("Detrended West Coast Fox Fish\nModNegExp")+
  ylab("Standardised Increment Index")


png("Dtr_Plots_ModNegExp.png", width=600, height=900)
grid.arrange(p4, p5, p6, ncol=1)
dev.off()

png("Raw_Dtr_Plots_ModNegExp.png", width=1000, height=600)
grid.arrange(p1, p4, p2, p5, p3, p6, ncol=2)
dev.off()


##################
### Plotting with
### Mean Line  ###
##################

##### Raw 
#############

SouthFOXMean <- rowMeans(SouthFOX[,-1], na.rm = TRUE, dims = 1)
NewSouthFOX <- data.frame(SouthFOX, SouthFOXMean)
df7 <- melt(NewSouthFOX, id.vars = 'Year')

p7 <- ggplot(df7, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ggtitle("South Coast Fox Fish")+
  ylab("Increment Width (um)") +
  geom_line(data=subset(df7, 
                        variable == "SouthFOXMean"),colour="black",size=0.8)

WestFOXMean <- rowMeans(WFoxEB[,-1], na.rm = TRUE, dims = 1)
NewWestFOX <- data.frame(WFoxEB, WestFOXMean)
df8 <- melt(NewWestFOX, id.vars = 'Year')

p8 <- ggplot(df8, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ggtitle("West Coast Fox Fish")+
  ylab("Increment Width (um)") +
  geom_line(data=subset(df8, 
                        variable == "WestFOXMean"),colour="black", size=0.8)


##### Detrended 
#############


SouthFOXDtrMean <- rowMeans(SouthFOXDtr[,-1], na.rm = TRUE, dims = 1)
NewSouthFOXDtr <- data.frame(SouthFOXDtr, SouthFOXDtrMean)
df10 <- melt(NewSouthFOXDtr, id.vars = 'Year')

p10 <- ggplot(df10, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ggtitle("Detrended South Coast Fox Fish\nModNegExp")+
  ylab("Increment Width (um)") +
  geom_line(data=subset(df10, 
                        variable == "SouthFOXDtrMean"),colour="black",size=0.8)

WestFOXDtrMean <- rowMeans(WestFOXDtr[,-1], na.rm = TRUE, dims = 1)
NewWestFOXDtr <- data.frame(WestFOXDtr, WestFOXDtrMean)
df11 <- melt(NewWestFOXDtr, id.vars = 'Year')

p11 <- ggplot(df11, aes(x = Year, y = value, group = variable)) +
  geom_line(col = "grey") + theme_classic() + theme(legend.position="none") +
  ggtitle("Detrended West Coast Fox Fish\nModNegExp")+
  ylab("Increment Width (um)") +
  geom_line(data=subset(df11, 
                        variable == "WestFOXDtrMean"),colour="black",size=0.8)


png("Dtr_Plots_Mean_ModNegExp.png", width=600, height=900)
grid.arrange(p10, p11,  ncol=1)
dev.off()

png("Raw_Dtr_Plots_Mean_ModNegExp.png", width=1000, height=600)
grid.arrange(p7, p10, p8, p11, ncol=2)
dev.off()