---
layout: post
title: "Plot Continuous & Discrete Data Together"
date:   2017-08-01
authors: [ ]
contributors: [ ] 
dateCreated: 2017-08-01
lastModified: 2017-08-04
packagesLibraries: [ ]
category: [self-paced-tutorial]
tags: [ ]
mainTag:  neon-pheno-temp-series
tutorialSeries:  [neon-pheno-temp-series]
description: "This tutorial discusses ways to plot plant phenology (discrete time
series) and single-aspirated temperature (continuous time series) together."
code1: 
image:
  feature: codedFieldJournal.png
  credit: National Ecological Observatory Network (NEON)
  creditlink: 
permalink: /R/neon-pheno-temp-plot/
comments: true
---

{% include _toc.html %}

**R Skill Level:** Intermediate - you've got the basics of `R` down.

<div id="objectives" markdown="1">

# Objectives
After completing this activity, you will:

 * 

##Things You’ll Need To Complete This Tutorial
You will need the most current version of `R` and, preferably, `RStudio` loaded
on your computer to complete this tutorial.

###Install R Packages
* **NAME:** `install.packages("NAME")`


[More on Packages in R - Adapted from Software Carpentry.]({{site.baseurl}}R/Packages-In-R/)

###Download Data 

{% include/dataSubsets/_data_NEON-pheno-temp-timeseries.html %}

****
{% include/_greyBox-wd-rscript.html %}

****

##Additional Resources

* (links if you want to provide)

</div>



    # Load required libraries
    library(ggplot2)
    library(dplyr)
    library(tidyr)
    library(lubridate)
    library(gridExtra)
    
    # Set working directory
    
    # Read in data
    temp_day <- read.csv('NEON-pheno-temp-timeseries/temp/NEONsaat_daily_SCBI_2016.csv', stringsAsFactors = FALSE)


Final Plot - combo of two plots stacked (e.g. not 2 y-axes on 1 plot)

### Fix - new pheno plot with only 2016
### Dates on x-axis


    phenoPlot <- ggplot(inStat_T, aes(date, n)) +
        geom_bar(stat="identity", na.rm = TRUE) +
        ggtitle("Total Individuals in Leaf") +
        xlab("Date") + ylab("Number of Individuals") +
        theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
        theme(text = element_text(size=18))
    
    phenoPlot

    ## Don't know how to automatically pick scale for object of type function. Defaulting to continuous.

    ## Error in (function (..., row.names = NULL, check.rows = FALSE, check.names = TRUE, : arguments imply differing number of rows: 86, 0

    tempPlot_dayMax <- ggplot(temp_day, aes(sDate, dayMax)) +
        geom_point() +
        ggtitle("Daily Max Air Temperature") +
        xlab("") + ylab("Temp (C)") +
        theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
        theme(text = element_text(size=18))
    
    tempPlot_dayMax

![ ]({{ site.baseurl }}/images/rfigs/OSIS-phenology-series/03_plot-discrete-continuous-data-pheno-temp/stacked-plots-1.png)

    # Output with both plots
    grid.arrange(phenoPlot, tempPlot_dayMax) 

    ## Don't know how to automatically pick scale for object of type function. Defaulting to continuous.

    ## Error in (function (..., row.names = NULL, check.rows = FALSE, check.names = TRUE, : arguments imply differing number of rows: 86, 0

##Scaled Plots

### DOES NOT WORK. FIX

    tempPlot_dayMax <- ggplot(temp_day, aes(sDate, dayMax)) +
        geom_point() +
        ggtitle("Daily Max Air Temperature") +
        xlab("") + ylab("Temp (C)") +
        theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
        theme(text = element_text(size=18))
    
    tempPlot_dayMax <- ggplot(inStat_T, aes(date, n)) +
        geom_bar(stat="identity", na.rm = TRUE)+
        add=TRUE

    ## Error in tempPlot_dayMax <- ggplot(inStat_T, aes(date, n)) + geom_bar(stat = "identity", : could not find function "<-<-"

    phenoPlot

    ## Don't know how to automatically pick scale for object of type function. Defaulting to continuous.

    ## Error in (function (..., row.names = NULL, check.rows = FALSE, check.names = TRUE, : arguments imply differing number of rows: 86, 0

![ ]({{ site.baseurl }}/images/rfigs/OSIS-phenology-series/03_plot-discrete-continuous-data-pheno-temp/scaled-plot-1.png)

### Format Dates in Axis Labels
We can adjust the date display format (e.g. 2009-07 vs. Jul 09) and the number 
of major and minor ticks for axis date values using `scale_x_date`. Let's
format the axis ticks so they read "month year" (`%b %y`). To do this, we will 
use the syntax:

`scale_x_date(labels=date_format("%b %y")`

Rather than re-coding the entire plot, we can add the `scale_x_date` element
to the plot object `AirTempDaily` that we just created. 

<i class="fa fa-star"></i> **Data Tip:** You can type `?strptime` into the `R` 
console to find a list of date format conversion specifications (e.g. %b = month).
Type `scale_x_date` for a list of parameters that allow you to format dates 
on the x-axis.
{: .notice }


    # format x-axis: dates
    AirTempDailyb <- AirTempDaily + 
      (scale_x_date(labels=date_format("%b %y")))

    ## Error in eval(expr, envir, enclos): object 'AirTempDaily' not found

    AirTempDailyb

    ## Error in eval(expr, envir, enclos): object 'AirTempDailyb' not found

<i class="fa fa-star"></i> **Data Tip:** If you are working with a date & time
class (e.g. POSIXct), you can use `scale_x_datetime` instead of `scale_x_date`.
{: .notice }



### Export data.frame to .CSV

We can export this subset in `.csv` format to use in other analyses or to 
share with colleagues using `write.csv`. 

<i class="fa fa-star"></i> **Data Tip:** Remember, to give your output files
concise, yet descriptive names so you can identify what it contains in the
future. By default, the `.csv` file will be written to your working directory. 
{: .notice}


    # write harMet15 subset data to .csv
    write.csv(harMet15.09.11, 
              file="Met_HARV_15min_2009_2011.csv")

    ## Error in is.data.frame(x): object 'harMet15.09.11' not found

