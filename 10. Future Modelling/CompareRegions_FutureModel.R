#####################################################################
######## Stratify by region

data <- read.csv("Foxfish data.csv")

# Organise all the data into 1 dataframe with region as a factor
x <- data[data$Number %in% names, c(5, 9)]
x$FishID <- x$Number
newdat <- merge(x,dat, by = "FishID")

# Re-create the old model, using the new data frame 
# for easier comparison of models
M1 <- lm(newdat$TL~newdat$OtoSize)
summary(M1)
aov(M1)

# creation of new model with Region as a factor
M2 <- lm(newdat$TL~newdat$OtoSize + factor(newdat$Region))
summary(M2)
aov(M2)

# Run a drop 1 analysis
drop1(M2)

# Compare the models
anova(M1, M2)

at <- ggplot(newdat, aes(x=OtoSize, y= TL, colour=Region)) + geom_point() + theme_classic() + stat_smooth(method = "lm", se=F) + 
  labs(x=expression(paste("Otolith Size (", mu, "m", ")")), y="Fish Length (mm)")
at
