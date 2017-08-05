---
layout: post
title: "Plot Continuous & Discrete Data Together"
date:   2017-08-01
authors: [Lee Stanish, Megan A. Jones, Natalie Robinson]
contributors: [ Katie Jones, Cody Flagg] 
dateCreated: 2017-08-01
lastModified: 2017-08-04
packagesLibraries: [ ]
category: [self-paced-tutorial]
tags: [R, timeseries]
mainTag:  neon-pheno-temp-series
tutorialSeries:  [neon-pheno-temp-series]
description: "This tutorial discusses ways to plot plant phenology (discrete time
series) and single-aspirated temperature (continuous time series) together."
languagesTool: R
dataProduct: NEON.DP1.10055, 
code1: 
image:
  feature: codedFieldJournal.png
  credit: National Ecological Observatory Network (NEON)
  creditlink: 
permalink: /R/neon-pheno-temp-plot
comments: true
---

{% include _toc.html %}

**R Skill Level:** Intermediate - you've got the basics of `R` down.

<div id="objectives" markdown="1">

# Objectives
After completing this tutorial, you will be able to:

 * plot multiple figures together with grid.arrange()
 * plot only a subset of dates

## Things You’ll Need To Complete This Tutorial
You will need the most current version of `R` and, preferably, `RStudio` loaded
on your computer to complete this tutorial.

### Install R Packages
* **ggplot2:** `install.packages("ggplot2")`
* **gridExtra:** `install.packages("gridExtra")`
* **dplyr:** `install.packages("dplyr")`
* **lubridate:** `install.packages("lubridate")`
* **scales:** `install.packages("scales")`


[More on Packages in R - Adapted from Software Carpentry.]({{site.baseurl}}R/Packages-In-R/)

### Download Data 

{% include/dataSubsets/_data_NEON-pheno-temp-timeseries.html %}

****
{% include/_greyBox-wd-rscript.html %}


</div>




    # Load required libraries
    library(ggplot2)
    library(dplyr)
    library(lubridate)
    library(gridExtra)
    library(scales)  # use with date_breaks
    
    # set working directory to ensure R can find the file we wish to import
    # setwd("working-dir-path-here")
    
    # Read in data -> if in series this is unnecessary
    temp_day <- read.csv('NEON-pheno-temp-timeseries/temp/NEONsaat_daily_SCBI_2016.csv',
    		stringsAsFactors = FALSE)
    
    phe_1sp_2016 <- read.csv('NEON-pheno-temp-timeseries/pheno/NEONpheno_LITU_Leaves_SCBI_2016.csv',
    		stringsAsFactors = FALSE)
    
    # Convert dates
    temp_day$sDate <- as.Date(temp_day$sDate)
    phe_1sp_2016$date <- as.Date(phe_1sp_2016$date)


## Plot together

We've previously looked at the plots apart, but let's plot them in the same 
pane. 

We can do this with the `grid.arrange()` function from the gridExtra package. 


    phenoPlot <- ggplot(phe_1sp_2016, aes(date, n.y)) +
        geom_bar(stat="identity", na.rm = TRUE) +
        ggtitle("Total Individuals in Leaf") +
        xlab("Date") + ylab("Number of Individuals") +
        theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
        theme(text = element_text(size=18))
    
    phenoPlot

![ ]({{ site.baseurl }}/images/rfigs/NEON-pheno-temp-timeseries/03_plot-discrete-continuous-data-pheno-temp/stacked-plots-1.png)

    tempPlot_dayMax <- ggplot(temp_day, aes(sDate, dayMax)) +
        geom_point() +
        ggtitle("Daily Max Air Temperature") +
        xlab("") + ylab("Temp (C)") +
        theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
        theme(text = element_text(size=18))
    
    tempPlot_dayMax

![ ]({{ site.baseurl }}/images/rfigs/NEON-pheno-temp-timeseries/03_plot-discrete-continuous-data-pheno-temp/stacked-plots-2.png)

    # Output with both plots
    grid.arrange(phenoPlot, tempPlot_dayMax) 

![ ]({{ site.baseurl }}/images/rfigs/NEON-pheno-temp-timeseries/03_plot-discrete-continuous-data-pheno-temp/stacked-plots-3.png)


### Format Dates in Axis Labels
Hmmm... the x-axis on both plots is kinda wonky. For the pheno data, We might 
want a different
date display format (e.g. 2016-07 vs. Jul); for the temp data there are a TON of tick
marks! These parameters can be adujusted with `scale_x_date`. Let's format the x-axis
ticks so they read "month" (`%b`) in both graphs. We will use the syntax:

`scale_x_date(labels=date_format("%b"")`

Rather than re-coding the entire plot, we can add the `scale_x_date` element
to the plot object `phenoPlot` we just created. 

<i class="fa fa-star"></i> **Data Tip:** You can type `?strptime` into the `R` 
console to find a list of date format conversion specifications (e.g. %b = month).
Type `scale_x_date` for a list of parameters that allow you to format dates 
on the x-axis.
{: .notice }


<i class="fa fa-star"></i> **Data Tip:** If you are working with a date & time
class (e.g. POSIXct), you can use `scale_x_datetime` instead of `scale_x_date`.
{: .notice }


    # format x-axis: dates
    phenoPlot <- phenoPlot + 
      (scale_x_date(breaks = date_breaks("months"), labels = date_format("%b")))
    
    phenoPlot

![ ]({{ site.baseurl }}/images/rfigs/NEON-pheno-temp-timeseries/03_plot-discrete-continuous-data-pheno-temp/format-x-axis-labels-1.png)

    tempPlot_dayMax <- tempPlot_dayMax +
      (scale_x_date(breaks = date_breaks("months"), labels = date_format("%b")))
    
    tempPlot_dayMax

![ ]({{ site.baseurl }}/images/rfigs/NEON-pheno-temp-timeseries/03_plot-discrete-continuous-data-pheno-temp/format-x-axis-labels-2.png)

    # Output with both plots
    grid.arrange(phenoPlot, tempPlot_dayMax) 

![ ]({{ site.baseurl }}/images/rfigs/NEON-pheno-temp-timeseries/03_plot-discrete-continuous-data-pheno-temp/format-x-axis-labels-3.png)

### Align datasets

We have different start and end dates, which makes it harder to see trends. 
Let's align the datasets and replot


    # align dates
    temp_day_fit <- filter(temp_day, sDate >= min(phe_1sp_2016$date) & sDate <= max(phe_1sp_2016$date))
    
    # Check it
    range(phe_1sp_2016$date)

    ## [1] "2016-03-21" "2016-11-23"

    range(temp_day_fit$sDate)

    ## [1] "2016-03-21" "2016-11-23"

    #plot again
    tempPlot_dayMax_corr <- ggplot(temp_day_fit, aes(sDate, dayMax)) +
        geom_point() +
        scale_x_date(breaks = date_breaks("months"), labels = date_format("%b")) +
        ggtitle("Daily Max Air Temperature") +
        xlab("") + ylab("Temp (C)") +
        theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
        theme(text = element_text(size=18))
    
    grid.arrange(phenoPlot, tempPlot_dayMax_corr)

![ ]({{ site.baseurl }}/images/rfigs/NEON-pheno-temp-timeseries/03_plot-discrete-continuous-data-pheno-temp/align-datasets-replot-1.png)

## Same plot with two Y-axes?

What about layering these plots and having two y-axes (right and left) that have
the different scale bars. This might look cool. 

However, some argue that you should not do this as it 
can distort what is actually going on with the data. The author of the ggplot2 
package is one of these individuals. Therefore, you cannot use `ggplot()` to 
create a single plot with multiple Y scales. You can read his own discussion of
the topic on this 
<a href="https://stackoverflow.com/questions/3099219/plot-with-2-y-axes-one-y-axis-on-the-left-and-another-y-axis-on-the-right/3101876#3101876" target="_blank"> StackOverflow post</a>.
