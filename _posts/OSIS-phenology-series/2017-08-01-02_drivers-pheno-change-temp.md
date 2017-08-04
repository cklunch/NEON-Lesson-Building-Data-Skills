---
layout: post
title: "Temperature as a Driver of Phenological Change"
date: 2017-08-01
authors: [Lee Stanish, Megan A. Jones, Natalie Robinson]
contributors: [ ] 
dateCreated: 2017-08-01
packagesLibraries: [dplyr, ggplot2, lubridate]
category: [self-paced-tutorial]
tags: [ ]
lastModified: 2017-08-04
mainTag:  neon-pheno-temp-series
tutorialSeries: [neon-pheno-temp-series]
description: "This tutorial demonstrates how to work with NEON single-asperated 
air temperature data. Specific tasks include conversion to POSIX date/time class,
subsetting by date, and plotting the data."
code1: 
image:
  feature: codedFieldJournal.png
  credit: National Ecological Observatory Network (NEON)
  creditlink: 
permalink: /R/neon-SAAT-temp/
comments: true
---

{% include _toc.html %}

**R Skill Level:** Intermediate - you've got the basics of `R` down.

<div id="objectives" markdown="1">

# Objectives
After completing this activity, you will:

* 

## Things You’ll Need To Complete This Tutorial
You will need the most current version of `R` and, preferably, `RStudio` loaded
on your computer to complete this tutorial.

### Install R Packages
* **ggplot2:** `install.packages("ggplot2")`
* **dplyr:** `install.packages("dplyr")`

[More on Packages in R - Adapted from Software Carpentry.]({{site.baseurl}}R/Packages-In-R/)

### Download Data

{% include/dataSubsets/_data_NEON-pheno-temp-timeseries.html %}

****
{% include/_greyBox-wd-rscript.html %}

****

## Additional Resources

</div>

## Drivers of phenology

Now that we see that there are differences in and shifts in phenophases, what 
are the drivers of phenophases?

Commonly studied drivers of phenophase change include:
	
* precipitation - how much rain/snow falls and the timing of the precipitation
* day length - day length effects the amount of sun the plants recieve and can 
use to photosynthesis and grow
* temperature - growth rates change depending on the temperature for different 
species

To continue our exploration of what might be a driver to the changes in
phenosphase that we saw in the previous tutorial, we will focus on temperature.


## NEON Temperature Data 

NEON collects single aspirated temperature at  intervals. Therefore, we could 
look at many different temperature measures:

* near continuous temperature across the days
* aggregated data: min, mean, or max over a some duration
* the number of days since a freezing temperatures

Different species respond differently to the above measures. WHY high 
temperature is important to plant phenophase. 

Therefore, our research question going forward is: 

**How does the mean high temperature per day affect the phenophase?** 


## Import Data

This lesson uses 30 minute temperature data from the triple aspirated
temperature sensors mounted above the canopy on the NEON tower.

To set the working directory on the Mac, you need to first mount
the remote drive onto your computer


    # Load required libraries
    library(ggplot2)
    library(dplyr)
    library(tidyr)
    library(lubridate)
    
    # Set working directory
    
    # Read in data
    temp30_sites <- read.csv('NEON-pheno-temp-timeseries/temp/SAAT_30min.csv', stringsAsFactors = FALSE)

## Explore Temp. Data

Now that you have the data, let's take a look at the readme and understand 
what's in the data. View readme and variables file. This will guide you
on how to import the data.


    # Get a general feel for the data: View structure of data frame
    str(temp30_sites)

    ## 'data.frame':	219160 obs. of  14 variables:
    ##  $ domainID           : chr  "D02" "D02" "D02" "D02" ...
    ##  $ siteID             : chr  "SCBI" "SCBI" "SCBI" "SCBI" ...
    ##  $ horizontalPosition : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ verticalPosition   : int  10 10 10 10 10 10 10 10 10 10 ...
    ##  $ startDateTime      : chr  "2015-04-01T00:00:00Z" "2015-04-01T00:30:00Z" "2015-04-01T01:00:00Z" "2015-04-01T01:30:00Z" ...
    ##  $ endDateTime        : chr  "2015-04-01T00:30:00Z" "2015-04-01T01:00:00Z" "2015-04-01T01:30:00Z" "2015-04-01T02:00:00Z" ...
    ##  $ tempSingleMean     : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ tempSingleMinimum  : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ tempSingleMaximum  : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ tempSingleVariance : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ tempSingleNumPts   : int  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ tempSingleExpUncert: num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ tempSingleStdErMean: num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ finalQF            : int  1 1 1 1 1 1 1 1 1 1 ...

## Select Site(s) of Interest


    # set site of interest
    siteOfInterest <- "SCBI"
    
    # use filter to select only the site of Interest 
    # using %in% allows one to add a vector if you want more than one site. 
    temp30 <- filter(temp30_sites, siteID %in% siteOfInterest)


what is a QF. ->metadata
Check for Quality flags


    # Review the data quality (are these data you trust?)
    #1. Are there quality flags in your data? Count 'em up
    
    sum(temp30$finalQF==1)

    ## [1] 99389

Do we have NA data?
How to deal with? 


    # Are there NA's in your data? Count 'em up
    sum(is.na(temp30$tempSingleMean) )

    ## [1] 29129

    mean(temp30$tempSingleMean)

    ## [1] NA

Why was there no output? 

We had previously seen that there are NA values in the temperature data. Given 
there are NA values, R, by default, won't calculate a mean (and many other 
summary statistics) as the NA values could skew the data. 

`na.rm=TRUE` #tells R to ignore them for calculaation,etc


    # create new dataframe without NAs
    temp30_noNA <- temp30 %>%
    	drop_na(tempSingleMean)
    
    # did it work?
    sum(is.na(temp30_noNA$tempSingleMean))

    ## [1] 0

Convert to correct time zone, default for this code is MST
 assign time zone to just the first entry
 

    # View the date range
    range(temp30_noNA$startDateTime)

    ## [1] "2015-04-01T00:00:00Z" "2016-12-31T23:30:00Z"

All NEON data is reported in UTC which is the same as GMT.  


    # convert to Date Time 
    temp30_noNA$startDateTime <- as.POSIXct(temp30_noNA$startDateTime,
    																				format = "%Y-%m-%dT%H:%M", tz = "GMT")
    # check that conversion worked
    str(temp30_noNA$startDateTime)

    ##  POSIXct[1:120791], format: "2015-04-26 12:00:00" "2015-04-26 12:30:00" ...

Subset by date


    # Limit dataset to dates of interest (2016-01-01 to 2016-12-31)
    
    temp30_TOI <- filter(temp30_noNA, startDateTime>"2015-12-31 23:59")
    
    
    # View the date range
    range(temp30_TOI$startDateTime)

    ## [1] "2016-01-01 07:00:00 GMT" "2016-12-31 23:30:00 GMT"


## plot 30-min data over year 


    tempPlot <- ggplot(temp30_TOI, aes(startDateTime, tempSingleMean)) +
        geom_point() +
        ggtitle("Single Asperated Air Temperature") +
        xlab("Date") + ylab("Temp (C)") +
        theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
        theme(text = element_text(size=18))
    
    tempPlot

![ ]({{ site.baseurl }}/images/rfigs/OSIS-phenology-series/02_drivers-pheno-change-temp/plot-temp-1.png)


## Daily Temperature

aggregate by day & find max ->  dplyr 



    # convert to date
    temp30_TOI$sDate <- as.Date(temp30_TOI$startDateTime)
    
    # did it work
    str(temp30_TOI$sDate)

    ##  Date[1:68402], format: "2016-01-01" "2016-01-01" "2016-01-01" "2016-01-01" "2016-01-01" ...

    # max of mean temp each day
    temp_day <- temp30_TOI %>%
    	group_by(sDate) %>%
    	distinct(sDate, .keep_all=T) %>%
    	mutate(dayMax=max(tempSingleMean))
    
    
    # rename column

## plot daily max over year

To successfully plot, the last piece that is needed is the `geom`etry type. In 
this case, we want to create a scatterplot so we can add `+ geom_point()`.

Let's create an air temperature scatterplot. 


    # plot Air Temperature Data across 2016 using daily data
    tempPlot_dayMax <- ggplot(temp_day, aes(sDate, dayMax)) +
        geom_point() +
        ggtitle("Daily Max Air Temperature") +
        xlab("") + ylab("Temp (C)") +
        theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
        theme(text = element_text(size=18))
    
    tempPlot_dayMax

![ ]({{ site.baseurl }}/images/rfigs/OSIS-phenology-series/02_drivers-pheno-change-temp/basic-ggplot2-1.png)

## Add graphing only a part of the year on x-axis




    # Write .csv (this will be read in new in subsuquent lessons)
    write.csv(temp_day, file="NEON-pheno-temp-timeseries/temp/NEONsaat_daily_SCBI_2016.csv")


