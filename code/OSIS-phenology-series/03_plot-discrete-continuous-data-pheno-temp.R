## ----import-data---------------------------------------------------------

# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)
library(gridExtra)

# Set working directory

# Read in data
temp_day <- read.csv('NEON-pheno-temp-timeseries/temp/NEONsaat_daily_SCBI_2016.csv', stringsAsFactors = FALSE)


## ----stacked-plots-------------------------------------------------------

phenoPlot <- ggplot(inStat_T, aes(date, n)) +
    geom_bar(stat="identity", na.rm = TRUE) +
    ggtitle("Total Individuals in Leaf") +
    xlab("Date") + ylab("Number of Individuals") +
    theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
    theme(text = element_text(size=18))

phenoPlot


tempPlot_dayMax <- ggplot(temp_day, aes(sDate, dayMax)) +
    geom_point() +
    ggtitle("Daily Max Air Temperature") +
    xlab("") + ylab("Temp (C)") +
    theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
    theme(text = element_text(size=18))

tempPlot_dayMax


# Output with both plots
grid.arrange(phenoPlot, tempPlot_dayMax) 


## ----scaled-plot---------------------------------------------------------


tempPlot_dayMax <- ggplot(temp_day, aes(sDate, dayMax)) +
    geom_point() +
    ggtitle("Daily Max Air Temperature") +
    xlab("") + ylab("Temp (C)") +
    theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
    theme(text = element_text(size=18))

tempPlot_dayMax <- ggplot(inStat_T, aes(date, n)) +
    geom_bar(stat="identity", na.rm = TRUE)+
    add=TRUE

phenoPlot




## ----format-x-axis-labels------------------------------------------------
# format x-axis: dates
AirTempDailyb <- AirTempDaily + 
  (scale_x_date(labels=date_format("%b %y")))

AirTempDailyb

## ----write-csv-----------------------------------------------------------
# write harMet15 subset data to .csv
write.csv(harMet15.09.11, 
          file="Met_HARV_15min_2009_2011.csv")


