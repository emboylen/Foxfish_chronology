# Statistical Cross Dating 
#### Using a dendrochronology program in R (dplR)

For a description of what crossdating, and in particular, statistical cross-dating is - see my [wiki page](https://github.com/emboylen/EBHonoursThesis/wiki/2.-Statistical-Cross-Dating).

In this section - I will be not only cross-dating the combined data, but also comparing PC's and EB's measurements, to see if:
* Combining the data was useful, or
* If either researcher's measurements were better (indicated by the higher inter-series correlation, lower standard deviations, etc.)

Data for these srcipts is the data generated in [part 1, Increment Data](https://github.com/emboylen/EBHonoursThesis/tree/master/1.%20Increment%20Data) - particularly the combined data, as well as some raw data.

R scripts:
* **X_dating_Incs.R**: a generic script which can be applied to any ring width data (in .csv format initially). I have used my combined data in this case
* **X_dating_Incs_PC.R**: as above, using PC's measurements
* **X_dating_Incs_EB.R**: as above, using EB's measurements

Output:
* A "spaghetti" plot of the raw increments (similar to my plots made with ggplot2, in   [part 1, Increment Data](https://github.com/emboylen/EBHonoursThesis/tree/master/1.%20Increment%20Data)
* A segment series plot, showing the significance of each chronology segment (blue = significantly correlated, red = insignificantly correlated, green = not enough data)
* A table (in .csv format) with the age ranges, mean number of increments, mean sensitivity, standard deviation and n.

For detailed instructions on the output of dplR - see the [vignette](http://cran.r-project.org/web/packages/dplR/vignettes/xdate-dplR.pdf "dplR Vignette pdf")
