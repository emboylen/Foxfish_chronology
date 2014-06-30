# Increment Data

The fish otoliths have been sectioned, set in resin, and photographed with a microscope. These increments are then measured on a program using [Image J](http://imagej.nih.gov/ij/) with the plug-in IncMeas (Rountrey 2009).  

These measurements have then been exported as .csv files. Two researchers (EB and PC) determined the measurements, so the mean of the two will have to be calculated.

Data files are in the format:

|Year | Fish X1 | Fish X2 | ... | Fish X30 |
|-----|---------|---------|-----|----------|
|2013 | 12      |31       |...  | 12       |
|2012 | 13      | 11      |...  | 11       |
|...  | ...     |...      |...  |...       |
|1940 | 14      | 16      |...  | 11       |

Data files:
* **SouthFOXEB.csv**: Foxfish from the South Coast, measured by EB
* **SouthFOXPC.csv**: Foxfish from the South Coast, measured by PC
* **WestFOXEB.csv**: Foxfish from the West Coast, measured by EB
* **WestFOXPC.csv**: Foxfish from the West Cpast, measrued by PC

R scripts:
* **Initialize_Incs_Fox.R**: Set the directory, read in the data, find the mean of the two .csv data files
* **Plot_Incs_Fox.R**: Plot the combined increment measurements, with a mean line and without
