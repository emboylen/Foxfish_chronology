# ##########################
# ### Increment Analysis ###
# ##########################
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


png("RawIncs_Fox.png", width=600, height=900)
grid.arrange(p1, p2, ncol=1)
dev.off()


##################
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


png("RawIncs_Mean_Fox.png", width=600, height=900)
grid.arrange(p7, p8, ncol=1)
dev.off()

png("RawIncs_Comb_Fox.png", width=600, height=900)
grid.arrange(p1,p7, p2, p8, ncol=1)
dev.off()
