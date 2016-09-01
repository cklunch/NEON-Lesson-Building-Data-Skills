---
layout: post
title: "Visualize Palmer Drought Index & Soil Moisture Data in 
R to Better Understand - 2013 Colorado Floods"
date: 2015-12-07
authors: [Leah A. Wasser, Megan A. Jones, Mariela Perignon]
dateCreated: 2015-05-18
lastModified: 2016-09-01
categories: [Coding and Informatics]
category: coding-and-informatics
tags: [R, time-series]
mainTag: GIS-Spatial-Data
scienceThemes: [phenology, disturbance]
description: "This tutorial walks through the steps need to download and 
visualize Palmer Drought Index Data in R. The data specifically downloaded for 
this activity allows one to to better understand the drivers and impacts of the 
2013 Colorado floods."
image:
  feature: TeachingModules.jpg
  credit: A National Ecological Observatory Network (NEON)
  creditlink: http://www.neonscience.org
permalink: /R/nCLIMDIV-Palmer-Drought-Data-R/
code1: nCLIMDIV-Palmer-Drought-In-R.R
comments: true
---

{% include _toc.html %}

This tutorial focuses on how to visualize Palmer Drought Severity Index data in 
R and Plot.ly. The tutorial is part of the Data Activity packages that can be used 
with the 
<a href="{{ site.basurl }}teaching-module/disturb-event-co13/1hr-overview" target="_blank"> Ecological Disturbance Teaching Modules. 

<div id="objectives" markdown="1">

### Goals / Objectives
After completing this tutorial, you will be able to:

* Download Palmer Drought Severity Index data from XXXX sites. 
* Plot Palmer Drought Severity Index data in R. 
* Publish & share an interactive plot of the data using Plot.ly.  

### Things You'll Need To Complete This Lesson
Please be sure you have the most current version of `R` and, preferably,
RStudio to write your code.

#### R Libraries to Install:

* **ggplot2:** `install.packages("ggplot2")`
* **lubridate:** `install.packages("lubridate")`
* **plotly:** `install.packages("plotly")`

#### Data Download & Directory Preparation

Directions are provided to download the data directly from XXXX source. If you 
are unable to follow the directions or would like to pre-download the data set
it can be downloaded from XXXX.  

So that we all have organized data in the same location, create a `data` directory 
(folder) within your `Documents` directory. Within `data`, create another 
directory `distub-events-co13`and then within it create `drought` directory.  

If you are using the provided data (downloaded above) simply put the 
entire unzipped directory in the `data` directory you just created. If you choose to save 
elsewhere you will need to modify the directions below to set your working 
directory accordingly.


#### Pre-requisit Knowledge 
To succeed in this tutorial, you will need to have basic knowledge for use of 
the R software program.    

</div>

## Research Question 
What was the pattern of drought leading up to the 2013 flooding events in Colorado? 

## Drought Data - the Palmer Drought Index
The <a href="https://www.drought.gov/drought/content/products-current-drought-and-monitoring-drought-indicators/palmer-drought-severity-index" target="_blank">Palmer Drought Severity Index </a>
is an overall index of drought that is useful to understand drought associated 
with agriculture. It uses temperature and precipitation data and soil moisture 
to calculate water supply and demand. The values range from **extreme drought** 
(values <-4.0) through **near normal** (-.49 to .49) to **extremely moist** (>4.0).

## Access the Data
This section of the tutorial goes through how to download the data. The data
is also available will all the data for this tutorial series in the Data Download
section at the top of the tutorial. Even if you choose to use the provided data, 
go through this section to learn about the data and metadata. 

The data used in this tutorial comes from 
<a href="http://www7.ncdc.noaa.gov/CDO/CDODivisionalSelect.jsp" target="_blank"> NOAA's Climate Divisional Database (nCLIMDIV)</a>. 
This dataset contains temperature, precipitation, and drought indication data
from across the United States. Data can be accessed over national, state, or 
<a href="https://www.ncdc.noaa.gov/monitoring-references/maps/us-climate-divisions.php" target="_blank"> divisional </a> extents. 

Open the 
<a href="http://www7.ncdc.noaa.gov/CDO/CDODivisionalSelect.jsp" target="_blank"> nCLIMDIV portal here </a>
to learn more about and retrieve data. 

On this page we see several boxes where we can enter search criteria, but before
searching we need to find out about the data. We need to figure out: 

* what data are available, 
* what format the data are available in, 
* what spatial and temporal extent for the data can we access, 
* the meaning of any abbreviations & technical terms used in the data file, and
* any other information that we'd like to know before deciding this is the 
data set we want to work with.  

### What data are available? 

Below the search section, you see a table (reproduced below) with the different
indices that are included in any downloaded dataset.  Here we see that the 
Palmer Drought Severity Index (PDSI) is one of many indecies available.  

#### Indecies

| Abbreviation | Index                                  |
|--------------|----------------------------------------|
| PCP          | Precipitation Index                    |
| TAVG         | Temperature Index                      |
| TMIN         | Minimum Temperature Index              |
| TMAX         | Maximum Temperature Index              |
| PDSI         | Palmer Drought Severity Index          |
| PHDI         | Palmer Hydrological Drought Index      |
| ZNDX         | Palmer Z-Index                         |
| PMDI         | Modified Palmer Drought Severity Index |
| CDD          | Cooling Degree Days                    |
| HDD          | Heating Degree Days                    |
| SPnn         | Standard Precipitation Index           |

### Sample Data
Below the table is a link to the **Comma Delimited Sample** where you can see 
a sample of what the data looks like. Using the table above we can can identify
most of the headers.  `YearMonth` is also pretty self-explanatory it is Year 
then the month digit (YYYYMM) with no space.  However, what does the `StateCode` 
and `Division` mean?  We need to know more. 

### Metadata File
Below the table is another link to the **Divisional Data Description**. Click on 
this and you will be taken to a page with the metadata about the nCLIMDIV data (this file
is included in the Download Data .zip -- `divisional-readme.txt`). 

Skim through this metadata file. Can you find out what the `StateCode` is?  
What other information is important or interesting to you?  

### Download the Data
Now that we know a bit more about the data we can go about accessing and downloading 
the data. Our question is about droughts leading up to the 2013 flooding 
events in Colorado. Let's look at a 25-year period from 1990-2015. 

Therefore, we will enter the following information on the `State` tab to get our
desired dataset. 

* Select Nation: US
* Select State: Colorado
* Start Period: January (01) 1991
* End Period: December (12) 2015
* Text Output: Comma Delimited

After the process runs you are now given a text file (.txt) that you can open in
your browser or download.  

### Save the Data

To save this data file to your computer you can right click and `Save link as`. 
Each download from this site is given a unique code, therefore your file name 
will be slightly different from this examples. To help remember where the data 
are from, add the intials `_CO` to the end of the file name (but before the 
file extension) so that it looks like this `CDODiv8506877122044_CO.txt` (remember 
your # will be different). 

Save the file to the `~/Documents/data/disturb-events-co13/drought` directory 
that you created in the set up for this tutorial.  

## Load the Data in to R

Now that we have the data we can start working with it in R. 

### R Libraries

We will be working with time-series data in this tutorial so we will load the
`lubridate` library. We will use `ggplot2` to efficiently plot our data and 
`plotly` to create interactive plots of our data.


    library(lubridate) # work with time series data
    library(ggplot2)   # create efficient, professional plots
    library(plotly)    # create interactive plots

# Import the Data

We are interested in looking at the severity (or lack there of) of drought in 
Colorado before the 2013 floods, therefore we need to get the data that we just 
downloaded into R.

Our data have a header (remember the sample file!) - the first row repsents the 
variable name for each column. Thus we will use `header=TRUE` when we import the 
data to tell R to use that row as a column name rather than a row of data.


    # Set working directory to the data directory
    # setwd("YourFullPathToDataDirectory")
    
    # Import CO state-wide nCLIMDIV data
    nCLIMDIV <- read.csv("disturb-events-co13/drought/CDODiv8506877122044_CO.txt", header = TRUE)
    
    # view first few rows
    head(nCLIMDIV)

    ##   StateCode Division YearMonth  PCP TAVG  PDSI  PHDI  ZNDX  PMDI CDD  HDD
    ## 1         5        0    199101 0.80 21.9 -1.37 -1.37 -0.90 -0.40   0 1296
    ## 2         5        0    199102 0.44 32.5 -1.95 -1.95 -2.17 -1.48   0  868
    ## 3         5        0    199103 1.98 34.9 -1.77 -1.77 -0.07 -1.28   0  900
    ## 4         5        0    199104 1.27 41.9 -1.89 -1.89 -0.92 -1.63   0  678
    ## 5         5        0    199105 1.63 53.5 -2.11 -2.11 -1.25 -2.11   3  343
    ## 6         5        0    199106 1.88 62.5  0.11 -1.79  0.33 -1.57  62  113
    ##    SP01  SP02  SP03  SP06  SP09  SP12  SP24 TMIN TMAX  X
    ## 1 -0.40 -0.47  0.05  0.42  0.41  0.69 -0.41  9.5 34.3 NA
    ## 2 -1.78 -1.42 -1.28  0.15  0.11  0.41 -0.72 17.7 47.4 NA
    ## 3  0.89 -0.11 -0.36  0.03  0.85  0.43 -0.49 22.3 47.5 NA
    ## 4 -0.56  0.09 -0.56 -0.47 -0.07  0.08 -0.37 28.4 55.3 NA
    ## 5 -0.35 -0.67 -0.19 -0.86 -0.07 -0.06 -0.26 39.3 67.7 NA
    ## 6  0.65  0.15 -0.28 -0.48 -0.19  0.39 -0.24 48.1 76.9 NA

    # view data structure
    str(nCLIMDIV)

    ## 'data.frame':	300 obs. of  21 variables:
    ##  $ StateCode: int  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ Division : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ YearMonth: int  199101 199102 199103 199104 199105 199106 199107 199108 199109 199110 ...
    ##  $ PCP      : num  0.8 0.44 1.98 1.27 1.63 1.88 2.69 2.44 1.36 1.06 ...
    ##  $ TAVG     : num  21.9 32.5 34.9 41.9 53.5 62.5 66.5 65.5 57.5 47.4 ...
    ##  $ PDSI     : num  -1.37 -1.95 -1.77 -1.89 -2.11 0.11 0.6 1.03 0.95 0.67 ...
    ##  $ PHDI     : num  -1.37 -1.95 -1.77 -1.89 -2.11 -1.79 -1.11 1.03 0.95 0.67 ...
    ##  $ ZNDX     : num  -0.9 -2.17 -0.07 -0.92 -1.25 0.33 1.49 1.5 0.07 -0.54 ...
    ##  $ PMDI     : num  -0.4 -1.48 -1.28 -1.63 -2.11 -1.57 -0.15 1.03 0.89 0.09 ...
    ##  $ CDD      : int  0 0 0 0 3 62 95 73 12 0 ...
    ##  $ HDD      : int  1296 868 900 678 343 113 30 45 227 555 ...
    ##  $ SP01     : num  -0.4 -1.78 0.89 -0.56 -0.35 0.65 0.96 0.7 -0.01 -0.26 ...
    ##  $ SP02     : num  -0.47 -1.42 -0.11 0.09 -0.67 0.15 1.01 1.07 0.42 -0.26 ...
    ##  $ SP03     : num  0.05 -1.28 -0.36 -0.56 -0.19 -0.28 0.55 1.11 0.78 0.13 ...
    ##  $ SP06     : num  0.42 0.15 0.03 -0.47 -0.86 -0.48 -0.03 0.51 0.24 0.35 ...
    ##  $ SP09     : num  0.41 0.11 0.85 -0.07 -0.07 -0.19 -0.02 0 0.03 0.01 ...
    ##  $ SP12     : num  0.69 0.41 0.43 0.08 -0.06 0.39 0.19 0.49 0.21 0.03 ...
    ##  $ SP24     : num  -0.41 -0.72 -0.49 -0.37 -0.26 -0.24 -0.06 0.12 0.05 0.11 ...
    ##  $ TMIN     : num  9.5 17.7 22.3 28.4 39.3 48.1 52 51.6 43.1 31.9 ...
    ##  $ TMAX     : num  34.3 47.4 47.5 55.3 67.7 76.9 81.1 79.5 72 62.9 ...
    ##  $ X        : logi  NA NA NA NA NA NA ...

Using `head()` or `str()` allows us to view a sampling of our data. One of the 
first things we always check is if the format the R interpreted the data is the 
format we want. 

The Palmer Drought Severity Index (PDSI) is a number, which is good! 

## Date Fields

Let's have a look at the date field in our data: `YearMonth`. Viewing the 
structure, it appears as if it is not in a standard format. It imported into R 
as an integer (`int`).

`$ YearMonth: int  199001 199002 199003 199004 199005  ...`

We want to convert these numbers into a date field. We might be able to use the 
`as.Date` function to convert our string of numbers into a date that `R` will 
recognize.


    # convert to date, and create a new Date column 
    nCLIMDIV$Date <- as.Date(nCLIMDIV$YearMonth, format="%Y%m")

    ## Error in as.Date.numeric(nCLIMDIV$YearMonth, format = "%Y%m"): 'origin' must be supplied

Oops, that doens't work!  R returned an origin error. The Date class is built on having 
day, month, and year data. `R` needs a day of the month in order to properly 
convert this to a date class. The origin error is saying it doens't know where 
to start counting the dates. (Note: If you have the `zoo` package installed you 
will not get this error, but `Date` will be filled with NAs.)

We can add a "day" to our YearMonth data using the `paste0` function. Let's add
`01` to each field so `R` thinks each date represents the first of the month.


    #add a day of the month to each year-month combination
    nCLIMDIV$Date <- paste0(nCLIMDIV$YearMonth,"01")
    
    #convert to date
    nCLIMDIV$Date <- as.Date(nCLIMDIV$Date, format="%Y%m%d")
    
    # check to see it works
    str(nCLIMDIV)

    ## 'data.frame':	300 obs. of  22 variables:
    ##  $ StateCode: int  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ Division : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ YearMonth: int  199101 199102 199103 199104 199105 199106 199107 199108 199109 199110 ...
    ##  $ PCP      : num  0.8 0.44 1.98 1.27 1.63 1.88 2.69 2.44 1.36 1.06 ...
    ##  $ TAVG     : num  21.9 32.5 34.9 41.9 53.5 62.5 66.5 65.5 57.5 47.4 ...
    ##  $ PDSI     : num  -1.37 -1.95 -1.77 -1.89 -2.11 0.11 0.6 1.03 0.95 0.67 ...
    ##  $ PHDI     : num  -1.37 -1.95 -1.77 -1.89 -2.11 -1.79 -1.11 1.03 0.95 0.67 ...
    ##  $ ZNDX     : num  -0.9 -2.17 -0.07 -0.92 -1.25 0.33 1.49 1.5 0.07 -0.54 ...
    ##  $ PMDI     : num  -0.4 -1.48 -1.28 -1.63 -2.11 -1.57 -0.15 1.03 0.89 0.09 ...
    ##  $ CDD      : int  0 0 0 0 3 62 95 73 12 0 ...
    ##  $ HDD      : int  1296 868 900 678 343 113 30 45 227 555 ...
    ##  $ SP01     : num  -0.4 -1.78 0.89 -0.56 -0.35 0.65 0.96 0.7 -0.01 -0.26 ...
    ##  $ SP02     : num  -0.47 -1.42 -0.11 0.09 -0.67 0.15 1.01 1.07 0.42 -0.26 ...
    ##  $ SP03     : num  0.05 -1.28 -0.36 -0.56 -0.19 -0.28 0.55 1.11 0.78 0.13 ...
    ##  $ SP06     : num  0.42 0.15 0.03 -0.47 -0.86 -0.48 -0.03 0.51 0.24 0.35 ...
    ##  $ SP09     : num  0.41 0.11 0.85 -0.07 -0.07 -0.19 -0.02 0 0.03 0.01 ...
    ##  $ SP12     : num  0.69 0.41 0.43 0.08 -0.06 0.39 0.19 0.49 0.21 0.03 ...
    ##  $ SP24     : num  -0.41 -0.72 -0.49 -0.37 -0.26 -0.24 -0.06 0.12 0.05 0.11 ...
    ##  $ TMIN     : num  9.5 17.7 22.3 28.4 39.3 48.1 52 51.6 43.1 31.9 ...
    ##  $ TMAX     : num  34.3 47.4 47.5 55.3 67.7 76.9 81.1 79.5 72 62.9 ...
    ##  $ X        : logi  NA NA NA NA NA NA ...
    ##  $ Date     : Date, format: "1991-01-01" "1991-02-01" ...

We've now successfully converted our integar class `YearMonth` column into the 
`Date` column in a date class. 

## Plot the Data
Next, let's plot the data using `ggplot`.


    # plot the Palmer Drought Index (PDSI)
    palmer.drought <- ggplot(data=nCLIMDIV,
    												 aes(Date,PDSI)) +  # x is Date & y is drought index
    	geom_bar(stat="identity",position = "identity") +   # bar plot 
           xlab("Date") + ylab("Palmer Drought Severity Index") +  # axis labels
           ggtitle("Palmer Drought Severity Index - Colorado \n 1991-2015")   # title on 2 lines (\n)
    
    # view the plot
    palmer.drought

![ ]({{ site.baseurl }}/images/rfigsdisturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/create-quick-palmer-plot-1.png)

Great - we've successfully created a plot! 

#### Questions
1. Are positive or negative values years of drought? 
1. Were the months leading up to the September 2013 floods
1. What overall patterns do you see in "wet" and "dry" years over these 25 years? 
1. Is the average year in Colorado wet or dry? 
1. Are there more wet years or dry years?  

These last two questions are a bit hard to determine from this plot. Let's look 
at a quick summery of our data to help us out.


    #view summary stats of the Palmer Drought Severity Index
    summary(nCLIMDIV$PDSI)

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##  -9.090  -1.703   0.180  -0.310   1.705   5.020

    #view histogram of the data
    hist(nCLIMDIV$PDSI,   # the date we want to use
         main="Histogram of PDSI",  # title
    		 xlab="Palmer Drought Severity Index (PDSI)",  # x-axis label
         col="wheat3")  #  the color of the bars

![ ]({{ site.baseurl }}/images/rfigsdisturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/summary-stats-1.png)

Now we can see there there are "median" year is slightly wetter (0.180) but the 
"mean" year is slightly dry (-0.310) but both are within the "near-normal" range
of -0.41 to 0.41.  
We can also see that there is a longer tail on the dry side of the histogram 
than on the wet side. 
Yet both of these figures only give us a static view of the data.  There are 
package in R that allow us to create interactive figures that can be published
to the web and 

## Plotly - Free Online Interactive Plots
<a href="https://plot.ly/" target="_blank" >Plotly </a> 
bills itself as "a collaborative platform for modern data science". We 
are using it here as we can build an interactive plot that can easily be shared
with others (like on our Disturbance Events lesson 
<a href="http://{{ site.baseurl }}/teaching-module/disturb-event-co13/1hr-lesson#drought). 

You will need an free online Plotly account to post & share you plot online. 
If you do not wish to share plots online you can skip to **Step 3: Create Plotly ggplot**. 

#### Step 1: Create account


#### Step 2: Connect account to R 

Note: Plotly doesn't just work with R -- other programs include Python, MATLAB,
Excel, and JavaScript. 

#### Step 3: Create Plotly ggplot

We can create an interactive version of our plot using `plot.ly`.


    # Use exisitng ggplot plot & view as plotly plot in R
    # note - plotly doesn't recognize \n to create a second title line
    palmer.drought_plotly <- ggplotly(palmer.drought)  
    palmer.drought_plotly

    ## Error in html_screenshot(x): Please install the webshot package (if not on CRAN, try devtools::install_github("wch/webshot"))

    # publish plotly plot to your plot.ly online account when you are happy with it
    # skip this step if you haven't connected a Plotly account
    plotly_POST(palmer.drought_plotly)

    ## Warning: You need a plotly username. See help(signup, package = 'plotly')

    ## Warning: Couldn't find username

    ## Warning: You need an api_key. See help(signup, package = 'plotly')

    ## Warning: Couldn't find api_key

    ## No encoding supplied: defaulting to UTF-8.

    ## Aw, snap! We don't have an account for ''. Want to try again? You can authenticate with your email address or username. Sign in is not case sensitive.
    ## 
    ## Don't have an account? plot.ly
    ## 
    ## Questions? support@plot.lyFALSE

    ## Success! Modified your plotly here ->

<iframe src=".embed" width="800" height="600" id="igraph" scrolling="no" seamless="seamless" frameBorder="0"> </iframe>


## Subsetting Data

Once we have a column of data defined as a Date class in R, we can quickly subset
the data to view portions of the data. We can subset the data directly in our
`ggplot()` plotting function, however that will not translate to `plot.ly`. 
So let's create a new R object that is represents drought data from 2005-2015.

We will then plot that using `ggplot` and `plot.ly`.

To subset, we use the `subset` function, and specify:

1. the R object that we wish to subset
2. the date column and start date of the subset
3. the date column and end date of the subset

Let's subset our data.


    #subset out date between 2005 and 2015 
    drought2005.2015 <- subset(drought, 
                            YearMonth >= as.Date('2005-01-01', tz = "America/Denver") &
                            YearMonth <= as.Date('2015-11-01', tz = "America/Denver"))

    ## Error in subset(drought, YearMonth >= as.Date("2005-01-01", tz = "America/Denver") & : object 'drought' not found

    #plot the data - September-October
    droughtPlot.2005.2015 <- ggplot(data=drought2005.2015,
            aes(YearMonth,PDSI)) +
             geom_bar(stat="identity",position = "identity") +
           xlab("Year / Month") + ylab("Palmer Drought Severity Index") +
           ggtitle("Palmer Drought Severity Index - Colorado\n2005 - 2015")

    ## Error in ggplot(data = drought2005.2015, aes(YearMonth, PDSI)): object 'drought2005.2015' not found

    droughtPlot.2005.2015 

    ## Error in eval(expr, envir, enclos): object 'droughtPlot.2005.2015' not found

    #view plotly plot in R
    ggplotly()

    ## Error in html_screenshot(x): Please install the webshot package (if not on CRAN, try devtools::install_github("wch/webshot"))

    #publish plotly plot to your plot.ly online account when you are happy with it
    plotly_POST(droughtPlot.plotly)

    ## Error in plotly_build(x): object 'droughtPlot.plotly' not found

# Need to remember where i got the data from. I have a feeling all could be 
accessed via the API!! but i can't remember how i found PDSI.

This is my order url - but it's expired.
http://www1.ncdc.noaa.gov/pub/orders/CDODiv5787606888799.txt

drought <- read.


# Challenge

Repeat but with the Divisional data (CO-04 Platte River Drainage). do you get a different pattern by looking at a different scale? 

# Soil Moisture

** we could get this from NDCD as well
Boulder station w Soil Moisture:
https://www.drought.gov/drought/content/tools/crn-soil-data#

CRN Station
ID: 1045
LAT:40.0354
LON:-105.54090000000001
Name: BOULDER 14 W
View Data




## Extra Help
It appears as if we have a negative value `-99.99` that is throwing off our plot. 
This value is a `no data` value. We need to assign this value to `NA`, which is `R`'s 
representation of a null or no data value. 

Then we can plot again!


    nCLIMDIV_US <- read.csv("disturb-events-co13/drought/CDODiv5138116888828_US.txt", header = TRUE)
    
    #add a day of the month to each year-month combination
    nCLIMDIV_04$Date <- paste0(nCLIMDIV_04$YearMonth,"01")
    
    #convert to date
    nCLIMDIV_04$Date <- as.Date(nCLIMDIV_04$Date, format="%Y%m%d")
    
    # check to see it works
    str(nCLIMDIV_04)

    ## 'data.frame':	289 obs. of  22 variables:
    ##  $ StateCode: int  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ Division : int  4 4 4 4 4 4 4 4 4 4 ...
    ##  $ YearMonth: int  199101 199102 199103 199104 199105 199106 199107 199108 199109 199110 ...
    ##  $ PCP      : num  0.57 0.27 1.24 1.47 2.44 2.5 3.04 2.25 0.99 0.69 ...
    ##  $ TAVG     : num  23.1 34.1 35.8 41.9 53.7 63 66.8 65.6 57.5 46.4 ...
    ##  $ PDSI     : num  -0.53 -1.14 -1.51 -1.83 -2.09 -0.03 0.33 0.56 -0.27 -0.53 ...
    ##  $ PHDI     : num  -0.53 -1.14 -1.51 -1.83 -2.09 -1.9 -1.37 -0.97 -1.14 -1.31 ...
    ##  $ ZNDX     : num  -0.7 -2 -1.46 -1.42 -1.33 -0.09 1 0.79 -0.82 -0.87 ...
    ##  $ PMDI     : num  -0.53 -1.14 -1.51 -1.83 -2.09 -1.87 -0.81 0 -0.51 -0.98 ...
    ##  $ CDD      : int  0 0 0 0 0 54 85 64 10 0 ...
    ##  $ HDD      : int  1299 865 905 693 354 114 29 46 235 577 ...
    ##  $ SP01     : num  -0.28 -1.72 0.15 -0.39 0.13 0.77 1.09 0.6 -0.24 -0.52 ...
    ##  $ SP02     : num  -0.88 -1.33 -0.77 -0.39 -0.3 0.52 1.17 1.07 0.14 -0.7 ...
    ##  $ SP03     : num  -0.23 -1.6 -0.87 -0.9 -0.32 0.1 0.85 1.17 0.6 -0.26 ...
    ##  $ SP06     : num  0.37 -0.1 -0.46 -0.9 -0.91 -0.29 0.15 0.48 0.38 0.41 ...
    ##  $ SP09     : num  0.13 0.01 0.67 -0.3 -0.4 -0.23 0.06 0.11 0.09 -0.02 ...
    ##  $ SP12     : num  0.52 0.36 -0.22 -0.27 -0.22 0.51 0.33 0.38 0.09 -0.08 ...
    ##  $ SP24     : num  -0.07 -0.28 -0.19 -0.07 0.13 0.14 0.36 0.49 0.24 0.27 ...
    ##  $ TMIN     : num  10.2 19.1 22.4 28.6 39.6 48.3 51.9 51.1 42.1 30.2 ...
    ##  $ TMAX     : num  36.1 49.1 49.1 55.2 67.9 77.8 81.7 80.2 72.9 62.6 ...
    ##  $ X        : logi  NA NA NA NA NA NA ...
    ##  $ Date     : Date, format: "1991-01-01" "1991-02-01" ...

    palmer.drought04 <- ggplot(data=nCLIMDIV_04,
    												 aes(Date,PDSI)) +  # x is Date & y is drought index
    	geom_bar(stat="identity",position = "identity") +   # bar plot 
           xlab("Date") + ylab("Palmer Drought Severity Index") +  # axis labels
           ggtitle("Palmer Drought Severity Index - Colorado")   # title
    
    palmer.drought04

![ ]({{ site.baseurl }}/images/rfigsdisturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/unnamed-chunk-1-1.png)

    #assign -99.99 to NA in the PDSI column
    #note: you may want to do this across the entire data.frame or with other columns.
    drought[nCLIMDIV_04$PDSI==-99.99,] <-  NA

    ## Error in drought[nCLIMDIV_04$PDSI == -99.99, ] <- NA: object 'drought' not found

    #view the histogram again - does the range look reasonable?
    hist(drought$PDSI,
         main="Histogram of PDSI value with -99.99 removed",
         col="springgreen4")

    ## Error in hist(drought$PDSI, main = "Histogram of PDSI value with -99.99 removed", : object 'drought' not found

    #plot Palmer Drought Index
    ggplot(data=drought,
           aes(YearMonth,PDSI)) +
           geom_bar(stat="identity",position = "identity") +
           xlab("Year") + ylab("Palmer Drought Severity Index") +
           ggtitle("Palmer Drought Severity Index - Colorado\n1990 to 2015")

    ## Error in ggplot(data = drought, aes(YearMonth, PDSI)): object 'drought' not found
