## ----import-data---------------------------------------------------------

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)

# set working directory to ensure R can find the file we wish to import
# setwd("working-dir-path-here")

# Read in data
temp30_sites <- read.csv('NEON-pheno-temp-timeseries/temp/SAAT_30min.csv', stringsAsFactors = FALSE)


## ----data-structure------------------------------------------------------
# Get a general feel for the data: View structure of data frame
str(temp30_sites)

## ----filter-site---------------------------------------------------------

# set site of interest
siteOfInterest <- "SCBI"

# use filter to select only the site of Interest 
# using %in% allows one to add a vector if you want more than one site. 
temp30 <- filter(temp30_sites, siteID %in% siteOfInterest)


## ----qf-data-------------------------------------------------------------
# Review the data quality (are these data you trust?)
#1. Are there quality flags in your data? Count 'em up

sum(temp30$finalQF==1)


## ----na-data-------------------------------------------------------------

# Are there NA's in your data? Count 'em up
sum(is.na(temp30$tempSingleMean) )

mean(temp30$tempSingleMean)

## ----new-df-noNA---------------------------------------------------------

# create new dataframe without NAs
temp30_noNA <- temp30 %>%
	drop_na(tempSingleMean)  # tidyr function

# alternate base R
# temp30_noNA <- temp30[!is.na(temp30$tempSingleMean),]

# did it work?
sum(is.na(temp30_noNA$tempSingleMean))


## ----convert-date-time---------------------------------------------------

# View the date range
range(temp30_noNA$startDateTime)

## ----convert-datetime----------------------------------------------------
# convert to Date Time 
temp30_noNA$startDateTime <- as.POSIXct(temp30_noNA$startDateTime,
																				format = "%Y-%m-%dT%H:%M", tz = "GMT")
# check that conversion worked
str(temp30_noNA$startDateTime)

## ----subset-date---------------------------------------------------------
# Limit dataset to dates of interest (2016-01-01 to 2016-12-31)

temp30_TOI <- filter(temp30_noNA, startDateTime>"2015-12-31 23:59")


# View the date range
range(temp30_TOI$startDateTime)


## ----plot-temp-----------------------------------------------------------

tempPlot <- ggplot(temp30_TOI, aes(startDateTime, tempSingleMean)) +
    geom_point() +
    ggtitle("Single Asperated Air Temperature") +
    xlab("Date") + ylab("Temp (C)") +
    theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
    theme(text = element_text(size=18))

tempPlot


## ----daily-max-dplyr-----------------------------------------------------

# convert to date
temp30_TOI$sDate <- as.Date(temp30_TOI$startDateTime)

# did it work
str(temp30_TOI$sDate)

# max of mean temp each day
temp_day <- temp30_TOI %>%
	group_by(sDate) %>%
	distinct(sDate, .keep_all=T) %>%
	mutate(dayMax=max(tempSingleMean))


# rename column



## ----basic-ggplot2-------------------------------------------------------

# plot Air Temperature Data across 2016 using daily data
tempPlot_dayMax <- ggplot(temp_day, aes(sDate, dayMax)) +
    geom_point() +
    ggtitle("Daily Max Air Temperature") +
    xlab("") + ylab("Temp (C)") +
    theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
    theme(text = element_text(size=18))

tempPlot_dayMax


## ----write-csv-----------------------------------------------------------
# Write .csv (this will be read in new in subsuquent lessons)
write.csv(temp_day, file="NEON-pheno-temp-timeseries/temp/NEONsaat_daily_SCBI_2016.csv")

