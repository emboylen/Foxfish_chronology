# Bio data

# Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/Bio data") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/Bio data") # pc
list.files()
dat <- read.csv("Foxfish_dat.csv", header=TRUE)
str(dat)

# Overall foxfish data histogram
hist(dat$Adj.zones, main = "Foxfish Age Structure", xlab = "Age")

#read in my sampled data
So <- read.csv("SouthFoxPC.csv", header=T)
We <- read.csv("WestFoxPC.csv", header=T) 

# get the column names of my data to match in the overall foxfish data
FishIDs <- c(colnames(So[,-1]), colnames(We[,-1]))
FishIDs <- substring(FishIDs, 2) # get rid of X
FishIDs <- substring(FishIDs, 2) # get rid of 0

sub <-  subset(dat, dat$Number %in%  FishIDs) # subset to include only my foxfish samples
# histogram of my sample of foxfish ages
hist(sub$Adj.zones, main = " Chronology Foxfish Age Structure", xlab = "Age")

# Subsetting by region
library(ggplot2)
library(grid)



a <- ggplot(dat, aes(x=Adj.zones)) + geom_histogram(colour = "black", fill = "white", binwidth = 1) + 
  geom_histogram(data = sub,aes(x=Adj.zones), binwidth=1, colour="black",fill = "grey") +
  facet_grid(Region ~ .) + 
  scale_x_continuous(breaks = seq(0, 80, by=10), limits = c(0, 80), expand = c(0,0)) +
  scale_y_continuous(breaks = seq(0, 20, by=5), limits = c(0, 20), expand = c(0,0)) +
  labs(x = "Age", y = "Frequency") +
  theme(axis.ticks.length=unit(-0.25, "cm"), axis.ticks.margin=unit(0.5, "cm"), 
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        axis.text.x = element_text(colour="black"),
        axis.title.x = element_text(hjust=0.5),
        axis.title.y = element_text(vjust=2),
        panel.margin = unit(2, "lines"),
        axis.text.y = element_text(colour="black"),
        axis.line = element_line(colour = "black"),
        axis.text=element_text(size=12),
        axis.title=element_text(size=12),
        axis.ticks = element_line(colour = "black"),
        title = element_text(hjust=-12))



ggsave(file="Biodata_Hist.png", a, width = 15, 
       height = 15, 
       units = "cm", dpi = 300) #saves g


ggplot(dat, aes(x=Adj.zones)) + geom_histogram(colour = "black", fill = "white", binwidth = 1) + 
  geom_histogram(data = sub,aes(x=Adj.zones), binwidth=1, colour="black",fill = "grey") +
  labs(x = "Age", y = "Frequency") +
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

# well all that is great however most of the south coast examples don't have age data so...

South <- sub[sub$Region == "South coast",]
summary(South)
range(South$length)
range(South$Adj.zones)
summary(South$method)
summary(South$sex)
West <- sub[sub$Region == "West coast",]
summary(West)
range(West$length)
range(West$Adj.zones, na.rm=T)
summary(West$method)
summary(West$sex)

# there is a loit of data missing form the South Coast...
write.csv(sub, "SubFoxfishBio.csv")

#############################################
# Length~Age relationship

plot(dat$length~dat$Adj.zones)

newdata <- dat[ which(dat$Adj.zones <=10), ]

plot(newdata$length~newdata$Adj.zones)
mo <- lm(newdata$length~newdata$Adj.zones)
abline(mo)
range(West$Adj.zones, na.rm=T)
range(South$Adj.zones)

write.csv(newdata, "FutureModeling.csv")
