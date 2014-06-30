# Fremantle Sea Level - a procy for Leeuwin current
# from http://www.bom.gov.au/ntc/IDO70000/IDO70000_62230_SLD.txt

# Initialize
setwd("C:/Users/User/Google Drive/Honours/Results/Env/FSL") # ellen's pc
list.files()
FSL <- read.csv("FSL.csv")
Data <- data.frame(FSL$Mth, FSL$Year, FSL$Mean)
colnames(Data) = c("Month", "Year", "Mean")

# Add in date variable
Data$Date <- paste(1, month.abb[Data$Month], Data$Year, sep="" )
Data$Date <- as.Date(Data$Date, format = "%d%b%Y")
Data$Date


# Plot
require(ggplot2)
require(scales)

ggplot(Data, aes(x = Date, y = Mean)) + 
  geom_line() +
  theme_classic() +
  labs(x = "Date", y = "Mean FSL") +
  scale_x_date(labels = date_format("%Y"))

ggplot(Data, aes(x = Date, y = Mean)) + 
  geom_line() +
  theme_classic() +
  labs(x = "Date", y = "Mean FSL") + stat_smooth()
  scale_x_date(labels = date_format("%Y"))
