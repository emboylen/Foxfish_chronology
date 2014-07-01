#### Power Analysis

For background on power analyses, please visit my [wiki](https://github.com/emboylen/EBHonoursThesis/wiki/9.-Power-Analysis "EBHonoursThesis wiki").
######Caution!
Running these simulations can take a very long time, depending on your machine.
My analyses took up to 6 hours per simulation (total = 24+ hours). 

Please consider running a seperate machine or plan ahead.

##### Files
* **Source_Run_All.R**: an R script which runs Run_Power_Analysis.R
* **Run_Power_analysis.R**: an R script which runs the complete power analysis simulation for each species (Fox = Foxfish), each region (West, South) at 0.01 and 0.05 significance level ("..._1Sig.R" = 0.01).
*  **Power_Analysis_SouthFox_1Sig.R**: simulation for South Coast foxfish, sig = 0.01
*  **Power_Analysis_SouthFox_5Sig.R**: simulation for South Coast foxfish, sig = 0.05
*  **Power_Analysis_WestFox_1Sig.R**: simulation for West Coast foxfish, sig = 0.01
*  **Power_Analysis_WestFox_5Sig.R**: simulation for West Coast foxfish, sig = 0.05

##### Variables to set
In **Run_Power_analysis**:
* ```ItVec```: a number indiacting the number of iterations and the sample size. Both are of equal length coincidentally, they can be different lengths [line 3]
* ```SampVec```: a number indicating the maximum number of samples to reach, xmax on the graphical output. Used in ```SampSizeVec``` [line 4]

In **Power_Analysis..._.R** files:
* ```CutAge```: cut-off age for juvenile fish to be excluded from analysis [line 34]
* ```rho```: estimated effect size, mine is set to 0.4 (average value of all sclerochronological studies using otoliths) [line 43]
* ```Alpha```: set to 0.05 and 0.01 respectively [line 44]
* ```NumIts```: total number of iterations - the more iterations the longer the model takes to run [line 51] _Mine_ _is_ _set_ _to_ _=_ _ItVec_
* ```SampSizeVec```: a vector indicating the sample size range to simulate; the limits of the x axis of end product [line 52]
* ```SampSize```: the sample size for each simulation [line 53] _Mine_ _is_ _set_ _to_ _=_ _ItVec_
