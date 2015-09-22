##################################################################
#### MAPS

setwd("C:/Users/User/Google Drive/Honours/Results/maps")

library(maps)
library(mapdata)

map()
map.axes()
map.scale()
map.scale(x=-175, y=-40, relwidth = 0.1, cex=0.4)
# x=-175, y=-40, determines position of scale
# relwidth = 0.1, determines width of the scale
# cex=0.4 determines font size of scale

Lat <- c(-32, -34.5)
Lon <- c(115, 121)
Nam <- c("Rottnest", "Esperance")
Cols <- c("red", "blue")
dat <- data.frame(Lat, Lon, Nam, Cols)

Lats <- c(-38,-15, -15, -38)
Lons <- c(110, 130, 110, 130)
dat1 <- data.frame(Lats, Lons)

tiff("FullAus1.tiff",
     width = 500, height = 500, units = "px", pointsize = 12,
     compression = "none", bg = "white", res = 100, family = "Arial", 
     restoreConsole = TRUE,
     type = "cairo")

map(xlim=c(110, 160), ylim=c(-45,-10), fill = TRUE, col = "white", bg = "white")
#map.axes()
axis(2, tcl=0, labels=F, pos=110) #pos = 108
axis(1, tcl=0.5) #, pos = -46.5
axis(3, tcl=0, labels=F, pos=-10)
axis(4, tcl=0.5, pos=160)
#title(main = "Australia")
points(dat$Lon, dat$Lat, col = Cols, pch = 20)
points(dat1$Lons, dat1$Lats, pch = 20, cex=0.2)
text(128, -25, labels = "Australia", cex = 1, adj=0.2, pos=4)

dev.off()



tiff("Inset1.tiff",
     width = 1500, height = 1200, units = "px", pointsize = 12,
     compression = "none", bg = "white", res = 100, family = "Arial", 
     restoreConsole = TRUE,
     type = "cairo")


map(xlim=c(110, 130), ylim=c(-40,-20), fill = TRUE, col = "white", bg = "white")
map.scale(ratio=F, relwidth=0.4, x=116, y=-30, cex=0.7)
axis(2, tcl=0.5, pos = 110)
axis(1, tcl=0.5, pos = -40)
axis(3, tcl=0, labels=F, pos= -20)
axis(4, tcl=0, labels=F, pos= 130)
#title(main = "Western Australia")
points(dat$Lon, dat$Lat, col = Cols, pch = 20)
text(115, -32, labels = "Rottnest", cex = 0.8, adj=0.2, pos=2)
text(121, -34.5, labels = "Esperance", cex = 0.8, adj=0.2, pos=1)


dev.off()
