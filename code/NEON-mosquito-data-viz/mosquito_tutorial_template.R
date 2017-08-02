## ----load-libraries------------------------------------------------------

# Load packages required for entire script. 
library(plyr)      # move/manipulate data
library(dplyr)     # move/manipulate data
library(foreign)   
library(maptools)  # used for creating maps of NEON field sites
library(raster)    # manipulate spatial data
#library(rbokeh)
library(rgdal)     # manipulate and read spatial data
library(ggplot2)   # creation of plots and visualizations
library(tidyverse) # move/manipulate data
library(mosaic)    # good for data exploration

#Set strings as factors equal to false thoughout
options(stringsAsFactors = FALSE) 

# set working directory to ensure R can find the file we wish to import
#setwd("working-dir-path-here")


## ----trapping-table------------------------------------------------------

#Read in the data TO BE CHANGED AS PORTAL DEVELOPS
trap = read.csv('NEON-mosquito-data-viz/mos_trapping_in.csv')

# set strings as factors as false throughout
options(stringsAsFactors = FALSE) 

#This command allows you to view the structure of the data
str(trap)


## ----sort-table----------------------------------------------------------

# read in sorting TO BE CHANGED AS PORTAL DEVELOPS
sort = read.csv('NEON-mosquito-data-viz/mos_sorting_in.csv')

# set strings as factors as false throughout
options(stringsAsFactors = FALSE) 

str(sort)


## ----identification-table------------------------------------------------

# read in data
id = read.csv('NEON-mosquito-data-viz/mos_identification_in.csv')

# set strings as factors as false throughout
options(stringsAsFactors = FALSE) 

# view structure of the data
str(id)


## ----taxonomy-table------------------------------------------------------

#read in data
taxonomy = read.csv("NEON-mosquito-data-viz/mosquito_taxonomy.csv")

# set strings as factors as false throughout
options(stringsAsFactors = FALSE) 

str(taxonomy)


## ----location-scraping---------------------------------------------------

# Create a vector of unique plotIDs from the trap dataframe to speed up the data scraping process
uniquePlotIDs <- unique(trap$plotID)

source('NEON-mosquito-data-viz/get_NEON_location.R')

# Use the lapply() to create a list where each element is a single plotID with GPS data
latlon <- lapply(uniquePlotIDs, get_NEON_location, output="latlon")


## ----location-dataframe--------------------------------------------------

# Convert list into a data frame with the do.call function
latlon.df <- do.call(rbind, latlon)

# Match the names of your columns in this dataframe to other dataframes
names(latlon.df) <- c("uniquePlotIDs", "lat", "lon", "northing", "easting", "utmZone", "elevation", "NLCDclass") 

# Removing datapoints with latitude or longitude listed as 1, not a viable sampling location
latlon.df[latlon.df==1]<-NA



## ----trap-location-merge-------------------------------------------------

# Merging trap data with latitude and  longitude data
trap <- merge(x = latlon.df, y = trap, by.x = "uniquePlotIDs", by.y = "plotID") 


## ----obtaining-more-lat--------------------------------------------------

# Filling in more latitude and longitude data
trap$lat2<-ifelse(is.na(trap$lat)==TRUE, trap$pdaDecimalLatitude,trap$lat)

trap$lon2<-ifelse(is.na(trap$lon)==TRUE, trap$pdaDecimalLongitude,trap$lon)


## ----finding-unique-columns----------------------------------------------

# Create a vector of column names that are in sort but not in id
cols = colnames(sort)[!colnames(sort)%in%colnames(id)]

# Merge id with subsetted sorting data frame
id <- left_join(id, sort[, c('subsampleID', cols)], 
                by = "subsampleID")


## ----create-unique-trap--------------------------------------------------

#Creating a dataframe with only the unique plotIDs and lat2 lon2 data for merging
uniquetrap<-trap[!duplicated(trap[,1]),c("uniquePlotIDs","lat2","lon2", "elevation","NLCDclass")]

#Merging id df with lat2 lon2 data
id <- merge(x = uniquetrap, y = id, by.y = "plotID", by.x = "uniquePlotIDs", all.y = TRUE)


## ----including-trap-zero-------------------------------------------------
# Get zero traps from trapping
new_trap<- trap[!trap$sampleID %in% id$sampleID & trap$targetTaxaPresent=="N",]

#Add columns in new_trap that weren't present in the ID table then add new_trap to ID table
new_trap <- new_trap[, colnames(new_trap)[colnames(new_trap)%in%colnames(id)]]

new_trap[, colnames(id)[!colnames(id)%in%colnames(new_trap)]]<-NA

id <- rbind(id,new_trap)

## ----fixing-individualCount----------------------------------------------

#Creation of sample Multiplier
id$sampleMultiplier <- ifelse(is.na(id$bycatchWeight), id$totalWeight/id$subsampleWeight, id$totalWeight/(id$subsampleWeight-id$bycatchWeight))
id$sampleMultiplier <- ifelse(id$sampleMultiplier==Inf, NA, id$sampleMultiplier)
id$sampleMultiplier <- ifelse(id$subsampleWeight==0 & id$individualCount != 0, 1, id$sampleMultiplier)

#Creation of New individual Count with Multiplier
id$newindividualCount <-ifelse(is.na(id$sampleMultiplier)==F, round(id$individualCount*id$sampleMultiplier), NA)


## ----trapping-hours------------------------------------------------------

#Creation of a variable to test whether samples were collected on the same day or different days
id$sameDay <- ifelse(substr(id$collectDate, 9, 10) != substr(id$setDate,9,10), FALSE, TRUE)

#Creating variables that convert the time of set and collection to hours
id$setHours <-((as.numeric(substr(id$setDate,15,16))/60)+(as.numeric(substr(id$setDate,12,13))))
id$collectHours <-((as.numeric(substr(id$collectDate,15,16))/60)+(as.numeric(substr(id$collectDate,12,13))))

#variable to calculate the number of hours of trap deployment
id$HoursOfTrapping <-ifelse(id$sameDay == TRUE, id$collectHours - id$setHours, (24 - id$setHours) + id$collectHours)

#Changing hours of trapping to positive number 
id$HoursOfTrapping <- abs(as.numeric(id$HoursOfTrapping))


## ----date-and-year-------------------------------------------------------

#Extracting year information for id
id$Year<-substr(id$collectDate,1,4)

#Extracting year information for id from both collect date and recieved date
id$receivedDate <- as.character(id$receivedDate)

id$Year<-ifelse(is.na(id$collectDate), substr(id$receivedDate,1,4), substr(id$collectDate,1,4))

#Exctracting date information for id
id$Date<-substr(id$collectDate,1,10)


## ----temp-data, eval=FALSE-----------------------------------------------
## 
## #Change temp date type
## temp.df$date <- as.Date(temp.df$date)
## 
## #Broad Site ID variable
## id$siteID<-substr(id$uniquePlotIDs,1,4)
## 
## #merging id with temp data
## id <- merge(x = temp.df, y = id, by.y = c('siteID','Date'), by.x = c('siteID','date'), all.y = TRUE)
## 
## #Converting temperature to proper value
## id$value<-id$value/10
## names(id)[5]<-"Max.TempC"
## 
## #Change precip date type
## precip.df$date <- as.Date(precip.df$date)
## 
## #Merge id with precip data
## id <- merge(x = precip.df[,c(1,4,9)], y = id, by.y = c('siteID', 'date'), by.x = c('siteID', 'date'), all.y = TRUE)
## 
## #converting temperature to proper value and renaming
## id$value<-id$value/10
## names(id)[3]<-"Precipmm"
## 

## ----domain-taxonomy, eval=FALSE-----------------------------------------
## 
## #Merge with domain info.
## id <- merge(x = domain.df, y = id, by.y = "siteID", by.x = "siteid", all.y = TRUE)
## 
## id$domainid <- as.character(id$domainid)
## 
## #Merge with taxonomy df for taxson rank
## id <- merge( x = taxonomy[,c("scientificName", "taxonRank")], y = id, by.x = "scientificName", by.y = "scientificName")
## 

## ----filtering-id, eval=FALSE--------------------------------------------
## 
## #Filter by species and subspecies classification
## id <- dplyr::filter(id, id$taxonRank %in% c("subspecies","species"))
## 
## #smalle subset only containing 2014 and 2016
## idsmall<-dplyr::filter(id, id$Year %in% c(2014,2016))
## 

