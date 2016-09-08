---
layout: post
title: "Visualize Palmer Drought Severity Index in 
R to Better Understand the 2013 Colorado Floods"
date: 2015-12-07
authors: [Leah A. Wasser, Megan A. Jones, Mariela Perignon]
dateCreated: 2015-05-18
lastModified: 2016-09-08
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

### Goals / Objectives
After completing this tutorial, you will be able to:

* Download Palmer Drought Severity Index (and related indicies) data from <a href="http://www7.ncdc.noaa.gov/CDO/CDODivisionalSelect.jsp" target="_blank"> NOAA's Climate Divisional Database (nCLIMDIV)</a>. 
* Plot Palmer Drought Severity Index data in R. 
* Publish & share an interactive plot of the data using Plotly. 
* Subset data by date (if completing Additional Resource code).
* Set a NoData Value to NA in R (if completing Additional Resource code).

### Things You'll Need To Complete This Lesson
Please be sure you have the most current version of R and, preferably,
RStudio to write your code.

 **R Skill Level:** Intermediate - you've got the basics of R down.

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


#### Prerequisite Knowledge 
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
bills itself as "a collaborative platform for modern data science". We 
are using it here as we can build an interactive plot that can easily be shared
with others (like on our
<a href="http://{{ site.baseurl }}/teaching-module/disturb-event-co13/1hr-lesson#drought"> target="_blank"> Disturbance Events lesson</a>). 

Plotly allows you to create interactive plots that can also be shared online. You will need an free online Plotly account to post & share you plot online. But you
can create the plots and use them on your local computer without an account. If 
you do not wish to share plots online you can skip to **Step 3: Create Plotly plot**. 

Additional information on the Plotly R package can be found 
<a href="https://plot.ly/r/getting-started/" target="_blank"> on the Plotly R Getting Started page</a>.  

Note: Plotly doesn't just work with R -- other programs include Python, MATLAB,
Excel, and JavaScript. 

### Step 1: Create account
If you do not already have an account, you need to set up an account by visiting
the <a href="https://plot.ly/" target="_blank" >Plotly</a> website.

### Step 2: Connect account to R 

To share plots from R (or RStudio) to Plotly, you have to connect to your 
account.  This is done through an API (Application Program Interface). You can
find your username & API key under your Profile on the Plotly website under the
"API key" menu option.  

To link your account to your R, use the following commands, substituting in your
own username & key as appropriate. 


    # set plotly user name
    Sys.setenv("plotly_username"="YOUR_plotly_username")
    # set plotly API key
    Sys.setenv("plotly_api_key"="YOUR_api_key")

### Step 3: Create Plotly plot

We can create an interactive version of our plot using `plot.ly`.

We should simply be able to use our existing ggplot `palmer.drought` with the 
`ggplotly()` function to 

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

### Step 4: Push to Plotly online

Once the plot is built with a Plotly related function (`plot_ly` or `ggplotly`)
you can post the plot to your online account. Make sure you are signed in to
complete this step. 


    # publish plotly plot to your plot.ly online account when you are happy with it
    # skip this step if you haven't connected a Plotly account
    
    plotly_POST(palmer.drought_plotly)

<iframe src="https://plot.ly/~mjones01/4.embed" width="800" height="600" id="igraph" scrolling="no" seamless="seamless" frameBorder="0"> </iframe>

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




## Challenge: Do different measures show the same pattern?

In the nCLIMDIV data set we have not only the Palmer Drought Severity Index, but 
also several other measures of precipitation, drought, or temperature. Choose one
and repeat the above steps to see if a different, but related measure shows a 
similar pattern. Make sure to go back to the metadata so that you understand what
the Index or measurement represents.  




## Additional Resources

### No Data Values
If you choose to explore other time frames or spatial scales you may come across
data that appear as if they have a negative value `-99.99` -- a *very severe*
drought!  

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/palmer-NDV-plot-only-1.png)

No, this value is a common placeholder for a **No Data Value**. 

Think about what happens if the instruments failed for a little while, one can't 
record 0 for this Index because 0 means "normal" levels. And using a blank isn't 
a good idea for several reason: they cause problems for software reading a file,
they can mess up table structure, and you don't know if the data was missing
(someone forgot to enter it) or if no data were available. Therefore, a 
placeholder value is often used instead. This value changes between disciplines 
but `-9999` or `-99.99` are common.  

In R, we need to assign this NoData value to `NA`, which is R's 
representation of a null or no data value. Then when the calculations are performed
or plots are created R will correctly interpret, and not plot, the value. 

Using the nCLIMDIV data set from the entire US, this is how we'd assign the NoData
value to NA and plot the data.


    # NoData Value in the nCLIMDIV data from 1990-2015 US spatial scale 
    nCLIMDIV_US <- read.csv("disturb-events-co13/drought/CDODiv5138116888828_US.txt", header = TRUE)
    
    # add a day of the month to each year-month combination
    nCLIMDIV_US$Date <- paste0(nCLIMDIV_US$YearMonth,"01")
    
    # convert to date
    nCLIMDIV_US$Date <- as.Date(nCLIMDIV_US$Date, format="%Y%m%d")
    
    # check to see it works
    str(nCLIMDIV_US$Date)

    ##  Date[1:312], format: "1990-01-01" "1990-02-01" "1990-03-01" "1990-04-01" ...

    # view histogram of data -- great way to check the data range
    hist(nCLIMDIV_US$PDSI,
         main="Histogram of PDSI values",
         col="springgreen4")

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/palmer-no-data-values-1.png)

    # easy to see the "wrong" values near 100
    # check for these values using min() - what is the minimum value?
    min(nCLIMDIV_US$PDSI)

    ## [1] -99.99

    # assign -99.99 to NA in the PDSI column
    # Note: you may want to do this across the entire data.frame or with other columns
    # but check out the metadata -- there are different NoData Values for each column!
    nCLIMDIV_US[nCLIMDIV_US$PDSI==-99.99,] <-  NA  # == is the short hand for "it is"
    
    #view the histogram again - does the range look reasonable?
    hist(nCLIMDIV_US$PDSI,
         main="Histogram of PDSI value with NA value assigned",
         col="springgreen4")

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/palmer-no-data-values-2.png)

    # that looks better!  
    
    #plot Palmer Drought Index data
    ggplot(data=nCLIMDIV_US,
           aes(Date,PDSI)) +
           geom_bar(stat="identity",position = "identity") +
           xlab("Year") + ylab("Palmer Drought Severity Index") +
           ggtitle("Palmer Drought Severity Index - Colorado\n1991 thru 2015")

    ## Warning: Removed 2 rows containing missing values (geom_bar).

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/palmer-no-data-values-3.png)

    # The warning message lets you know that two "entries" will be missing from the
    # graph -- these are the ones we assigned NA. 

### Subsetting Data

After you have downloaded the data, you might decide that you want to plot only
a subset of the data range you downloaded -- say just the decade 2005 to 2015 
instead of 1990 to 2015. With the Plotly interactive plots you can zoom in on 
that section, but even so you might want a plot with only a section of the data.

You could re-download the data with a new search, but that makes for extra, 
possibly confusing, data files! Instead we can easily subset the data. Once we 
have a column of data defined as a Date class in R, we can quickly 
subset the data by date and create a new R object using the `subset()` function. 

To subset, we use the `subset` function, and specify:

1. the R object that we wish to subset,
2. the date column and start date of the subset, and
3. the date column and end date of the subset.

Let's subset the data.


    # subset out data between 2005 and 2015 
    nCLIMDIV2005.2015 <- subset(nCLIMDIV,    # our R object dataset 
                            Date >= as.Date('2005-01-01') &  # start date
                            Date <= as.Date('2015-12-31'))   # end date
    
    # check to make sure it worked
    head(nCLIMDIV2005.2015$Date)  # head() shows first 6 lines

    ## [1] "2005-01-01" "2005-02-01" "2005-03-01" "2005-04-01" "2005-05-01"
    ## [6] "2005-06-01"

    tail(nCLIMDIV2005.2015$Date)  # tail() shows last 6 lines

    ## [1] "2015-07-01" "2015-08-01" "2015-09-01" "2015-10-01" "2015-11-01"
    ## [6] "2015-12-01"

Now we can plot this decade of data. Hint, we can copy/paste and edit the 
previous code.


    # use plotly function to create plot
    palmer_plotly0515 <- plot_ly(nCLIMDIV2005.2015,    # the R object dataset
    				type= "bar", # the type of graph desired
    				x=Date,      # our x data 
    				y=PDSI,      # our y data
    				orientation="v",   # for bars to orient vertically ("h" for horizontal)
            title=("Palmer Drought Severity Index - Colorado 2005-2015"))
    
    palmer_plotly0515

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/nCLIMDIV-Palmer-Drought-In-R/plotly-decade-1.png)

    # publish plotly plot to your plot.ly online account when you are happy with it
    # skip this step if you haven't connected a Plotly account
    
    plotly_POST(palmer_plotly0515)

    ## No encoding supplied: defaulting to UTF-8.

    ## Success! Modified your plotly here -> https://plot.ly/~mjones01/4

<iframe src="https://plot.ly/~mjones01/4.embed" width="800" height="600" id="igraph" scrolling="no" seamless="seamless" frameBorder="0"> </iframe>

