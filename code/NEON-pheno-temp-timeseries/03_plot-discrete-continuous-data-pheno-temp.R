## ----import-data---------------------------------------------------------

# Load required libraries
library(ggplot2)
library(dplyr)
library(lubridate)
library(gridExtra)
library(scales)  # use with date_breaks

# Set working directory

# Read in data -> if in series this is unnecessary
temp_day <- read.csv('NEON-pheno-temp-timeseries/temp/NEONsaat_daily_SCBI_2016.csv',
		stringsAsFactors = FALSE)

phe_1sp_2016 <- read.csv('NEON-pheno-temp-timeseries/pheno/NEONpheno_LITU_Leaves_SCBI_2016.csv',
		stringsAsFactors = FALSE)

# Convert dates
temp_day$sDate <- as.Date(temp_day$sDate)
phe_1sp_2016$date <- as.Date(phe_1sp_2016$date)


## ----stacked-plots-------------------------------------------------------

phenoPlot <- ggplot(phe_1sp_2016, aes(date, n.y)) +
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


## ----format-x-axis-labels------------------------------------------------
# format x-axis: dates
phenoPlot <- phenoPlot + 
  (scale_x_date(breaks = date_breaks("months"), labels = date_format("%b")))

phenoPlot

tempPlot_dayMax <- tempPlot_dayMax +
  (scale_x_date(breaks = date_breaks("months"), labels = date_format("%b")))

tempPlot_dayMax

# Output with both plots
grid.arrange(phenoPlot, tempPlot_dayMax) 


## ----align-datasets-replot-----------------------------------------------
# align dates
temp_day_fit <- filter(temp_day, sDate >= min(phe_1sp_2016$date) & sDate <= max(phe_1sp_2016$date))

# Check it
range(phe_1sp_2016$date)
range(temp_day_fit$sDate)

#plot again
tempPlot_dayMax_corr <- ggplot(temp_day_fit, aes(sDate, dayMax)) +
    geom_point() +
    scale_x_date(breaks = date_breaks("months"), labels = date_format("%b")) +
    ggtitle("Daily Max Air Temperature") +
    xlab("") + ylab("Temp (C)") +
    theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
    theme(text = element_text(size=18))

grid.arrange(phenoPlot, tempPlot_dayMax_corr)


