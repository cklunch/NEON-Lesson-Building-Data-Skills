---
layout: post
title: "Visualize Palmer Drought Severity Index Data in 
R to Better Understand the 2013 Colorado Floods"
date: 2015-12-07
authors: [Leah A. Wasser, Megan A. Jones, Mariela Perignon]
dateCreated: 2015-05-18
lastModified: 2016-10-13
categories: [Coding and Informatics]
category: coding-and-informatics
tags: [R, time-series]
mainTag: disturb-co
scienceThemes: [phenology, disturbance]
description: "This tutorial walks through how to download and visualize Palmer
Drought Severity Index data in R. The data specifically downloaded for 
this activity allows one to to better understand a driver of the 2013 Colorado
floods."
image:
  feature: TeachingModules.jpg
  credit: A National Ecological Observatory Network (NEON)
  creditlink: http://www.neonscience.org
permalink: /R/nCLIMDIV-Palmer-Drought-Data-R
code1: nCLIMDIV-Palmer-Drought-In-R.R
comments: true
---

{% include _toc.html %}

This tutorial focuses on how to visualize Palmer Drought Severity Index data in 
R and Plot.ly. The tutorial is part of the Data Activity packages that can be used 
with the 
<a href="{{ site.basurl }}teaching-module/disturb-event-co13/1hr-overview" target="_blank"> Ecological Disturbance Teaching Modules. 

<div id="objectives" markdown="1">

### Learning Objectives
After completing this tutorial, you will be able to:

* Download Palmer Drought Severity Index (and related indicies) data from <a href="http://www7.ncdc.noaa.gov/CDO/CDODivisionalSelect.jsp" target="_blank"> NOAA's Climate Divisional Database (nCLIMDIV)</a>. 
* Plot Palmer Drought Severity Index data in R. 
* Publish & share an interactive plot of the data using Plotly. 
* Subset data by date (if completing Additional Resources code).
* Set a NoData Value to NA in R (if completing Additional Resources code).

### Things You'll Need To Complete This Lesson
Please be sure you have the most current version of R and, preferably,
RStudio to write your code.

 **R Skill Level:** Intermediate - To succeed in this tutorial, you will need to
have basic knowledge for use of the R software program.   

#### R Libraries to Install:

* **ggplot2:** `install.packages("ggplot2")`
* **lubridate:** `install.packages("lubridate")`
* **plotly:** `install.packages("plotly")`

#### Data Download & Directory Preparation

Part of the lesson is to access and download the data directly from NOAA's National 
Climate Divisional Database. If you are unable to follow the directions or would 
like to pre-download the data set it can be downloaded from XXXX.  

So that we all have organized data in the same location, create a `data` directory 
(folder) within your `Documents` directory. Within `data`, create another 
directory `distub-events-co13`and then within it create a `drought` directory.  

If you are using the provided data (downloaded above) simply put the 
entire unzipped directory in the `data` directory you just created. If you choose to save 
elsewhere you will need to modify the directions below to set your working 
directory accordingly.

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

Skim through this metadata file. 
* Can you find out what the `StateCode` is?  
* What other information is important or interesting to you?  
* We are interested in the Palmer Drought Severity Index. What information are 
does the metadata give you about this Index? 

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

    ## Warning in file(file, "rt"): cannot open file 'disturb-events-co13/drought/
    ## CDODiv8506877122044_CO.txt': No such file or directory

    ## Error in file(file, "rt"): cannot open the connection

    # view data structure
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

Oops, that doens't work!  R returned an origin error. The Date class is built on
having  day, month, and year data. `R` needs a day of the month in order to properly 
convert this to a date class. The origin error is saying it doens't know where 
to start counting the dates. (Note: If you have the `zoo` package installed you 
will not get this error, but `Date` will be filled with NAs.)

We can add a "day" to our `YearMonth` data using the `paste0` function. Let's 
add `01` to each field so `R` thinks each date represents the first of the
month.


    #add a day of the month to each year-month combination
    nCLIMDIV$Date <- paste0(nCLIMDIV$YearMonth,"01")
    
    #convert to date
    nCLIMDIV$Date <- as.Date(nCLIMDIV$Date, format="%Y%m%d")
    
    # check to see it works
    str(nCLIMDIV$Date)

    ##  Date[1:300], format: "1991-01-01" "1991-02-01" "1991-03-01" "1991-04-01" ...

We've now successfully converted our integar class `YearMonth` column into the 
`Date` column in a date class. 

## Plot the Data
Next, let's plot the data using `ggplot()`.


    # plot the Palmer Drought Index (PDSI)
    palmer.drought <- ggplot(data=nCLIMDIV,
    			 aes(Date,PDSI)) +  # x is Date & y is drought index
    	     geom_bar(stat="identity",position = "identity") +   # bar plot 
           xlab("Date") + ylab("Palmer Drought Severity Index") +  # axis labels
           ggtitle("Palmer Drought Severity Index - Colorado \n 1991-2015")   # title on 2 lines (\n)
    
    # view the plot
    palmer.drought

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/create-quick-palmer-plot-1.png)

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

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/summary-stats-1.png)

Now we can see there there are "median" year is slightly wetter (0.180) but the 
"mean" year is slightly dry (-0.310) but both are within the "near-normal" range
of -0.41 to 0.41.  
We can also see that there is a longer tail on the dry side of the histogram 
than on the wet side. 
Yet both of these figures only give us a static view of the data.  There are 
package in R that allow us to create interactive figures that can be published
to the web and 

## Plotly - Interactive (and Online) Plots

<a href="https://plot.ly/" target="_blank" >Plotly </a> 
allows you to create interactive plots that can also be shared online. If
you are new to Plotly, view the companion mini-lesson 
<a href="{{ site.baseurl }}/R/Plotly/" target="_blank"> *Interactive Data Vizualization with R and Plotly*</a>
to learn how to set up an account and access your username and API key. 

### Step 1: Connect account to R 

First, we need to connect our R session to our Plotly account. If you only want 
to create interactive plots and not share them on a Plotly account, you can skip
this step.  


    # set plotly user name
    Sys.setenv("plotly_username"="YOUR_plotly_username")
    # set plotly API key
    Sys.setenv("plotly_api_key"="YOUR_api_key")

### Step 2: Create Plotly plot

We can create an interactive version of our plot using `plot.ly`.

We should simply be able to use our existing ggplot `palmer.drought` with the 
`ggplotly()` function to create an interactive plot. 


    # Use exisitng ggplot plot & view as plotly plot in R
    palmer.drought_ggplotly <- ggplotly(palmer.drought)  
    palmer.drought_ggplotly

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/create-ggplotly-drought-1.png)

But that doesn't look right! In the current `plotly` package there is a bug! This
bug has been reported and a fix may come out in future updates to the package!

Until that happens, we can build our plot again using the `plot_ly()` function.  
In the future, you could just skip the `ggplot()` step and plot directly with 
`plot_ly()`. 


    # use plotly function to create plot
    palmer.drought_plotly <- plot_ly(nCLIMDIV,    # the R object dataset
    	type= "bar", # the type of graph desired
    	x=Date,      # our x data 
    	y=PDSI,      # our y data
    	orientation="v",   # for bars to orient vertically ("h" for horizontal)
    	title=("Palmer Drought Severity Index - Colorado 1991-2015"))
    
    palmer.drought_plotly

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/create-plotly-drought-plot-1.png)

#### Questions
Check out the differences between the `ggplot()` and the `plot_ly()` plot.

* From both plots, answer these questions (Hint: Hover your cursor over the bars
of the `plotly` plot.)
1. What is the minimum value?
1. In what month did the lowest PDSI occur?
1. In what month, and in what magnitude, did the highest PDSI occur?
1. What was the drought severity value in August 2013, the month before the
flooding? 
* Contrast `ggplot()` and `plot_ly()` functions.
1. What are the biggest differences you see between `ggplot` & `plot_ly` function?
1. When might you want to use `ggplot()`?
1. When might `plotly()` be better? 

### Step 3: Push to Plotly online

Once the plot is built with a Plotly related function (`plot_ly` or `ggplotly`)
you can post the plot to your online account. Make sure you are signed in to
complete this step. 


    # publish plotly plot to your plot.ly online account when you are happy with it
    # skip this step if you haven't connected a Plotly account
    
    plotly_POST(palmer.drought_plotly)

    ## Warning: You need a plotly username. See help(signup, package = 'plotly')

    ## Warning: Couldn't find username

    ## Warning: You need an api_key. See help(signup, package = 'plotly')

    ## Warning: Couldn't find api_key

<iframe src=".embed" width="800" height="600" id="igraph" scrolling="no" seamless="seamless" frameBorder="0"> </iframe>

#### Questions
Now that we can see the online Plotly user interface, we can explore our plots
a bit more. 

1. Each plot that is added can have comments added (below the plot), what would
be appropriate information to add for this plot? 
1. Who might you want to share this plot with? What tools are there to share this
plot? 


## Challenge: Does spatial scale affect the pattern? 

In the steps above we have been looking at data aggregated across the entire
state of Colorado. What if we look just the watershed that includes the Boulder,
Colorado area where our investigation is centered?

If you zoom in on the 
<a href="http://gis.ncdc.noaa.gov/map/viewer/#app=cdo&cfg=cdo&theme=indices&layers=01&node=gis" target="_blank"> Divisional Map</a>,
you can see that Boulder, CO is in the **CO-04 Platte River Drainage**. 

Use the divisional data and the process you've just learned to create a plot of
the PDSI for Colorado Division 04 to compare to the plot for the state of 
Colorado that you've already made. 

If you are using the downloaded dataset accompanying this lesson, this data can be 
found at "drought/CDODiv8868227122048_COdiv04.txt".  













