# Trying to figure the financial year variables

# Initialize
setwd("C:/Users/User/Google Drive/Honours/Results/ENV/FSL") # pc
# setwd("C:/Users/Ellen/Google Drive/Honours/Results/ENV") # laptop

rm(list=ls()) # clears whole workspace
list.files()

FSL <- read.csv("FSL.csv")
Data <- data.frame(FSL$Mth, FSL$Year, FSL$Mean)
colnames(Data) = c("Month", "Year", "Mean")
# Add in date variable
Data$Date <- paste(1, month.abb[Data$Month], Data$Year, sep="" )
Data$Date <- as.Date(Data$Date, format = "%d%b%Y")
Data$Month <- month.abb[Data$Month]
colnames(Data)[colnames(Data) == 'Mean'] <- 'value'


MainFunction <- function(dat) {
  dat <- dat[order(dat$Year),]
  years <- sort(unique(dat$Year))
  AllThere <- prod(seq(years[1], years[length(years)])  == years) # any years missing?
  if (AllThere != 1) stop("Years missing?")
  
  GetAnnualFunction <- function(Year, dat, frstMonth="Jul", lstMonth="Jun") {
    frst <- which(dat$Year == Year & dat$Month==frstMonth)
    last <- which(dat$Year == (Year+1) & dat$Month==lstMonth)
    Subset <- dat[frst:last,]
    return(mean(dat[frst:last,]$value)) # make sure your value are named this!!!!
  }
  
  AnnualEsts <- NULL
  # NYear <- length(Years)
  # for (X in 1:(NYears-1) {
  # AnnualEsts[X] <-  GetAnnualFunction(years[X], dat)
  # }
  
  for (X in seq_along(years)[-length(years)]) AnnualEsts[X] <-  GetAnnualFunction(years[X], dat)
  AnnualEsts <- data.frame(Years= years, AnnEsts=c(AnnualEsts, NA)) # Can't do last year because only have 1/2 year of data
  
  # Get Seasons
  Summ = c("Jan", "Feb", "Dec")
  Autu = c("Mar", "Apr", "May")
  Wint = c("Jun","Jul", "Aug")
  Spri = c("Sep", "Oct", "Nov")
  
  # Start with Autumn because that is first complete season that we have
  NewDat <- dat[!(dat$Year == years[1] & (dat$Month == "Jan" | dat$Month == "Feb" )),] # Get rid of first two month in first year
  
  
  getSeason_notSummer <- function(Dat, Season) {
    Begin <- which(NewDat$Month == Season[1])
    saveMean <- saveYr <- NULL
    for (X in seq_along(Begin)) {
      saveMean[X] <- mean(NewDat[Begin[X]:(Begin[X]+2),]$value)
      saveYr[X] <- min(NewDat[Begin[X]:(Begin[X]+2),]$Year)
    }
    output <- saveMean
    if (min(saveYr > years[1])) output <- c(NA, output)
    return(output)
  }
  
  getSeason_Summer <- function(Dat, Season) {
    Begin <- which(NewDat$Month == Season[1])
    saveMean <- saveYr <- NULL
    for (X in seq_along(Begin)) {
      thisYr <- NewDat[Begin[X]:(Begin[X]+1),]
      lastYr <- NewDat[Begin[X]-1,]
      saveMean[X] <- mean(c(thisYr$value, lastYr$value))
      saveYr[X] <- min(NewDat[Begin[X]:(Begin[X]+2),]$Year)
    }
    output <- saveMean
    if (min(saveYr > years[1])) output <- c(NA, output)
    return(output)
  }
  
  getSeason_Spring <- function(Dat, Season) {
    Begin <- which(NewDat$Month == Season[1])
    Begin <- Begin[-1]
    saveMean <- saveYr <- NULL
    for (X in seq_along(Begin)) {
      thisYr <- NewDat[Begin[X]:(Begin[X]+2),]
      saveMean[X] <- mean(thisYr$value)
      saveYr[X] <- min(NewDat[Begin[X]:(Begin[X]+2),]$Year+1)
    }
    output <- saveMean
    # if (min(saveYr) > years[1]) output <- c(NA, output)
    return(output)
  }
  
  SummerDat <- getSeason_Summer(NewDat, Summ) 
  AutumnDat <- getSeason_notSummer(NewDat, Autu) 
  # WinternDat <- getSeason_notSummer(NewDat, Wint) 
  SpringDat <- c(getSeason_Spring(NewDat, Spri), NA)
  
  
  return(data.frame(AnnualEsts, SummerDat, AutumnDat, SpringDat))
  
}


FSLData <- MainFunction(Data)



# write to .csv
write.csv(FSLData, file = "Financial_FSL.csv", row.names=FALSE)
