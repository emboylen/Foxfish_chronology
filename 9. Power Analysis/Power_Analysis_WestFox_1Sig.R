#### Part 1 Bio Data

########################
#### Foxfish ####
############

windowsFonts(
  A=windowsFont("Times New Roman")
)
par(family="A")
# Read in biological data
setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Bio Data") # pc
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/Power/Bio Data") # laptop
#list.files()
Data <- read.csv("Foxfish_Biodata_West.csv")
attach(Data)

# Rename parameters
Ages <- Data$Adj.zones
Year <- yy

####################
# Input Parameters #
####################

# Calculate Age-Prob Vector
Nfish <- length(Ages)
Minage <- min(Ages, na.rm=T)
Maxage <- max(Ages, na.rm=T)
AgeVec <- unique(Ages) # Minage:Maxage
AgeVec <- sort(AgeVec[is.na(AgeVec)==FALSE]) # remove NAs
FProb <- prop.table(table(Ages))
AgeDat <- cbind(Age=AgeVec, Prob=FProb)
CutAge <- 5 # Cut-off age where only fish above this age are included in simulation
# ItVec <- 5
# SampVec <- 500

# Calculate Collection Period
NSampYrs <- max(Year) - min(Year)

# Analysis coefficients
rho <- 0.4 # Correlation coefficient. This will need to be modified using a set of values within a range considered feasible based on results of other dendochronologicakl studies. Note that, in the context of the Power Analysis, this is the effect size that we are seeking to detect.
Alpha <- 0.01 # Specified level of signficance

MaxYear <- max(Year)
MinYear <- min(Year)-Maxage
Years <- rev(MinYear:MaxYear) # Years of temperature data. Number of years to simulate data

# Power analysis setup
NumIts <- ItVec # Total number of iterations - more iterations the longer the model takes to run. Test with few and then run with many and go and have coffee while you wait.
SampSizeVec <- seq(from=10, to=SampVec, by=10) # Vector of sample sizes to run the model over
SampSize <- ItVec # This will be varied when the power analysis is run

########################
# Calculate Parameters #
########################

# Read in increment data
setwd("C:/Users/Ellen/Google Drive/Honours/Results/IncrementData")
#list.files()
Incs <- read.csv("SouthFOX.csv")
detach(Data)
attach(Incs)
Dat <- Incs[,2:ncol(Incs)]
LogDat <- apply(Dat, 2, log) # Natural Log of Data

# Find slope and intercept
Getslope <- function(dat) {
  Nyr <- sum(is.na(dat)==FALSE)
  datInx <- which(is.na(dat)==FALSE)
  X <- Years[datInx]
  Y <- dat[datInx]
  LM <- lm(Y~X) 
  
  return(LM$coefficients)
}

SlopeInt <- apply(LogDat, 2, Getslope)

# Standardised Widths
StandWidth <- function(LogDat) {
  inter <- SlopeInt[1]
  slope <- SlopeInt[2]
  datInx <- which(is.na(Dat)==FALSE)
  X <- Years
  stwid <- exp(LogDat-(inter+slope*X))
  
  return(stwid)
}

Stdwidth <- apply(LogDat, 2, StandWidth)

## Year effect and Variation 
fun.stderr <- function(x) {
  sqrt(var(x, na.rm = T) / sum(!is.na(x)))
}
N = rowSums(!is.na(Stdwidth))
Mean = rowMeans(Stdwidth, na.rm = TRUE, dims = 1)
Stdev  = apply(Stdwidth, 1, sd, na.rm=TRUE)
Var = apply(Stdwidth, 1, var, na.rm=TRUE)
SE = apply(Stdwidth, 1, fun.stderr)


# Variability among individuals
SDIndWidth <- max(Stdev, na.rm=T) # Maximum value of SD of individual variation among standardised widths of the growth zones in the individual otoliths to be used
# Year effect
SDYearEff <- sd(Mean) # Mean of the SD of the variation among values of the inter-annual year effect to be used in the power analysis

##################
# Power ANalysis #
##################


DoPlot <- FALSE # Set to FALSE when running the power analysis

PowerAnalysisFunction <- function (SampSize, DoPlot=FALSE) { # You can also add the other parameters as arguments for this function, good practice but doesn't matter right now because they are defined in the GLOBAL scope
  ########################################
  # Simulate Temperature and Year Effect #
  ########################################
  NYears <- length(Years)
  m1 <- 0 # Mean of scaled temperature
  s1 <- 1 # SD of scaled temperature
  m2 <- 1 # Mean of values of inter-annual effect
  s2 <- SDYearEff # SD of the inter-annual year effect 
  
  X <- rnorm(NYears)
  Y <- rnorm(NYears)
  ScaledTemp <- cbind(Years, m1 + s1 * X)
  YearEffect <- cbind(Years, m2 + s2 * (rho * X + sqrt(1- rho^2) * Y))
  
  if (DoPlot) {
    par(mar=c(5,4,4,5)+.1)
    plot(Years, ScaledTemp[,2], type="b", ylim=c(-3,3), ylab="Scaled temperature", xlab="Years")
    par(new=TRUE)
    plot(Years, YearEffect[,2], type="b", col="red",xaxt="n",yaxt="n",xlab="",ylab="")
    axis(4)
    mtext("Year Effect",side=4,line=3)
  }
  
  ######################## 
  # Generate Fish Sample #
  ########################
  
  FishSamp <- matrix(NA, ncol=NYears + 2, nrow=NSampYrs*SampSize) # Initialise empty matrix
  
  CurrYear <- max(Years) # Current Year
  count <- 0
  ind <- 1
  for (xx in 1:NSampYrs) { # Make Column 2 Sampling Years
    FishSamp[ind:(ind+SampSize-1),2] <- rep((CurrYear-count), SampSize)
    count <- count + 1
    ind <- ind + SampSize
  } 
  
  FishSamp[,1] <- sample(AgeVec, size=nrow(FishSamp), replace=TRUE, prob=FProb) # Assign random ages, with probability of each age given from age sample
  
  AssignEffect <- function(Age, SampYear, YearEffect, SDIndWidth) {
    FYears <- seq(SampYear, by=-1, length=Age)
    FYrEff <- YearEffect[match(FYears, YearEffect[,1]),2]
    return(FYrEff + SDIndWidth * rnorm(1))
  }
  
  ind <- 0
  SampInd <- SampSize
  for (xx in 1:nrow(FishSamp)) { # Assign Random Otolith Width to each fish. 
    FAge <- FishSamp[xx,1]
    SampYear <- CurrYear - ind
    if (FAge > CutAge) { 
      colInd <- which(Years == SampYear) + 2
      FishSamp[xx, colInd:(colInd+FAge-1)] <- AssignEffect(FAge, SampYear, YearEffect, SDIndWidth)
    }
    
    if (xx > SampInd) { # counters to make sure data ends up in correct columns
      ind <- ind + 1
      SampInd <- SampInd + SampSize
    }
  }
  
  #######################################
  # Calculate Yearly mean otolith width #
  #######################################
  MeanOtWidth <- apply(FishSamp[,3:ncol(FishSamp)], 2, mean, na.rm=TRUE)
  GotDat <- which(is.nan(MeanOtWidth)==FALSE)
  
  if (DoPlot) {
    par(mar=c(5,4,4,5)+.1)
    plot(ScaledTemp[GotDat,2], MeanOtWidth[GotDat], type="p", ylim=c(0, 1.4))
  }
  
  #######################
  # Do Correlation Test #
  #######################
  CorTest <- cor.test(ScaledTemp[GotDat,2], MeanOtWidth[GotDat])
  PVal <- CorTest$p.value/2
  Corr <- CorTest$estimate
  IsSig <- PVal <= Alpha
  
  
  # Following Norm's calcs - check with above method
  # altCorr <- cor(ScaledTemp[GotDat,2], MeanOtWidth[GotDat])
  # DF <- length(GotDat) - 2
  # tStat <- altCorr * sqrt(DF)/sqrt(1-altCorr^2)
  # pval <- (1 - pt(tStat, DF)) 
  # pval <= Alpha # is significant correlation?
  
  return(IsSig)
}

######################
# Run Power Analysis #
######################

PowerAnalysisFunction(SampSize=10) # Run Single Instance

CountVec <- rep(NA, length(SampSizeVec))

for (SmIt in seq_along(SampSizeVec)) { # Loop over different sample sizes
  CountVec[SmIt] <- sum(sapply(1:NumIts, function (X) PowerAnalysisFunction(SampSize=SampSizeVec[SmIt])))
  print(paste0("Running sample size: ", SampSizeVec[SmIt], " #", SmIt, " of ", length(SampSizeVec)))
}

ProbVec <- CountVec/NumIts

# plot(SampSizeVec, ProbVec, ylim=c(0,max(ProbVec*1.1)), type="l", lwd=2, xlab="Annual sample size", ylab="Probability of obtaining significant result", bty="l", xaxs="i", yaxs="i", main=title)
# mtext(text="rho=0.4\nalpha=0.01",side=3,outer=F,adj=1)


df <- data.frame(SampSizeVec,ProbVec)
p5 <- ggplot(df, aes(x=SampSizeVec, y=ProbVec)) + geom_line() + theme_classic() +
  xlab("Sample Size") + ylab("Probability of significant result") + stat_smooth(se = FALSE)+
  annotate("text", x = SampVec-(.1*SampVec), y = 0.2, label = "rho=0.4\nalpha=0.01")+
  scale_y_continuous(limits = c(0, 1)) +
  ggtitle("West Coast Fox Fish")

p6 <- ggplot(df, aes(x=SampSizeVec, y=ProbVec)) + geom_line() + theme_classic() +
  xlab("Sample Size") + ylab("Probability of significant result") +
  annotate("text", x = SampVec-(.1*SampVec), y = 0.2, label = "rho=0.4\nalpha=0.01")+
  scale_y_continuous(limits = c(0, 1)) +
  ggtitle("West Coast Fox Fish")


