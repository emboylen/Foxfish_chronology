# Detrending

The following R scripts use the dendrochronology program in R ([dplR](http://cran.r-project.org/web/packages/dplR/dplR.pdf "dplR pdf")) to detrend my otolith increment chronologies.

The data I use for the scripts are the output of the **Initialize_Incs_Fox.R**, but any chronology can be used.

The scripts in this directory are:
* **Detrending_NegExp_Fox.R**: Detrending (using dplR) method = Negative Exponential. 
* **Detrending_Spline_Fox.R**: Detrending (using dplR) method = cubic smoothing spline.
* **Detrending_Comparison.R**: A comparison of the detrending methods (negative exponential, spline, horizontal) using the dendrochronology program library in R (dplR)'s function ```i.detrend``` (interactive detrending) - applied on the master chronologies

I still need to update both R scripts to actually write the detrended data out as .csv, which I will get to...
