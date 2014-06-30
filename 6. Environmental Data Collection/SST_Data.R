# Sea surface temperature data extraction 

## Getting monthly sea surface temperatures from 
### http://www.metoffice.gov.uk/hadobs/hadisst/data/download.html

#setwd("C:/Users/Ellen/Google Drive/Honours/Results/SST") # Ellen's laptop
setwd("C:/Users/User/Google Drive/Honours/Results/Env/SST") # ellen's pc

# Functions
#####
ReadDat <- function(fname) {
 s = file.info( fname )$size 
 buf = readChar( fname, s, useBytes=T)
 mydat <- strsplit(buf,"\n",fixed=T,useBytes=T)[[1]]
 
 
 vec <- seq(from=1, by=181, to=length(mydat))
 tempMat <- t(sapply(1:length(mydat[vec]), function (X) {
   xx <- strsplit(mydat[vec][X], split=" ")
    xx[[1]][-which(xx[[1]]=="")][1:3]}))
	
 Day <- as.numeric(tempMat[,1])	
 Month <- as.numeric(tempMat[,2])	
 Year <- as.numeric(tempMat[,3])
 SampMat <- matrix(c(Day, Month, Year), ncol=3)
 colnames(SampMat) <- c("Day", "Month", "Year") 
 
 Years <- unique(Year)
 NYear <- length(Years)
 nSamp <- nrow(SampMat)
 DatList <- rep(list(NA), nSamp)
 
 vec <- seq(from=2, by=181, to=length(mydat))
 for (X in 1:length(vec)) DatList[[X]] <- mydat[vec[X]:(vec[X]+179)] 
 
 tempData <- lapply(DatList, tempFun)
 Output <- NULL
 Output$SampMat <- SampMat
 Output$tempData <- tempData
 return(Output)
}

tempFun <- function(Dat) {
 mat <- matrix(NA, nrow=180, ncol=360)
   for (Y in 1:180) {
     vv <- gregexpr("32768", Dat[Y], fixed=TRUE) 
	 Chk <- length(vv[[1]])
     if (Chk > 1) {
	   temp <- unlist(strsplit(Dat[Y], split="-"))
	   temp <- unlist(strsplit(temp, split=" "))
	   temp <- as.numeric(temp)
	   mat[Y,] <- temp[!is.na(temp)]
	 } else { 
	   temp <- unlist(strsplit(Dat[Y], split=" "))
	   temp <- temp[!temp==""]
	   mat[Y,] <- as.numeric(temp)
	 }
   }
  return(mat/100)
}
 
rotate <- function(x) t(apply(x, 2, rev))

#TempData$SampMat # 

GetRidLand <- function(Dat) {
  Dat[Dat==327.68] <- NA
  return(Dat)
}# Before doing analysis you want to get rid of Land Values of 327.68

# Set up Parameters of sea surface temeprature data
# Long <- 116
# Lat <- 35
Col <- Long + 180
Row <- Lat + 90
# 
# AllYears <- 2003:1931
NTotYears <- length(AllYears)


# Begin analysis on unzipped data

# 2013
fname <- "HadISST1_SST_2013.txt"
TempData <- ReadDat(fname)
NewTempDat <- lapply(TempData$tempData, GetRidLand)


getTemp <- function(dat, Row, Col) return(dat[Row,Col])
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
ttt <- cbind(TempData$SampMat,unlist(tt))

Dat_2013 <- cbind(TempData$SampMat,unlist(tt))

# 2012
fname <- "HadISST1_SST_2012.txt"
TempData <- ReadDat(fname)
NewTempDat <- lapply(TempData$tempData, GetRidLand)


getTemp <- function(dat, Row, Col) return(dat[Row,Col])
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
ttt <- cbind(TempData$SampMat,unlist(tt))

Dat_2012 <- cbind(TempData$SampMat,unlist(tt))

# 2011
fname <- "HadISST1_SST_2011.txt"
TempData <- ReadDat(fname)
NewTempDat <- lapply(TempData$tempData, GetRidLand)


getTemp <- function(dat, Row, Col) return(dat[Row,Col])
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
ttt <- cbind(TempData$SampMat,unlist(tt))

Dat_2011 <- cbind(TempData$SampMat,unlist(tt))

# 2010
fname <- "HadISST1_SST_2010.txt"
TempData <- ReadDat(fname)
NewTempDat <- lapply(TempData$tempData, GetRidLand)


getTemp <- function(dat, Row, Col) return(dat[Row,Col])
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
ttt <- cbind(TempData$SampMat,unlist(tt))

Dat_2010 <- cbind(TempData$SampMat,unlist(tt))

# 2009
fname <- "HadISST1_SST_2009.txt"
TempData <- ReadDat(fname)
NewTempDat <- lapply(TempData$tempData, GetRidLand)


getTemp <- function(dat, Row, Col) return(dat[Row,Col])
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
ttt <- cbind(TempData$SampMat,unlist(tt))

Dat_2009 <- cbind(TempData$SampMat,unlist(tt))

# 2008
fname <- "HadISST1_SST_2008.txt"
TempData <- ReadDat(fname)
NewTempDat <- lapply(TempData$tempData, GetRidLand)


getTemp <- function(dat, Row, Col) return(dat[Row,Col])
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
ttt <- cbind(TempData$SampMat,unlist(tt))

Dat_2008 <- cbind(TempData$SampMat,unlist(tt))

# 2007
fname <- "HadISST1_SST_2007.txt"
TempData <- ReadDat(fname)
NewTempDat <- lapply(TempData$tempData, GetRidLand)


getTemp <- function(dat, Row, Col) return(dat[Row,Col])
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
ttt <- cbind(TempData$SampMat,unlist(tt))

Dat_2007 <- cbind(TempData$SampMat,unlist(tt))

# 2006
fname <- "HadISST1_SST_2006.txt"
TempData <- ReadDat(fname)
NewTempDat <- lapply(TempData$tempData, GetRidLand)


getTemp <- function(dat, Row, Col) return(dat[Row,Col])
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
ttt <- cbind(TempData$SampMat,unlist(tt))

Dat_2006 <- cbind(TempData$SampMat,unlist(tt))


# 2005
fname <- "HadISST1_SST_2005.txt"
TempData <- ReadDat(fname)
NewTempDat <- lapply(TempData$tempData, GetRidLand)


getTemp <- function(dat, Row, Col) return(dat[Row,Col])
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
ttt <- cbind(TempData$SampMat,unlist(tt))

Dat_2005 <- cbind(TempData$SampMat,unlist(tt))

# 2004
fname <- "HadISST1_SST_2004.txt"
TempData <- ReadDat(fname)
NewTempDat <- lapply(TempData$tempData, GetRidLand)


getTemp <- function(dat, Row, Col) return(dat[Row,Col])
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
ttt <- cbind(TempData$SampMat,unlist(tt))

Dat_2004 <- cbind(TempData$SampMat,unlist(tt))

# 1991-2003
fname <- "HadISST1_SST_1991-2003.txt"
TempData <- ReadDat(fname)
NewTempDat <- lapply(TempData$tempData, GetRidLand)


getTemp <- function(dat, Row, Col) return(dat[Row,Col])
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
ttt <- cbind(TempData$SampMat,unlist(tt))

Dat_1991_2003 <- cbind(TempData$SampMat,unlist(tt))

# 1961-1990
fname <- "HadISST1_SST_1961-1990.txt"
TempData <- ReadDat(fname) 
NewTempDat <- lapply(TempData$tempData, GetRidLand)
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)
Dat_1961_1990 <- cbind(TempData$SampMat,unlist(tt))

# 1931-1960
fname <- "HadISST1_SST_1931-1960.txt"
TempData <- ReadDat(fname) 
NewTempDat <- lapply(TempData$tempData, GetRidLand)
tt <- lapply(NewTempDat, getTemp, Row=Row, Col=Col)

Dat_1931_1960 <- cbind(TempData$SampMat,unlist(tt))


myDat <- rbind(Dat_2013, Dat_2012, Dat_2011, Dat_2010,Dat_2009, Dat_2008,Dat_2007, 
               Dat_2006, Dat_2005, Dat_2004,Dat_1991_2003, Dat_1961_1990, Dat_1931_1960)


BigMat <- matrix(NA, nrow=12 , ncol=NTotYears)
rownames(BigMat) <- month.abb
colnames(BigMat) <- AllYears

for (X in 1:nrow(myDat)) {
  print(myDat[X,]) 
  month <- myDat[X,2]
  year <- myDat[X,3]
  Col <- (max(AllYears) - year)+1
  BigMat[month, Col] <- myDat[X,4]
}