# Environmental Variables
To see which environmental variables drive the growth of fox fish _Bodianus frenchii_, I will be testing for correlations between  the increment chronologies and the environmental variable chronologies. The variables I will be using are:
* **SST**: Sea Surface Temperature
* **FSL**: Fremantle Sea Level - a proxy for Leeuwin Current

## Sea Surface Temperature
I have downloaded multiple .txt.gz files for [Hadley Sea Surface Temperature](http://www.metoffice.gov.uk/hadobs/hadisst/data/download.html) observations for the years **1931-2013**. The data have been unzipped (UnZip_Data.R), resulting in mutiple .txt files in [ASCII format.](http://www.metoffice.gov.uk/hadobs/hadisst/data/Read_instructions_sst.txt).   

For this study, we will be comparing two populations of fox fish _Bodianus frenchii_, the "South Coast" (Esperance, Albany area Western Australia) and the "West Coast" (Rottnest Western Australia). This means that I will have to get the SST observations from more than one grid cell, and use all grid cells (or possible the mean of many) in my model.

The R scripts used in getting the SST:
* **UnZip_Data.R**: assumes you have downloaded the HadISST1_SST.txt.gz data files and have them in your working directory. This script simply uses R.utils to unzip them to .txt files
* **SST_Data.R**: uses several functions to extract the monthly SST observations from each file for a grid cell the user inputs, results in a matrix "BigMat" of 12 rows (one for each month) and ncol = years
* **Run_Source_SST.R**: specifies the grid cell (Lat, Long) and runs the SST_Data.R code, results in a .csv of the "BigMat" generated for each grid cell specified
* **Mean_Comb_SST.R**: calculates the mean of various grid cell .csv data. Specifically, this script finds the mean for the west coast grid cells and the south coast grid cells.


## Fremantle Sea Level
Australian Sea Level Data can be downloaded from the [Bureau of Meteorology website](http://www.bom.gov.au/oceanography/tides/monthly/) (the FSL data I used can be found [here](http://www.bom.gov.au/ntc/IDO70000/IDO70000_62230_SLD.txt).) A .csv of the data I used can be found in Data Files. The **FSL_Initial_Plot.R** plot contains code to read in the FSL.csv, add a date variable and plot using ggplot2.
