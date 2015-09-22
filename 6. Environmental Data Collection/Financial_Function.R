# Trying to figure the financial year variables

# Initialize
setwd("C:/Users/User/Google Drive/Honours/Results/ENV") # pc
rm(list=ls()) # clears whole workspace
list.files()

Wdat <- read.csv("SST_Data_Rotto.csv")
Sdat <- read.csv("SST_Data_Albany1.csv")


Westdat <- melt(Wdat, var.name = colnames(Wdat[,-1]))
Westdat$Year <- rep(2013:1931, each=12)
Westdat$Month <- factor(month.abb)
Southdat <- melt(Sdat, var.name= colnames(Sdat[,-1]))
Southdat$Year <- rep(2013:1931, each=12)
Southdat$Month <- factor(month.abb)

months = month.abb
premonths = c("Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
postmonths = c("Jan", "Feb", "Mar", "Apr", "May", "Jun")

FinAnnual <- function(Dat) {
  
  AnnualMeans <- for #each Year find  the mean(Value)
  for (X in 1:nrow(myDat)) {}
  
  if (Year = [i]) {
    Month == premonths #then Year = Year -1
  } else { 
    Month == postmonths #then Year = Year
  }
  
  # Find the mean of the financial year 
  # and return the mean, continue onto the next year
  result <- cbind(AnnualMeans, Dat[Year])
  return(result)
}

FinSeason <- function(Dat) {
  Summ = c("Jan", "Feb", "Dec")
  Autu = c("Mar", "Apr", "May")
  Wint = c("Jun","Jul", "Aug")
  Spri = c("Sep", "Oct", "Nov")
  
  if
  Month == premonths then Year = Year -1
  if 
  Month == postmonths, then Year = Year
  
  # Find the mean of each season variable, using financial year calender, 
  #return the mean, continue onto the next year
}

# WAnnual <- FinAnnual(Westdat)
# SAnnual <- FinAnnual(Southdat)
# WSeason <- FinSeason(Westdat)
# WAnnual <- FinSeason(Southdat)

# # make a data.frame
# WSSTdat <- data.frame(WAnnual, WSeasons, row.names=NULL)
# colnames(WNextDat) <- c("Year","Annual", "Summer", "Autumn", "Winter", "Spring")
# # write to .csv
# write.csv(WNextDat, file = "West_SST_comb.csv", row.names=FALSE)
# 
# # make a data.frame
# SSSTdat <- data.frame(SAnnual, SSeasons, row.names=NULL)
# colnames(SNextDat) <- c("Year","Annual", "Summer", "Autumn", "Winter", "Spring")

# write to .csv
# write.csv(SNextDat, file = "South_SST_comb.csv", row.names=FALSE)

# End result
# > head(SNextDat)
# Year   Annual   Summer   Autumn   Winter   Spring
# 1 1931 17.22583 18.74333 18.38333 15.77000 16.00667
# 2 1932 17.63417 18.85667 19.25000 16.51667 15.91333
# 3 1933 17.46667 18.60333 18.78667 16.43000 16.04667
# 4 1934 17.68417 19.23333 18.89667 16.59333 16.01333
# 5 1935 17.24750 18.44667 18.59667 16.18333 15.76333
# 6 1936 17.48250 18.55667 18.76667 16.27000 16.33667