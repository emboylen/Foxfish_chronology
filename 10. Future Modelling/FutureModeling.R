######################################################################
# Future Modeling

### Initialize
#setwd("C:/Users/Ellen/Google Drive/Honours/Results/Bio data") # laptop
setwd("C:/Users/User/Google Drive/Honours/Results/Bio data") # pc
rm(list = ls()) # clears global environment
dat <- read.csv("OtoSize.csv", header=TRUE)


## Fitting a power function

O <- dat$OtoSize
L <- dat$TL

plot(O,L)

# nls
Data <- data.frame(O=O, L=L)
form <- formula(L ~ a*O^b)
mod2 <- nls(form, data=Data, start=list(a=15, b=0.1))
summary(mod2)
esta <- coef(mod2)[1]
estb <- coef(mod2)[2]
points(O, esta*O^estb, col="red")
plot(O,L, col="white", xlab = expression(paste("Otolith Size (", mu, "m)")), ylab = "Fish Length (TL, mm)")
lines(Data$O, predict(mod2), col = "red")

x <- 26.07449*100^0.3975319; x
