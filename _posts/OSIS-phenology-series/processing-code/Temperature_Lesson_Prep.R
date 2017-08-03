# file=Temperature_Lesson_Prep.R
# This file prepares the HARV 2015 temperature data set for use in 
# phenology data lesson: 1) changes dates from 2015 to 2014;
# 2) adds a 'remarks' field notifying that the data set is for 
# teaching purposes only.

### Set working directory
setwd("/Volumes/TOS/OSIS_dataLessons/temp_data/")

site <- "HARV"

# Read in data
temp30 <- read.csv(paste("NEON.D01.", site, 
                         ".DP1.00003.001.00000.000.060.030.TAAT_30min.csv",
                         sep=""), stringsAsFactors = FALSE, header=TRUE)

### Find and replace years with 2014 (for 2015) or 2015 (for 2016)
temp30$startDateTime <- gsub("2015","2014", temp30$startDateTime)
temp30$startDateTime <- gsub("2016","2015", temp30$startDateTime)

temp30$endDateTime <- gsub("2015","2014", temp30$endDateTime)
temp30$endDateTime <- gsub("2016","2015", temp30$endDateTime)

## Add a remarks field
temp30$remarks <- "Teaching data only. Do not use for other purposes"

## Change QF codes: all non-NA records = 0 and all NA records = 1
temp30$finalQF[!is.na(temp30$tempTripleMean)] <- 0
temp30$finalQF[is.na(temp30$tempTripleMean)] <- 1
sum(temp30$finalQF==1)     # all good

## Export data set with re-jiggered years, remarks, and new QF vals
write.csv(temp30, paste("NEON.D01.", site, 
                        ".DP1.00003.001.00000.000.060.030.TAAT_30min_teaching.csv",
                        sep=""), row.names=FALSE)




