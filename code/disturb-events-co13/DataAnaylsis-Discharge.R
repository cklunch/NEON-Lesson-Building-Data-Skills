## ----import-discharge-2--------------------------------------------------
#SOURCE
#http://nwis.waterdata.usgs.gov/co/nwis/uv/?cb_00065=on&cb_00060=on&format=rdb&site_no=06730200&period=&begin_date=2013-01-01&end_date=2013-12-31
#import data

discharge <- read.csv("precip-discharge/2013-discharge.txt",
                      sep="\t",
                      skip=25,
                      header=TRUE,
                      stringsAsFactors = FALSE)

#view first few lines
head(discharge)



## ----remove-second-header------------------------------------------------
#how many rows are in the R object
nrow(discharge)

#remove the first line from the data frame (which is a second list of headers)
#the code below selects all rows beginning at row 2 and ending at the total
#number of rows. 
boulderStrDis.2013 <- discharge[2:nrow(discharge),]

## ----rename-headers------------------------------------------------------

#view names
names(boulderStrDis.2013)

#rename the fifth column to disValue representing discharge value
names(boulderStrDis.2013)[5] <- "disValue"

#view names
names(boulderStrDis.2013)


## ----adjust-data-structure-----------------------------------------------
#view structure of data
str(boulderStrDis.2013)

#view class of the disValue column
class(boulderStrDis.2013$disValue)

#convert column to integer
boulderStrDis.2013$disValue <- as.integer(boulderStrDis.2013$disValue)

class(boulderStrDis.2013$disValue)
str(boulderStrDis.2013)


## ----plot-flood-data-example, echo=FALSE---------------------------------
#this plot takes FOREVER to create with all of the rows, so we will just 
#show them the output. OTherwise it could hang up machines.
ggplot(boulderStrDis.2013, aes(datetime, disValue)) +
  geom_point() +
  ggtitle("Plot Data With Time Field as a Character Class\nNotice the X Axis Labels") +
  xlab("Date Time (Character Class)") + ylab("Discharge (CFS)")


## ----convert-time--------------------------------------------------------
#view class
class(boulderStrDis.2013$datetime)

#convert to date/time class - POSIX
boulderStrDis.2013$datetime <- as.POSIXct(boulderStrDis.2013$datetime)

#recheck data structure
str(boulderStrDis.2013)


## ----no-data-values------------------------------------------------------
#make sure there are no null values in our datetime field
sum(is.na(boulderStrDis.2013$datetime ))


## ----plot-flood-data-----------------------------------------------------

ggplot(boulderStrDis.2013, aes(datetime, disValue)) +
  geom_point() +
  ggtitle("Stream Discharge (CFS) for Boulder Creek\nJan. 2013-Jan. 2014") +
  xlab("Date (POSIX Time Class)") + ylab("Discharge (Cubic Feet per Second)")


## ----define-time-subset--------------------------------------------------

#Define Start and end times for the subset as R objects that are the time class
startTime <- as.POSIXct("2013-08-15 00:00:00")
endTime <- as.POSIXct("2013-10-15 00:00:00")

#create a start and end time R object
start.end <- c(startTime,endTime)
start.end

## ----plot-subset---------------------------------------------------------
#plot the data - September-October
ggplot(data=boulderStrDis.2013,
      aes(datetime,disValue)) +
      geom_point() +
      scale_x_datetime(limits=start.end) +
      xlab("Date") + ylab("Discharge (Cubic Feet per Second)") +
      ggtitle("Stream Discharge (CFS) for Boulder Creek\nAugust 2013 - October 2013")



## ----plotly-discharge-data, results="hide", eval=FALSE-------------------
## library(plotly)
## 
## #set username
## Sys.setenv("plotly_username"="yourUserNameHere")
## #set user key
## Sys.setenv("plotly_api_key"="yourUserKeyHere")
## 
## #subset out some of the data - July-November
## boulderStrDis.aug.oct2013 <- subset(boulderStrDis.2013,
##                         datetime >= as.POSIXct('2013-08-15 00:00',
##                                               tz = "America/Denver") &
##                         datetime <= as.POSIXct('2013-10-15 23:59',
##                                               tz = "America/Denver"))
## 
## #plot the data - September-October
## disPlot.plotly <- ggplot(data=boulderStrDis.aug.oct2013,
##         aes(datetime,disValue)) +
##         geom_point(size=3)
## 
## #add title and labels
## disPlot.plotly <- disPlot.plotly + theme(axis.title.x = element_blank()) +
##           xlab("Time") + ylab("Stream Discharge CFS") +
##           ggtitle("Stream Discharge - Boulder Creek 2013")
## 
## #view plotly plot in R
## ggplotly()
## 
## #publish plotly plot to your plot.ly online account if you want.
## #plotly_POST(disPlot.plotly)
## 

