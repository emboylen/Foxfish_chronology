data <- Data_South[,c(2,5:9, 11:14)]
library(ggplot2)
library(reshape2)
data1=melt(cor(data, use="p"))
data2 <- data1[ which(data1$Var1=='xxxstd' & !(data1$Var2 == 'xxxstd')), ]
qplot(x=Var1, y=Var2, data=data2, fill=value, geom="tile") +
  scale_fill_gradient2(limits=c(-1, 1))
