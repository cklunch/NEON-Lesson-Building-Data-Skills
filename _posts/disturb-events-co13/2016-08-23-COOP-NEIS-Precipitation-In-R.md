---
layout: post
title: "Data Activity: Visualize Precipitation Data in R to Better Understand the 2013 Colorado Floods"
date: 2016-04-06
authors: [Megan A. Jones, Leah A. Wasser, Mariela Perignon]
dateCreated: 2015-05-18
lastModified: 2016-10-31
categories: [teaching-module]
tags: [R, time-series]
mainTag: disturb-event-co13
scienceThemes: [disturbance]
description: "This lesson walks through the steps need to download and visualize
precipitation data in R to better understand the drivers and impacts of the 2013 
Colorado floods."
image:
  feature: TeachingModules.jpg
  credit: A National Ecological Observatory Network (NEON) - Teaching Module
  creditlink: http://www.neonscience.org
permalink: /R/COOP-precip-data-R
code1: 
comments: true
---

{% include _toc.html %}

Several factors contributed to extreme flooding that occurred in Boulder,
Colorado in 2013. In this data activity, we explore and visualize the data for 
precipitation (rainfall) data collected by the National Weather Service's 
Cooperative Observer Program. 

<div id="objectives" markdown="1">

### Learning Objectives
After completing this tutorial, you will be able to:

* Download precipitation data from 
<a href="http://www.ncdc.noaa.gov/" target="_blank">NOAA's National Centers for Environmental Information</a>. 
* Plot precipitation data in R. 
* Publish & share an interactive plot of the data using Plotly. 
* Subset data by date (if completing Additional Resources code).
* Set a NoData Value to NA in R (if completing Additional Resources code). 

### Things You'll Need To Complete This Lesson
Please be sure you have the most current version of R and, preferably,
RStudio to write your code.

 **R Skill Level:** Intermediate - To succeed in this tutorial, you will need to
have basic knowledge for use of the R software program.  

### R Libraries to Install:

* **ggplot2:** `install.packages("ggplot2")`
* **lubridate:** `install.packages("lubridate")`
* **plotly:** `install.packages("plotly")`

### Data to Download
We include directions on how to directly find and access the data from NOAA's 
National Climate Divisional Database. If you are unable to follow the directions 
or would 
like to pre-download the data set it can be downloaded from the 
<a href="https://ndownloader.figshare.com/files/6780978"> NEON Data Skills account on FigShare</a>. . 

So that we all have organized data in the same location, create a `data` directory 
(folder) within your `Documents` directory.

If you are using the provided data (downloaded above) simply put the 
entire unzipped directory in the `data` directory you just created. If you choose to save 
elsewhere you will need to modify the directions below to set your working 
directory accordingly.

If you want to download data directly from NCDD following the instructions below, 
within `data`, create another directory `distub-events-co13`and then within it 
create a `precip` directory where you will save the data.  

</div>

## Research Question 
What were the patterns of precipitation leading up to the 2013 flooding events
in Colorado? 

## Precipitation Data 
The heavy **precipitation (rain)** that occurred in September 2013 drove the 
many of the flood impacts including increased **stream discharge (flow)**. In 
this lesson we will download, explore, and visualize the precipitation collected
during this time to better understand this important flood driver.

Where can we get precipitation data? 

The precipitation data are obtained through 
 <a href="http://www.ncdc.noaa.gov/" target="_blank">NOAA's National Centers for 
Environmental Information</a> 
(formerly the National Climatic Data Center). There are numerous climatic data
sets that can be searched and downloaded via the 
<a href="http://www.ncdc.noaa.gov/cdo-web/search" target="_blank">Climate Data
Online Search portal</a>. 

The precipitation data that we will use is from the 
<a href="https://www.ncdc.noaa.gov/data-access/land-based-station-data/land-based-datasets/cooperative-observer-network-coop" target="_blank">Cooperative Observer Network (COOP)</a>. 

> "Through the National Weather Service (NWS) Cooperative Observer Program
(COOP), more than 10,000 volunteers take daily weather observations at National 
Parks, seashores, mountaintops, and farms as well as in urban and suburban 
areas. COOP data usually consist of daily maximum and minimum temperatures, 
snowfall, and 24-hour precipitation totals." 
> Quoted from NOAA's National Centers for Environmental Information

Data is collected at different stations, often on paper data sheets like below,
and then entered into a central database where we can access that data and 
download in the .csv (Comma Separated Values) format.

 <figure>
   <a href="{{ site.baseurl }}/images/disturb-events-co13/COOP_SampleDataSheet.png">
   <img src="{{ site.baseurl }}/images/disturb-events-co13/COOP_SampleDataSheet.png"></a>
   <figcaption> An example of the data sheets used to collect the precipitation
   data for the Cooperative Observer Network. Source: Cooperative Observer 
   Network, NOAA
   </figcaption>
</figure>

## Obtain the Data

If you have not already opened the 
<a href="http://www.ncdc.noaa.gov/cdo-web/search" target="_blank">Climate Data
Online Search portal</a>, do so now. 

Note: If you are using the data subset that can be downloaded with this lesson, 
read through this section to know where the data comes from then proceed with 
the lesson. 

#### Step 1: Search for the data
To obtain data we must first choose a location from which we want to get data. 
The COOP site Boulder 2 (Station ID:050843) is centrally located in Boulder, CO. 

 <figure>
   <a href="{{ site.baseurl }}/images/disturb-events-co13/LocationOfPrecipStation.png">
   <img src="{{ site.baseurl }}/images/disturb-events-co13/LocationOfPrecipStation.png"></a>
   <figcaption> Cooperative Observer Network station 050843 is located in 
   central Boulder, CO. Source: National Centers for Environmental Information 
   </figcaption>
</figure>

Then we must decide what type of data we want. As shown in the image below, we 
selected:

* the desired date range (1 January 2003 to 31 December 2013),
* the type of dataset ("Precipitation Hourly"),
* the search type ("Stations") and 
* the search term (e.g. the # for the station located in central Boulder, CO: 050843). 

 <figure>
   <a href="{{ site.baseurl }}/images/disturb-events-co13/NCEI_DownloadData_ScreenShot.png">
   <img src="{{ site.baseurl }}/images/disturb-events-co13/NCEI_DownloadData_ScreenShot.png"></a>
   <figcaption> An example of the data sheets used to collect the precipitation
   data for the Cooperative Observer Network. Source: National Ecological
   Observatory Network (NEON)  
   </figcaption>
</figure>

Once the data is entered and you select `Search`, you will be directed to a 
new page with a map. You can find out more information about the data by selecting
`View Full Details`. 
Notice that this data set goes all the way back to 1 August 1948! However, we've 
selected only a portion of this time frame. 

#### Step 2: Request the data
Once you are sure this is the you want you need to request it by selecting `Add
to Cart`. The data can then be downloaded as a **.csv** file which we will use
to conduct our analyses. Be sure to double check the date range! 

On the options page, we want to make sure we select: 

* Station Name
* Geographic Location (this gives us longitude & latitude; optional)
* Include Data Flags (this gives us information if the data are problematic)
* Units (Standard)
* Precipitation (w/ HPCP automatically checked)

On the next page you must submit your email address for the data set to be sent 
to.  

#### Step 3: Get the data
As this is a small dataset, it won't take long for you to get an email telling 
you the dataset is ready. Follow the link in the email to download your dataset.
You can also view documentation (metadata) the data.  
Each data subset is downloaded with a unique order number.  The order number in 
our example data set is 805325.  If you are using a data set you've downloaded 
yourself, make sure to substitute in your own order number in the code below. 

To ensure that we remember what our data file is, we've added a descriptor to 
the order number: `805325-precip_daily_2003-2013`. You may wish to the same. 

# Work with Precipitation Data

## R Libraries

We will be working with time-series data in this lesson so we will load the
`lubridate` library that allows use to easily work with dates. We will use 
`ggplot2` to efficiently plot our data and `plotly` to create interactive plots.


    # set your working directory
    # setwd("~/Documents/data/disturb-events-co13")  # or your appropriate file path 
    
    # load packages
    #library(lubridate) # work with time series data
    library(ggplot2) # create efficient, professional plots
    library(plotly) # create cool interactive plots



## Import Precipitation Data

We will use the `805325-Preciptation_Daily_2003-2013.csv` file
in this analysis. This dataset is the daily precipitation date from the COOP 
station 050843 in Boulder, CO for 1 January 2003 through 31 December 2013. 

As the data format is a .csv, we can use `read.csv` to import the data. After
we import the data, let's have a look at the first few lines using `head()`, 
which defaults to the first 6 rows, of the `data.frame`. Finally, we can explore
the R object structure.


    # import precip data into R data.frame
    precip.boulder <- read.csv("precip/805325-precip_daily_2003-2013.csv",
                               stringsAsFactors = FALSE,
                               header = TRUE)
    # view first 6 lines of the data
    head(precip.boulder)

    ##       STATION    STATION_NAME ELEVATION LATITUDE LONGITUDE           DATE
    ## 1 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 20030101 01:00
    ## 2 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 20030201 01:00
    ## 3 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 20030202 19:00
    ## 4 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 20030202 22:00
    ## 5 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 20030203 02:00
    ## 6 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 20030205 02:00
    ##   HPCP Measurement.Flag Quality.Flag
    ## 1  0.0                g             
    ## 2  0.0                g             
    ## 3  0.2                              
    ## 4  0.1                              
    ## 5  0.1                              
    ## 6  0.1

    # view structure of data
    str(precip.boulder)

    ## 'data.frame':	1840 obs. of  9 variables:
    ##  $ STATION         : chr  "COOP:050843" "COOP:050843" "COOP:050843" "COOP:050843" ...
    ##  $ STATION_NAME    : chr  "BOULDER 2 CO US" "BOULDER 2 CO US" "BOULDER 2 CO US" "BOULDER 2 CO US" ...
    ##  $ ELEVATION       : num  1650 1650 1650 1650 1650 ...
    ##  $ LATITUDE        : num  40 40 40 40 40 ...
    ##  $ LONGITUDE       : num  -105 -105 -105 -105 -105 ...
    ##  $ DATE            : chr  "20030101 01:00" "20030201 01:00" "20030202 19:00" "20030202 22:00" ...
    ##  $ HPCP            : num  0 0 0.2 0.1 0.1 ...
    ##  $ Measurement.Flag: chr  "g" "g" " " " " ...
    ##  $ Quality.Flag    : chr  " " " " " " " " ...

## About the Data 
Viewing the structure of these data, we can see that different data included in 
this data set. 

* **STATION** and **STATION_NAME**: Identification of the COOP station.
* **ELEVATION, LATITUDE** and **LONGITUDE**: The spatial location of the station.
* **DATE**: Gives the date in the format: YYYYMMDD HH:MM. Notice that DATE is 
currently class `chr`, meaning the data is interpreted as a character class and 
not as a date. 
* **HPCP**: The total precipitation given in inches 
(since we selected `Standard` for the units), recorded
for the hour ending at the time specified by DATE. Importantly, the metadata 
(see below) notes that the value 999.99 indicates missing data. Also important, 
hours with no precipitation are not recorded.
* **Measurement Flag**: Indicates if there are any abnormalities with the 
measurement of the data. Definitions of each flag can be found in Table 2 of the
documentation. 
* **Quality Flag**: Indicates if there are any potential quality problems with 
the data. Definitions of each flag can be found in Table 3 of the documentation. 

Additional information about the data, known as metadata, is available in the 
`PRECIP_HLY_documentation.pdf` file that can be downloaded along with the data. 
(Note, as of Sept. 2016, there is a mismatch in the data downloaded and the
documentation. The differences are in the units and missing data value: 
inches/999.99 (standard) or millimeters/25399.75 (metric)).

## Clean the Data
Before we can start plotting and working with the data we always need to check 
several important factors: 

* data class: is R interpreting the data the way we expect it. The function 
`str()` is an important tools for this. 
* NoData Values: We need to know if our data contains a specific value that 
means "data are missing" and is this value assigned to NA in R. 


### Convert Date-Time
As we've noted the date field is in a character class, we can convert it to a date/time
class which will allow R to correctly interpret the data and allow us to easily 
plot the data. We can convert it to a date/time class using `as.POSIXct()`. 


    # convert to date/time and retain as a new field
    precip.boulder$DateTime <- as.POSIXct(precip.boulder$DATE, 
                                      format="%Y%m%d %H:%M") 
                                      # date in the format: YearMonthDay Hour:Minute 
    
    # double check structure
    str(precip.boulder$DateTime)

    ##  POSIXct[1:1840], format: "2003-01-01 01:00:00" "2003-02-01 01:00:00" ...

* For more information on date/time classes, see the NEON tutorial 
[Dealing With Dates & Times in R - as.Date, POSIXct, POSIXlt ]({{ site.baseurl }}/R/time-series-convert-date-time-class-POSIX/).

### NoData Values
We've also learned that missing values are labelled `999.99`, also known as NoData
values. Do we have any NoData values in our data? 


    # histogram - would allow us to see 999.99 NA values 
    # or other "weird" values that might be NA if we didn't know the NA value
    hist(precip.boulder$HPCP)

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/COOP-NEIS-Precipitation-In-R/no-data-values-hist-1.png)

Yes, it looks like we have mostly low values (which makes sense) but a few values
up near 1000 -- likely 999.99. We can assign these data to be `NA` the value that
R interprets as no data.  


    # assing NoData values to NA
    precip.boulder$HPCP[precip.boulder$HPCP==999.99] <- NA 
    
    # check that NA values were added; 
    # we can do this by finding the sum of how many NA values there are
    sum(is.na(precip.boulder))

    ## [1] 94

There are 94 NA values in our dataset.  This is missing data. 

#### Questions: 

1. Do we need to worry about the missing data?  
1. Could they affect our analyses?  

This depends on what questions we are asking.  For right now we are looking at 
general patterns in the data across 10 years. This means we have just over 3650 
days in our entire data set, missing 94 probably won't affect the general trends
we are looking at.  

Can you think of a research question where we would need to be concerned about
the missing data? 

## Plot Precipitation Data
Now that we've cleaned up the data let's view it. To do this we will plot using 
`ggplot()` from the `ggplot2` package. 


    #plot the data
    precPlot_hourly <- ggplot(data=precip.boulder,  # the data frame
          aes(DateTime, HPCP)) +   # the variables of interest
          geom_bar(stat="identity") +   # create a bar graph
          xlab("Date") + ylab("Precipitation (Inches)") +  # label the x & y axes
          ggtitle("Hourly Precipitation - Boulder Station\n 2003-2013")  # add a title
    
    precPlot_hourly

    ## Warning: Removed 94 rows containing missing values (position_stack).

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/COOP-NEIS-Precipitation-In-R/plot-precip-hourly-1.png)

As we can see, plotting hourly date leads to very small numbers and is difficult
to represent all information on a figure. Hint: If you can't see any bars on your
plot you might need to zoom in on it. 

Plots and comparison of daily precipitation would be easier to view. 

## Plot Daily Precipitation

There are several ways to aggregate the data. 

#### Daily Plots
If you only want to view the data plotted by data you need to create a column
with only dates (no time) and then re-plot. 


    # convert DATE to a Date class 
    # (this will strip the time, but that is saved in DateTime)
    precip.boulder$DATE <- as.Date(precip.boulder$DateTime, # convert to Date class
                                      format="%Y%m%d %H:%M") 
                                      #DATE in the format: YearMonthDay Hour:Minute 
    
    # double check conversion
    str(precip.boulder$DATE)

    ##  Date[1:1840], format: "2003-01-01" "2003-02-01" "2003-02-03" "2003-02-03" ...

    precPlot_daily1 <- ggplot(data=precip.boulder,  # the data frame
          aes(DATE, HPCP)) +   # the variables of interest
          geom_bar(stat="identity") +   # create a bar graph
          xlab("Date") + ylab("Precipitation (Inches)") +  # label the x & y axes
          ggtitle("Daily Precipitation - Boulder Station\n 2003-2013")  # add a title
    
    precPlot_daily1

    ## Warning: Removed 94 rows containing missing values (position_stack).

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/COOP-NEIS-Precipitation-In-R/daily-summaries-1.png)

R will automatically combine all data from the same day and plot it on that day.  

#### Daily Plots & Data

If you not only want to see the daily data but you also want to create a field
of daily data, you need to create a new data frame with the daily data. We can 
use the `aggregate()` function to combine all the hourly data into daily data. 
We will use the date class DATE field we created in the previous code for this. 


    # aggregate the Precipitation (PRECIP) data by DATE
    precip.boulder_daily <-aggregate(precip.boulder$HPCP,   # data to aggregate
    	by=list(precip.boulder$DATE),  # variable to aggregate by
    	FUN=sum,   # take the sum (total) of the precip
    	na.rm=TRUE)  # if the are NA values ignore them
    	# if this is FALSE any NA value will prevent a value be totalled
    
    # view the results
    head(precip.boulder_daily)

    ##      Group.1   x
    ## 1 2003-01-01 0.0
    ## 2 2003-02-01 0.0
    ## 3 2003-02-03 0.4
    ## 4 2003-02-05 0.2
    ## 5 2003-02-06 0.1
    ## 6 2003-02-07 0.1

So we now have daily data but the column names don't mean anything. We can 
give them meaningful names by using the `names()` function. Instead of just
renaming the column `HPCP` let's call it `PRECIP`.


    # rename the columns
    names(precip.boulder_daily)[names(precip.boulder_daily)=="Group.1"] <- "DATE"
    names(precip.boulder_daily)[names(precip.boulder_daily)=="x"] <- "PRECIP"
    
    # double check rename
    head(precip.boulder_daily)

    ##         DATE PRECIP
    ## 1 2003-01-01    0.0
    ## 2 2003-02-01    0.0
    ## 3 2003-02-03    0.4
    ## 4 2003-02-05    0.2
    ## 5 2003-02-06    0.1
    ## 6 2003-02-07    0.1

Now we can plot the daily data. 


    # plot daily data
    precPlot_daily <- ggplot(data=precip.boulder_daily,  # the data frame
          aes(DATE, PRECIP)) +   # the variables of interest
          geom_bar(stat="identity") +   # create a bar graph
          xlab("Date") + ylab("Precipitation (Inches)") +  # label the x & y axes
          ggtitle("Daily Precipitation - Boulder Station\n 2003-2013")  # add a title
    
    precPlot_daily

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/COOP-NEIS-Precipitation-In-R/daily-prec-plot-1.png)

Compare this to the plot we created using the first method. Are they the same? 

<i class="fa fa-star"></i> **R Tip:** This manipulation, or aggregation, of data
can also be done with the package `plyr` using the `summarize()` function.
{: .notice}

## Subset the Data 

Instead of looking at the data for the full decade, let's now focus on just the
2 months surrounding the flood on 11-15 September. We'll use the window from 15 
August to 15 October to focus on. 

Just like aggregating we can accomplish this through the graphical interface or 
by creating an actual subset of the data. 

#### Subset Within Plot
Let's start with the graphic interface where we can simply set limits for the 
scale on the x-axis with `scale_x_date()`. 


    # First, define the limits -- 2 months around the floods
    limits <- as.Date(c("2013-08-15", "2013-10-15"))
    
    # Second, plot the data - Flood Time Period
    precPlot_flood <- ggplot(data=precip.boulder_daily,
          aes(DATE, PRECIP)) +
          geom_bar(stat="identity") +
          scale_x_date(limits=limits) +
          xlab("Date") + ylab("Precipitation (Inches)") +
          ggtitle("Precipitation - Boulder Station\n August 15 - October 15, 2013")
    
    precPlot_flood

    ## Warning: Removed 770 rows containing missing values (position_stack).

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/COOP-NEIS-Precipitation-In-R/plot-Aug-Oct-2013-1.png)

Here we can easily see the dramatic rainfall event in mid-September! 

<i class="fa fa-star"></i> **R Tip:** If you are using a date-time class, instead
of just a date class, you need to use `scale_x_datetime()`.
{: .notice}

#### Subset The Data

Now let's subset the actual data and plot it. 

    # subset 2 months around flood
    precip.boulder_AugOct <- subset(precip.boulder_daily, 
                            DATE >= as.Date('2013-08-15') & 
    												DATE <= as.Date('2013-10-15'))
    
    # check the first & last dates
    min(precip.boulder_AugOct$DATE)

    ## [1] "2013-08-21"

    max(precip.boulder_AugOct$DATE)

    ## [1] "2013-10-11"

    # create new plot
    precPlot_flood2 <- ggplot(data=precip.boulder_AugOct, aes(DATE,PRECIP)) +
      geom_bar(stat="identity") +
      xlab("Time") + ylab("Precipitation (inches)") +
      ggtitle("Daily Total Precipitation \n Boulder Creek 2013") 
    
    precPlot_flood2 

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/COOP-NEIS-Precipitation-In-R/subset-data-1.png)


## Interactive Plots - Plotly

Let's turn our plot into an interactive Plotly plot. 


    # load package; only if not already loaded
    library(plotly)
    
    # setup your plot.ly credentials; if not already set up
    Sys.setenv("plotly_username"="your.user.name.here")
    Sys.setenv("plotly_api_key"="your.key.here")


    #view plotly plot in R
    ggplotly(precPlot_flood2)

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/COOP-NEIS-Precipitation-In-R/plotly-precip-data-1.png)

    #publish plotly plot to your plot.ly online account when you are happy with it
    plotly_POST(precPlot_flood2)

    ## No encoding supplied: defaulting to UTF-8.

    ## Success! Modified your plotly here -> https://plot.ly/~NEONDataSkills/4

<iframe src="https://plot.ly/~NEONDataSkills/4.embed" width="800" height="600" id="igraph" scrolling="no" seamless="seamless" frameBorder="0"> </iframe>

## Challenge: Plot Precip for Boulder Station Since 1948

The Boulder precipitation station has been recording data since 1948. Use the 
steps learned above to create a plot of all the precipitation data (1948 - 2013).
This data set takes considerable time to download, so we recommend you use the
provided dataset "805333-precip_daily_1948-2013.csv". 

As an added challenge, aggregate the data by month instead of by day.  

![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/COOP-NEIS-Precipitation-In-R/all-boulder-station-data-1.png)![ ]({{ site.baseurl }}/images/rfigs/disturb-events-co13/COOP-NEIS-Precipitation-In-R/all-boulder-station-data-2.png)

    ## No encoding supplied: defaulting to UTF-8.

    ## Success! Modified your plotly here -> https://plot.ly/~NEONDataSkills/6





## Additional Resources

### Units & Scale
If you are using a dataset downloaded before 2016, the units were in 
**hundredths of an inch**, this isn't the most useful measure. You might want to
create a new column `PRECIP` that contains the data from `HPCP` converted to 
inches.  


    # convert from 100th inch by dividing by 100
    precip.boulder$PRECIP<-precip.boulder$HPCP/100
    
    # view & check to make sure conversion occured
    head(precip.boulder)

    ##       STATION    STATION_NAME ELEVATION LATITUDE LONGITUDE       DATE HPCP
    ## 1 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 2003-01-01  0.0
    ## 2 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 2003-02-01  0.0
    ## 3 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 2003-02-03  0.2
    ## 4 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 2003-02-03  0.1
    ## 5 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 2003-02-03  0.1
    ## 6 COOP:050843 BOULDER 2 CO US    1650.5 40.03389 -105.2811 2003-02-05  0.1
    ##   Measurement.Flag Quality.Flag            DateTime PRECIP
    ## 1                g              2003-01-01 01:00:00  0.000
    ## 2                g              2003-02-01 01:00:00  0.000
    ## 3                               2003-02-02 19:00:00  0.002
    ## 4                               2003-02-02 22:00:00  0.001
    ## 5                               2003-02-03 02:00:00  0.001
    ## 6                               2003-02-05 02:00:00  0.001

Compare `HPCP` and `PRECIP`, did we do the conversion correctly?  


