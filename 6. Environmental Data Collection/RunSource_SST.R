##### Sea Surface Temperature Data

# West Coast

# Run Rottnest (west coast) coords
Long <- 116
Lat <- 32
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Rotto.csv")

# Run Rottnest (west coast) coords
Long <- 115
Lat <- 32
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Rotto1.csv")

# Run Rottnest (west coast) coords
Long <- 115
Lat <- 33
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Rotto2.csv")

# Run Rottnest (west coast) coords
Long <- 114
Lat <- 33
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Rotto3.csv")

# Run Rottnest (west coast) coords
Long <- 116
Lat <- 33
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Rotto4.csv")


# South Coast

# Run Augusta (south coast) coords
Long <- 114
Lat <- 34
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Aug.csv")

# Run Augusta (south coast) coords
Long <- 115
Lat <- 34
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Aug1.csv")

# Run Augusta (south coast) coords
Long <- 116
Lat <- 35
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Aug2.csv")

# Run Albany (south coast) coords
Long <- 118
Lat <- 36
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Albany.csv")

# Run Albany east 1 (south coast) coords
Long <- 119
Lat <- 35
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Albany1.csv")

# Run Esperance (south coast) coords
Long <- 120
Lat <- 35
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Esp.csv")

# Run Esperance east 1 (south coast) coords
Long <- 121
Lat <- 35
AllYears <- 2013:1931

system.time(source("SST_Data.R"))
write.csv(BigMat, file = "SST_Data_Esp1.csv")