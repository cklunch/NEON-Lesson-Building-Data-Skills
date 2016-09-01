## ----load-libraries------------------------------------------------------

library(lubridate) # work with time series data
library(ggplot2)   # create efficient, professional plots
library(plotly)    # create interactive plots


## ----import-drought-data-------------------------------------------------
# Set working directory to the data directory
# setwd("YourFullPathToDataDirectory")

# Import CO state-wide nCLIMDIV data
nCLIMDIV <- read.csv("disturb-events-co13/drought/CDODiv8506877122044_CO.txt", header = TRUE)

# view first few rows
head(nCLIMDIV)

# view data structure
str(nCLIMDIV)

## ----convert-year-month--------------------------------------------------
# convert to date, and create a new Date column 
nCLIMDIV$Date <- as.Date(nCLIMDIV$YearMonth, format="%Y%m")


## ----convert-date--------------------------------------------------------
#add a day of the month to each year-month combination
nCLIMDIV$Date <- paste0(nCLIMDIV$YearMonth,"01")

#convert to date
nCLIMDIV$Date <- as.Date(nCLIMDIV$Date, format="%Y%m%d")

# check to see it works
str(nCLIMDIV)

## ----create-quick-palmer-plot--------------------------------------------

# plot the Palmer Drought Index (PDSI)
palmer.drought <- ggplot(data=nCLIMDIV,
												 aes(Date,PDSI)) +  # x is Date & y is drought index
	geom_bar(stat="identity",position = "identity") +   # bar plot 
       xlab("Date") + ylab("Palmer Drought Severity Index") +  # axis labels
       ggtitle("Palmer Drought Severity Index - Colorado \n 1991-2015")   # title on 2 lines (\n)

# view the plot
palmer.drought


## ----summary-stats-------------------------------------------------------
#view summary stats of the Palmer Drought Severity Index
summary(nCLIMDIV$PDSI)

#view histogram of the data
hist(nCLIMDIV$PDSI,   # the date we want to use
     main="Histogram of PDSI",  # title
		 xlab="Palmer Drought Severity Index (PDSI)",  # x-axis label
     col="wheat3")  #  the color of the bars


## ----create-plotly-drought-plot1-----------------------------------------

# Use exisitng ggplot plot & view as plotly plot in R
# note - plotly doesn't recognize \n to create a second title line
palmer.drought_plotly <- ggplotly(palmer.drought)  
palmer.drought_plotly

# publish plotly plot to your plot.ly online account when you are happy with it
# skip this step if you haven't connected a Plotly account
plotly_POST(palmer.drought_plotly)

## ----plotly-drought------------------------------------------------------

#subset out date between 2005 and 2015 
drought2005.2015 <- subset(drought, 
                        YearMonth >= as.Date('2005-01-01', tz = "America/Denver") &
                        YearMonth <= as.Date('2015-11-01', tz = "America/Denver"))

#plot the data - September-October
droughtPlot.2005.2015 <- ggplot(data=drought2005.2015,
        aes(YearMonth,PDSI)) +
         geom_bar(stat="identity",position = "identity") +
       xlab("Year / Month") + ylab("Palmer Drought Severity Index") +
       ggtitle("Palmer Drought Severity Index - Colorado\n2005 - 2015")
     
droughtPlot.2005.2015 

#view plotly plot in R
ggplotly()

#publish plotly plot to your plot.ly online account when you are happy with it
plotly_POST(droughtPlot.plotly)


## ------------------------------------------------------------------------

nCLIMDIV_US <- read.csv("disturb-events-co13/drought/CDODiv5138116888828_US.txt", header = TRUE)

#add a day of the month to each year-month combination
nCLIMDIV_04$Date <- paste0(nCLIMDIV_04$YearMonth,"01")

#convert to date
nCLIMDIV_04$Date <- as.Date(nCLIMDIV_04$Date, format="%Y%m%d")

# check to see it works
str(nCLIMDIV_04)

palmer.drought04 <- ggplot(data=nCLIMDIV_04,
												 aes(Date,PDSI)) +  # x is Date & y is drought index
	geom_bar(stat="identity",position = "identity") +   # bar plot 
       xlab("Date") + ylab("Palmer Drought Severity Index") +  # axis labels
       ggtitle("Palmer Drought Severity Index - Colorado")   # title

palmer.drought04

#assign -99.99 to NA in the PDSI column
#note: you may want to do this across the entire data.frame or with other columns.
drought[nCLIMDIV_04$PDSI==-99.99,] <-  NA

#view the histogram again - does the range look reasonable?
hist(drought$PDSI,
     main="Histogram of PDSI value with -99.99 removed",
     col="springgreen4")

#plot Palmer Drought Index
ggplot(data=drought,
       aes(YearMonth,PDSI)) +
       geom_bar(stat="identity",position = "identity") +
       xlab("Year") + ylab("Palmer Drought Severity Index") +
       ggtitle("Palmer Drought Severity Index - Colorado\n1990 to 2015")



