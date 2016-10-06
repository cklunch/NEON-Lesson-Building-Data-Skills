---
layout: post
title: "Data Activity: Visualize Stream Discharge Data in R to Better Understand the 2013 Colorado Floods"
date: 2015-12-04
authors: [Leah A. Wasser, Megan A. Jones Mariela Perignon]
dateCreated: 2015-05-18
lastModified: 2016-10-05
categories: [Coding and Informatics]
category: [teaching-module]
tags: [R, time-series]
mainTag: disturb-event-co13
scienceThemes: [disturbance]
description: "This lesson walks through the steps need to download and visualize
Precipitation Data and USGS Stream Discharge data in R to better understand the
drivers and impacts of the 2013 Colorado floods."
image:
  feature: TeachingModules.jpg
  credit: A National Ecological Observatory Network (NEON) - Teaching Module
  creditlink: http://www.neonscience.org
permalink: /R/Boulder-Flood-Precipitation-Stream-Discharge-Data-R/
code1: 
comments: false
---

{% include _toc.html %}

Several factors contributed to extreme flooding that occured in Boulder,
Colorado in 2013. In this lesson, we will explore and visualize the data of two 
key variables including:

* Precipitation (rainfall) data collected by ???NDCD?? 
* Stream discharge (or flow) that occured due to combination of the drought 
conditions and extreme rainfall.

<div id="objectives" markdown="1">

#Goals / Objectives
After completing this activity, students will:

* 


## Things You'll Need To Complete This Lesson
Please be sure you have the most current version of `R` and, preferably,
RStudio to write your code.

### R Libraries to Install:

* **ggplot2:** `install.packages("ggplot2")`
* **lubridate:** `install.packages("lubridate")`
* **plotly:** `install.packages("plotly")`

### Data to Download

... processed at <a href="http://www.neoninc.org" target="_blank" >NEON </a> 
headquarters. The entire dataset can be accessed by request from the 
<a href="http://www.neoninc.org/data-resources/get-data/airborne-data" target="_blank"> NEON 
website.</a>

</div>

## About the Data - USGS Stream Discharge Data

The USGS has a distributed network of aquatic sensors located in streams across
the United States. These network monitors a suit of variables that are important
to stream morphology and health. One of the metrics that this sensor network
monitors is **Stream Discharge**, a metric which quantifies the volume of water
moving down a stream. Discharge is an ideal metric to quantify flow, which
increases significantly during a flood event.

> As defined by USGS: Discharge is the volume of water moving down a stream or 
> river per unit of time, 
> commonly expressed in cubic feet per second or gallons per day. In general, 
> river discharge is computed by multiplying the area of water in a channel
> cross 
> section by the average velocity of the water in that cross section.
> 
> <a href="http://water.usgs.gov/edu/streamflow2.html" target="_blank">
More on stream Discharge by USGS.</a>

<figure>
<a href="{{ site.baseurl }}/images/dist-co-flood/USGS-Peak-discharge.gif">
<img src="{{ site.baseurl }}/images/dist-co-flood/USGS-Peak-discharge.gif"></a>
    
<figcaption>
The USGS tracks stream discharge through time at locations across the United 
States. Note the pattern observed in the plot above. The Peak recorded discharge
value in 2013 was significantly larger than what was observed in other years.
</figcaption>
</figure>

More on USGS streamflow measurements and data:

* <a href="http://maps.waterdata.usgs.gov/mapper/index.html" target="_blank"> View interactive map of all USGS stations</a>
* <a href="http://nwis.waterdata.usgs.gov/usa/nwis/peak/?site_no=06730200" target="_blank"> More on peak streamflow. </a>
* <a href="http://water.usgs.gov/edu/measureflow.html" target="_blank">part 2 - USGS overview of measuring streamflow</a>
* <a href="http://water.usgs.gov/edu/streamflow2.html" target="_blank">part 2 - USGS overview of measuring streamflow</a>

Data Tip: USGS data can be downloaded via an API (using a command line
interface). 
<a href="http://help.waterdata.usgs.gov/faq/automated-retrievals#RT">
More on API downloads of USGS data </a>.
{: .notice }


#note: it's unclear from this how the data were actually measursed given it seems there are diferent sensors. ASK Aquatics.


## Getting USGS Stream Gauge Data

For this lesson, we are using data collected by USGS stream guage 06730200 which
is located in Boulder Creek at North 75th St. This guage is one of the few the 
was able to collect data throughout the 2013 Boulder Floods. The data were that 
we will use were downloaded from USGS's 
<a href="http://waterdata.usgs.gov/nwis" target="_blank"> National 
Water Information System portal </a>.

You can access these data and the full available data stream for the boulder 
guage using the link below. Notice that youare able to download the data at 
different time periods as well!

<a href="http://waterdata.usgs.gov/nwis/inventory?agency_code=USGS&site_no=06730200
" target="_blank">View USGS stream guage 06730200 page.</a>


#insert picture of guage! <PICTURE>>


#insert map of where the guage is located - leaflet?

Guage Data info:
USGS 06730200 BOULDER CREEK AT NORTH 75TH ST. NEAR BOULDER, CO
{ : .notice }

#Import USGS Stream Discharge Data Into R
Now that we better understand the data that we will work with, let's import it into
`R`. First, open up the `precip-discharge/2013-discharge.txt` file in a text editor.
What do you notice about the structure of the file?

The first 25 lines are descriptive text and not actual data. Also notice that 
this file is separated by tabs, not commas. We will need to specify the **Tab delimiter**
when we import our data.We will use the `read.csv` to import it into an `R` object. 

When we use `csv` we need to define several attributes of the file including:

1. The data are tab delimited. We will this tell R to use the `"/t"` **sep**arator. 
Which defines a tab delimited separation.
2. The first group of lines in the file are not data, we will tell `R` to skip
those lines when it imports the data using `skip=25`.
3. Our data have a header, which is similar to column names in a spreadsheet. We 
will tell `R` to set `header=TRUE` to ensure the headers are imported as column
names rather than data values.
4. Finally we will set `stringsAsFactors = FALSE` to ensure our data come in a 
individual values.

Let's import our data.

## Import Stream Discharge Data

    #SOURCE
    #http://nwis.waterdata.usgs.gov/co/nwis/uv/?cb_00065=on&cb_00060=on&format=rdb&site_no=06730200&period=&begin_date=2013-01-01&end_date=2013-12-31
    #import data
    
    discharge <- read.csv("precip-discharge/2013-discharge.txt",
                          sep="\t",
                          skip=25,
                          header=TRUE,
                          stringsAsFactors = FALSE)

    ## Warning in file(file, "rt"): cannot open file 'precip-discharge/2013-
    ## discharge.txt': No such file or directory

    ## Error in file(file, "rt"): cannot open the connection

    #view first few lines
    head(discharge)

    ## Error in head(discharge): object 'discharge' not found

When we import these data, it appears as if we have 2 header rows rather than
one. Let's create a new `R` object that removes the second row of header values.
To do this, we can use select all data beginning at row 2 and ending at the
total number or rows in the file. The `nrow` function will count the total
number of rows in the object.

# LINK OUT TO DATA OR SOFTWARE CARPENTRY LESSONS THAT TEACH THIS??
* More on selecting a subset of a data.frame in R



Let's subset our `discharge` object to remove the first row.


    #how many rows are in the R object
    nrow(discharge)

    ## Error in nrow(discharge): object 'discharge' not found

    #remove the first line from the data frame (which is a second list of headers)
    #the code below selects all rows beginning at row 2 and ending at the total
    #number of rows. 
    boulderStrDis.2013 <- discharge[2:nrow(discharge),]

    ## Error in eval(expr, envir, enclos): object 'discharge' not found

Now, we have an `R` object that contains only rows containing data values. Each 
column also has a unique column name. However the column names may not be descriptive
enough. In some cases, when we had useful metadata, we might keep the names as is.
In this case, let's rename column 5, which contains the discharge value, **disValue**
so it is more "human readable" as we work with it in `R`.


    #view names
    names(boulderStrDis.2013)

    ## Error in eval(expr, envir, enclos): object 'boulderStrDis.2013' not found

    #rename the fifth column to disValue representing discharge value
    names(boulderStrDis.2013)[5] <- "disValue"

    ## Error in names(boulderStrDis.2013)[5] <- "disValue": object 'boulderStrDis.2013' not found

    #view names
    names(boulderStrDis.2013)

    ## Error in eval(expr, envir, enclos): object 'boulderStrDis.2013' not found

#View Data Structure
Let's have a look at the structure of our data. It appears as if the discharge 
value is a `character` class. This is likely because we had an additional row in our
data. Let's convert the discharge column to a `numeric` class. In this case, we can 
reassign that column to be of class: `integer` given there are no decimal places.


    #view structure of data
    str(boulderStrDis.2013)

    ## Error in str(boulderStrDis.2013): object 'boulderStrDis.2013' not found

    #view class of the disValue column
    class(boulderStrDis.2013$disValue)

    ## Error in eval(expr, envir, enclos): object 'boulderStrDis.2013' not found

    #convert column to integer
    boulderStrDis.2013$disValue <- as.integer(boulderStrDis.2013$disValue)

    ## Error in eval(expr, envir, enclos): object 'boulderStrDis.2013' not found

    class(boulderStrDis.2013$disValue)

    ## Error in eval(expr, envir, enclos): object 'boulderStrDis.2013' not found

    str(boulderStrDis.2013)

    ## Error in str(boulderStrDis.2013): object 'boulderStrDis.2013' not found


#Converting Time Stamps
We have converted our discharge data to an `integer` class However the time stamp
field, `datetime` is still a `character` class. We could try to plot the data however, 
if we do, it will confuse R. It will read in the dates as character strings and
get confused. Your plot will take a LONG time to render!



    ## Error in ggplot(boulderStrDis.2013, aes(datetime, disValue)): object 'boulderStrDis.2013' not found

To efficiently plot time series data, let's convert the `datetime` column to a 
`time` class for efficient plotting and analysis.


    #view class
    class(boulderStrDis.2013$datetime)

    ## Error in eval(expr, envir, enclos): object 'boulderStrDis.2013' not found

    #convert to date/time class - POSIX
    boulderStrDis.2013$datetime <- as.POSIXct(boulderStrDis.2013$datetime)

    ## Error in as.POSIXct(boulderStrDis.2013$datetime): object 'boulderStrDis.2013' not found

    #recheck data structure
    str(boulderStrDis.2013)

    ## Error in str(boulderStrDis.2013): object 'boulderStrDis.2013' not found

#No Data Values
Next, let's query our data to check whether there are no data values (`NA`) in it.



    #make sure there are no null values in our datetime field
    sum(is.na(boulderStrDis.2013$datetime ))

    ## Error in eval(expr, envir, enclos): object 'boulderStrDis.2013' not found

#Plot The Data
Finally, we are ready to plot our data. We will use `GGPLOT` to create our plot.


    ggplot(boulderStrDis.2013, aes(datetime, disValue)) +
      geom_point() +
      ggtitle("Stream Discharge (CFS) for Boulder Creek\nJan. 2013-Jan. 2014") +
      xlab("Date (POSIX Time Class)") + ylab("Discharge (Cubic Feet per Second)")

    ## Error in ggplot(boulderStrDis.2013, aes(datetime, disValue)): object 'boulderStrDis.2013' not found

#Plot Data Time Subsets With ggplot 

We can plot a subset of our data using `ggplot`. Let's plot data for the months 
directly around the boulder flood: August 2013 - October 2013.


    #Define Start and end times for the subset as R objects that are the time class
    startTime <- as.POSIXct("2013-08-15 00:00:00")
    endTime <- as.POSIXct("2013-10-15 00:00:00")
    
    #create a start and end time R object
    start.end <- c(startTime,endTime)
    start.end

    ## [1] "2013-08-15 MDT" "2013-10-15 MDT"

## Plot A Temporal Subset

Finally, we can use GGPLOT just like we did above to create a new plot. However, 
this time, we will use the `scale_x_datetime` method and define the limits to our
`limits` object.


ggtitle("Stream Discharge (CFS) for Boulder Creek\nJan. 2013-Jan. 2014") +
  xlab("Date") + ylab("Discharge (Cubic Feet per Second")
  

    #plot the data - September-October
    ggplot(data=boulderStrDis.2013,
          aes(datetime,disValue)) +
          geom_point() +
          scale_x_datetime(limits=start.end) +
          xlab("Date") + ylab("Discharge (Cubic Feet per Second)") +
          ggtitle("Stream Discharge (CFS) for Boulder Creek\nAugust 2013 - October 2013")

    ## Error in ggplot(data = boulderStrDis.2013, aes(datetime, disValue)): object 'boulderStrDis.2013' not found

#Publish to Plot.ly
We have now successfully created a plot. We can turn that plot into an interactive
plot using `Plot.ly` if we want. Note, for this to be successful you need to 
set your Plot.ly API key which you will get from your free online account, once 
you create it.

Set your username: `Sys.setenv("plotly_username"="yourUserNameHere")`
Set your user key: `Sys.setenv("plotly_api_key"="yourUserKeyHere")`

##Time subsets in plot.ly

Note that plot.ly doesn't accept the ggplot time subset method. Thus we will
have to manually subset out our data.


    library(plotly)
    
    #set username
    Sys.setenv("plotly_username"="yourUserNameHere")
    #set user key
    Sys.setenv("plotly_api_key"="yourUserKeyHere")
    
    #subset out some of the data - July-November
    boulderStrDis.aug.oct2013 <- subset(boulderStrDis.2013, 
                            datetime >= as.POSIXct('2013-08-15 00:00',
                                                  tz = "America/Denver") & 
                            datetime <= as.POSIXct('2013-10-15 23:59', 
                                                  tz = "America/Denver"))
    
    #plot the data - September-October
    disPlot.plotly <- ggplot(data=boulderStrDis.aug.oct2013,
            aes(datetime,disValue)) +
            geom_point(size=3) 
          
    #add title and labels
    disPlot.plotly <- disPlot.plotly + theme(axis.title.x = element_blank()) +
              xlab("Time") + ylab("Stream Discharge CFS") +
              ggtitle("Stream Discharge - Boulder Creek 2013")
    
    #view plotly plot in R
    ggplotly()
    
    #publish plotly plot to your plot.ly online account if you want. 
    #plotly_POST(disPlot.plotly)

#Challenge ???
* Maybe have them grab data from another location - possibly another guage that
survived the flood in another area??

#LEFT TO DO IN THIS LESSSON
1. Create Plot.ly plot in a neondataskills account and embed it as a graphic
2. Create challenge?



