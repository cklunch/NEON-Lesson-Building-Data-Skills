---
layout: post
title: "NEON's Plant Phenology Data"
date:   2017-08-01
authors: [Megan A. Jones, Natalie Robinson, Lee Stanish]
contributors: [ ] 
dateCreated: 2017-08-01
lastModified: 2017-08-04
packagesLibraries: [ dplyr, ggplot2]
category: [self-paced-tutorial]
tags: [time-series, phenology, organisms]
mainTag:  neon-pheno-temp-series
tutorialSeries:  [neon-pheno-temp-series]
description: "Learn to work with NEON plant phenology observation data."
code1: 
image:
  feature: codedFieldJournal.png
  credit: National Ecological Observatory Network (NEON)
  creditlink: 
permalink: /R/plant-pheno-data
comments: true
---

{% include _toc.html %}

**R Skill Level:** Intermediate - you've got the basics of `R` down.

<div id="objectives" markdown="1">

# Objectives
After completing this activity, you will:

 * 

## Things You’ll Need To Complete This Tutorial
You will need the most current version of `R` and, preferably, `RStudio` loaded
on your computer to complete this tutorial.

### Install R Packages
* **NAME:** `install.packages("NAME")`


[More on Packages in R - Adapted from Software Carpentry.]({{site.baseurl}}R/Packages-In-R/)

### Download Data 

{% include/dataSubsets/_data_NEON-pheno-temp-timeseries.html %}

****
{% include/_greyBox-wd-rscript.html %}

****

## Additional Resources

* Data wrangling cheatsheet

</div>

Big Question: Plants change throughout the year - these are phenophases. 
Why do they change? 

Explore Phenology Data 

Download data  
- user guide

Briefly: 

* where is the data from (the topic of site selection)
* how is it collected 
* Which plants/growth form should we choose? 
* growth-form vs. species discussion

Final choice: - LITU


But how do we choose what aspect of phenophase to look at: 

Phenophases that are recorded (deciduous broad-leaf)/ all with Y/N & % of canopy/plant:

* breaking leaf buds 
* increasing leaf size 
* leaves 
* open flowers 
* colored leaves
* falling leaves 

Criteria for choosing 

* something with progress
* comparable across sites or growth forms? 

Final choice: leaves  (main teaching), colored leaves  (challenges)


Status codes
Status intensity - every time they go out. 
PerIndividualPerYear - once a year, "metadata" about the plants 


    library(dplyr)
    library(ggplot2)
    library(lubridate)
    
    
    # set working directory 
    setwd('/Users/lstanish/Downloads/')

    ## Error in setwd("/Users/lstanish/Downloads/"): cannot change working directory

    # Read in data
    ind <- read.csv('NEON-pheno-temp-timeseries/pheno/phe_perindividual.csv', stringsAsFactors = FALSE )
    
    status <- read.csv('NEON-pheno-temp-timeseries/pheno/phe_statusintensity.csv', stringsAsFactors = FALSE)

Explore the data, let's get to know what the dataframe looks like.


    #What are the fieldnames in this dataset?
    names(ind)

    ##  [1] "uid"                         "namedLocation"              
    ##  [3] "domainID"                    "siteID"                     
    ##  [5] "plotID"                      "decimalLatitude"            
    ##  [7] "decimalLongitude"            "geodeticDatum"              
    ##  [9] "coordinateUncertainty"       "elevation"                  
    ## [11] "elevationUncertainty"        "subtypeSpecification"       
    ## [13] "transectMeter"               "directionFromTransect"      
    ## [15] "ninetyDegreeDistance"        "sampleLatitude"             
    ## [17] "sampleLongitude"             "sampleGeodeticDatum"        
    ## [19] "sampleCoordinateUncertainty" "sampleElevation"            
    ## [21] "sampleElevationUncertainty"  "addDate"                    
    ## [23] "editedDate"                  "individualID"               
    ## [25] "taxonID"                     "scientificName"             
    ## [27] "identificationQualifier"     "taxonRank"                  
    ## [29] "growthForm"                  "vstTag"                     
    ## [31] "samplingProtocolVersion"     "measuredBy"                 
    ## [33] "identifiedBy"                "recordedBy"                 
    ## [35] "remarks"                     "dataQF"

    #how many rows are in the data?
    nrow(ind)

    ## [1] 1802

    #look at the first six rows of data.
    head(ind)

    ##                                    uid          namedLocation domainID
    ## 1 16a2656d-7287-46b1-aad7-bd000ec5983f BLAN_061.phenology.phe      D02
    ## 2 35210426-a9f3-4e13-9073-7dfbff670703 BLAN_061.phenology.phe      D02
    ## 3 fff04a10-2c95-44f5-b0df-4a62033d634f BLAN_061.phenology.phe      D02
    ## 4 2d9de2e1-154b-4dd9-840d-2cf81fb77362 BLAN_061.phenology.phe      D02
    ## 5 a32bce80-eeb9-463e-ad40-0cf6fa43bafe BLAN_061.phenology.phe      D02
    ## 6 c1c5f91b-e073-430a-ba48-ee2eb19117a4 BLAN_061.phenology.phe      D02
    ##   siteID   plotID decimalLatitude decimalLongitude geodeticDatum
    ## 1   BLAN BLAN_061        39.05963        -78.07385            NA
    ## 2   BLAN BLAN_061        39.05963        -78.07385            NA
    ## 3   BLAN BLAN_061        39.05963        -78.07385            NA
    ## 4   BLAN BLAN_061        39.05963        -78.07385            NA
    ## 5   BLAN BLAN_061        39.05963        -78.07385            NA
    ## 6   BLAN BLAN_061        39.05963        -78.07385            NA
    ##   coordinateUncertainty elevation elevationUncertainty
    ## 1                    NA       183                   NA
    ## 2                    NA       183                   NA
    ## 3                    NA       183                   NA
    ## 4                    NA       183                   NA
    ## 5                    NA       183                   NA
    ## 6                    NA       183                   NA
    ##   subtypeSpecification transectMeter directionFromTransect
    ## 1              primary           484                 Right
    ## 2              primary           506                 Right
    ## 3              primary           484                 Right
    ## 4              primary           476                  Left
    ## 5              primary           498                 Right
    ## 6              primary           469                  Left
    ##   ninetyDegreeDistance sampleLatitude sampleLongitude sampleGeodeticDatum
    ## 1                  0.5             NA              NA               WGS84
    ## 2                  1.0             NA              NA               WGS84
    ## 3                  2.0             NA              NA               WGS84
    ## 4                  2.0             NA              NA               WGS84
    ## 5                  2.0             NA              NA               WGS84
    ## 6                  2.0             NA              NA               WGS84
    ##   sampleCoordinateUncertainty sampleElevation sampleElevationUncertainty
    ## 1                          NA              NA                         NA
    ## 2                          NA              NA                         NA
    ## 3                          NA              NA                         NA
    ## 4                          NA              NA                         NA
    ## 5                          NA              NA                         NA
    ## 6                          NA              NA                         NA
    ##      addDate editedDate            individualID taxonID
    ## 1 2015-06-25 2015-07-22 NEON.PLA.D02.BLAN.06295    RHDA
    ## 2 2015-06-25 2015-07-22 NEON.PLA.D02.BLAN.06286   LOMA6
    ## 3 2015-06-25 2015-07-22 NEON.PLA.D02.BLAN.06299   LOMA6
    ## 4 2015-06-25 2015-07-22 NEON.PLA.D02.BLAN.06300    RHDA
    ## 5 2015-06-25 2015-07-22 NEON.PLA.D02.BLAN.06288   LOMA6
    ## 6 2015-06-25 2015-07-22 NEON.PLA.D02.BLAN.06297    RHDA
    ##                    scientificName identificationQualifier taxonRank
    ## 1          Rhamnus davurica Pall.                           species
    ## 2 Lonicera maackii (Rupr.) Herder                           species
    ## 3 Lonicera maackii (Rupr.) Herder                           species
    ## 4          Rhamnus davurica Pall.                           species
    ## 5 Lonicera maackii (Rupr.) Herder                           species
    ## 6          Rhamnus davurica Pall.                           species
    ##            growthForm vstTag samplingProtocolVersion
    ## 1 Deciduous broadleaf     NA                      NA
    ## 2 Deciduous broadleaf     NA                      NA
    ## 3 Deciduous broadleaf     NA                      NA
    ## 4 Deciduous broadleaf     NA                      NA
    ## 5 Deciduous broadleaf     NA                      NA
    ## 6 Deciduous broadleaf     NA                      NA
    ##                         measuredBy                     identifiedBy
    ## 1 cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd
    ## 2 cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd
    ## 3 cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd
    ## 4 cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd
    ## 5 cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd
    ## 6 cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd
    ##                         recordedBy remarks dataQF
    ## 1 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd             NA
    ## 2 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd             NA
    ## 3 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd             NA
    ## 4 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd             NA
    ## 5 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd             NA
    ## 6 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd             NA

    # look at the structure of the dataframe.
    str(ind)

    ## 'data.frame':	1802 obs. of  36 variables:
    ##  $ uid                        : chr  "16a2656d-7287-46b1-aad7-bd000ec5983f" "35210426-a9f3-4e13-9073-7dfbff670703" "fff04a10-2c95-44f5-b0df-4a62033d634f" "2d9de2e1-154b-4dd9-840d-2cf81fb77362" ...
    ##  $ namedLocation              : chr  "BLAN_061.phenology.phe" "BLAN_061.phenology.phe" "BLAN_061.phenology.phe" "BLAN_061.phenology.phe" ...
    ##  $ domainID                   : chr  "D02" "D02" "D02" "D02" ...
    ##  $ siteID                     : chr  "BLAN" "BLAN" "BLAN" "BLAN" ...
    ##  $ plotID                     : chr  "BLAN_061" "BLAN_061" "BLAN_061" "BLAN_061" ...
    ##  $ decimalLatitude            : num  39.1 39.1 39.1 39.1 39.1 ...
    ##  $ decimalLongitude           : num  -78.1 -78.1 -78.1 -78.1 -78.1 ...
    ##  $ geodeticDatum              : logi  NA NA NA NA NA NA ...
    ##  $ coordinateUncertainty      : logi  NA NA NA NA NA NA ...
    ##  $ elevation                  : num  183 183 183 183 183 183 183 183 183 183 ...
    ##  $ elevationUncertainty       : logi  NA NA NA NA NA NA ...
    ##  $ subtypeSpecification       : chr  "primary" "primary" "primary" "primary" ...
    ##  $ transectMeter              : num  484 506 484 476 498 469 497 491 504 491 ...
    ##  $ directionFromTransect      : chr  "Right" "Right" "Right" "Left" ...
    ##  $ ninetyDegreeDistance       : num  0.5 1 2 2 2 2 1 0.5 0.5 0.5 ...
    ##  $ sampleLatitude             : logi  NA NA NA NA NA NA ...
    ##  $ sampleLongitude            : logi  NA NA NA NA NA NA ...
    ##  $ sampleGeodeticDatum        : chr  "WGS84" "WGS84" "WGS84" "WGS84" ...
    ##  $ sampleCoordinateUncertainty: logi  NA NA NA NA NA NA ...
    ##  $ sampleElevation            : logi  NA NA NA NA NA NA ...
    ##  $ sampleElevationUncertainty : logi  NA NA NA NA NA NA ...
    ##  $ addDate                    : chr  "2015-06-25" "2015-06-25" "2015-06-25" "2015-06-25" ...
    ##  $ editedDate                 : chr  "2015-07-22" "2015-07-22" "2015-07-22" "2015-07-22" ...
    ##  $ individualID               : chr  "NEON.PLA.D02.BLAN.06295" "NEON.PLA.D02.BLAN.06286" "NEON.PLA.D02.BLAN.06299" "NEON.PLA.D02.BLAN.06300" ...
    ##  $ taxonID                    : chr  "RHDA" "LOMA6" "LOMA6" "RHDA" ...
    ##  $ scientificName             : chr  "Rhamnus davurica Pall." "Lonicera maackii (Rupr.) Herder" "Lonicera maackii (Rupr.) Herder" "Rhamnus davurica Pall." ...
    ##  $ identificationQualifier    : chr  "" "" "" "" ...
    ##  $ taxonRank                  : chr  "species" "species" "species" "species" ...
    ##  $ growthForm                 : chr  "Deciduous broadleaf" "Deciduous broadleaf" "Deciduous broadleaf" "Deciduous broadleaf" ...
    ##  $ vstTag                     : logi  NA NA NA NA NA NA ...
    ##  $ samplingProtocolVersion    : logi  NA NA NA NA NA NA ...
    ##  $ measuredBy                 : chr  "cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m" "cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m" "cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m" "cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m" ...
    ##  $ identifiedBy               : chr  "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" ...
    ##  $ recordedBy                 : chr  "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" ...
    ##  $ remarks                    : chr  "" "" "" "" ...
    ##  $ dataQF                     : logi  NA NA NA NA NA NA ...

Add protocal transect map 

Link GitHub repo - https://github.com/NEONScience/NEON-geolocation

Dates - opened first in excel (06/14/2014) vs not (2014-06-14)


    # What variables are included in this dataset?
    names(status)

    ##  [1] "uid"                           "namedLocation"                
    ##  [3] "domainID"                      "siteID"                       
    ##  [5] "plotID"                        "date"                         
    ##  [7] "editedDate"                    "dayOfYear"                    
    ##  [9] "individualID"                  "taxonID"                      
    ## [11] "scientificName"                "growthForm"                   
    ## [13] "phenophaseName"                "phenophaseStatus"             
    ## [15] "phenophaseIntensityDefinition" "phenophaseIntensity"          
    ## [17] "samplingProtocolVersion"       "measuredBy"                   
    ## [19] "recordedBy"                    "remarks"                      
    ## [21] "dataQF"

    nrow(status)

    ## [1] 87292

    head(status)

    ##                                    uid          namedLocation domainID
    ## 1 d63aa5ff-c31d-425f-99b8-6d2fc890f51a BLAN_061.phenology.phe      D02
    ## 2 2c4a0bb9-e942-48fe-bd52-dacd3bc4be74 BLAN_061.phenology.phe      D02
    ## 3 3146c7ef-46a5-4c2f-8ba6-69a700142512 BLAN_061.phenology.phe      D02
    ## 4 c3555684-c2e6-46a2-9290-a3e8524fa4a2 BLAN_061.phenology.phe      D02
    ## 5 4a28f1e3-b14a-4982-9bde-b609ebd51915 BLAN_061.phenology.phe      D02
    ## 6 2c6f4463-6122-431d-8ae6-f9f6e2058965 BLAN_061.phenology.phe      D02
    ##   siteID   plotID       date editedDate dayOfYear            individualID
    ## 1   BLAN BLAN_061 2015-06-25 2015-07-22        NA NEON.PLA.D02.BLAN.06286
    ## 2   BLAN BLAN_061 2015-06-25 2015-07-22        NA NEON.PLA.D02.BLAN.06290
    ## 3   BLAN BLAN_061 2015-06-25 2015-07-22        NA NEON.PLA.D02.BLAN.06291
    ## 4   BLAN BLAN_061 2015-06-25 2015-07-22        NA NEON.PLA.D02.BLAN.06288
    ## 5   BLAN BLAN_061 2015-06-25 2015-07-22        NA NEON.PLA.D02.BLAN.06286
    ## 6   BLAN BLAN_061 2015-06-25 2015-07-22        NA NEON.PLA.D02.BLAN.06300
    ##   taxonID scientificName          growthForm       phenophaseName
    ## 1      NA             NA Deciduous broadleaf         Open flowers
    ## 2      NA             NA Deciduous broadleaf Increasing leaf size
    ## 3      NA             NA Deciduous broadleaf Increasing leaf size
    ## 4      NA             NA Deciduous broadleaf         Open flowers
    ## 5      NA             NA Deciduous broadleaf Increasing leaf size
    ## 6      NA             NA Deciduous broadleaf       Colored leaves
    ##   phenophaseStatus phenophaseIntensityDefinition phenophaseIntensity
    ## 1               no                                                  
    ## 2               no                                                  
    ## 3               no                                                  
    ## 4               no                                                  
    ## 5               no                                                  
    ## 6               no                                                  
    ##   samplingProtocolVersion                       measuredBy
    ## 1                      NA cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m
    ## 2                      NA cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m
    ## 3                      NA cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m
    ## 4                      NA cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m
    ## 5                      NA cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m
    ## 6                      NA cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m
    ##                         recordedBy remarks dataQF
    ## 1 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd    <NA>     NA
    ## 2 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd    <NA>     NA
    ## 3 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd    <NA>     NA
    ## 4 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd    <NA>     NA
    ## 5 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd    <NA>     NA
    ## 6 UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd    <NA>     NA

    str(status)

    ## 'data.frame':	87292 obs. of  21 variables:
    ##  $ uid                          : chr  "d63aa5ff-c31d-425f-99b8-6d2fc890f51a" "2c4a0bb9-e942-48fe-bd52-dacd3bc4be74" "3146c7ef-46a5-4c2f-8ba6-69a700142512" "c3555684-c2e6-46a2-9290-a3e8524fa4a2" ...
    ##  $ namedLocation                : chr  "BLAN_061.phenology.phe" "BLAN_061.phenology.phe" "BLAN_061.phenology.phe" "BLAN_061.phenology.phe" ...
    ##  $ domainID                     : chr  "D02" "D02" "D02" "D02" ...
    ##  $ siteID                       : chr  "BLAN" "BLAN" "BLAN" "BLAN" ...
    ##  $ plotID                       : chr  "BLAN_061" "BLAN_061" "BLAN_061" "BLAN_061" ...
    ##  $ date                         : chr  "2015-06-25" "2015-06-25" "2015-06-25" "2015-06-25" ...
    ##  $ editedDate                   : chr  "2015-07-22" "2015-07-22" "2015-07-22" "2015-07-22" ...
    ##  $ dayOfYear                    : logi  NA NA NA NA NA NA ...
    ##  $ individualID                 : chr  "NEON.PLA.D02.BLAN.06286" "NEON.PLA.D02.BLAN.06290" "NEON.PLA.D02.BLAN.06291" "NEON.PLA.D02.BLAN.06288" ...
    ##  $ taxonID                      : logi  NA NA NA NA NA NA ...
    ##  $ scientificName               : logi  NA NA NA NA NA NA ...
    ##  $ growthForm                   : chr  "Deciduous broadleaf" "Deciduous broadleaf" "Deciduous broadleaf" "Deciduous broadleaf" ...
    ##  $ phenophaseName               : chr  "Open flowers" "Increasing leaf size" "Increasing leaf size" "Open flowers" ...
    ##  $ phenophaseStatus             : chr  "no" "no" "no" "no" ...
    ##  $ phenophaseIntensityDefinition: chr  "" "" "" "" ...
    ##  $ phenophaseIntensity          : chr  "" "" "" "" ...
    ##  $ samplingProtocolVersion      : logi  NA NA NA NA NA NA ...
    ##  $ measuredBy                   : chr  "cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m" "cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m" "cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m" "cVPbPdjHNiEVZ3Vlm83FuXHus5z3id4m" ...
    ##  $ recordedBy                   : chr  "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" "UPKVQ90CmewX9vOGBMiPV2gMtRUi+WUd" ...
    ##  $ remarks                      : chr  NA NA NA NA ...
    ##  $ dataQF                       : logi  NA NA NA NA NA NA ...

    # min date
    min(status$date)

    ## [1] "2015-06-03"

    max(status$date)

    ## [1] "2016-12-05"

The `uid` is no important to understanding the data so we are going to remove uid. 
However, if you are every reporting an error in the data you should include this
with your report. 


    ind <- select(ind,-uid)
    status <- select (status, -uid)

## Clean up 

* remove duplicates (full rows)
* convert date
* retain only the latest `editedDate` in the perIndividual table.

### Remove duplicates



    ind_noD <- distinct(ind)
    nrow(ind_noD)

    ## [1] 1557

    status_noD<-distinct(status)
    nrow(status_noD)

    ## [1] 85693

## Figure out which names overlap 


    sameName <- intersect(names(status_noD), names(ind_noD))
    sameName

    ##  [1] "namedLocation"           "domainID"               
    ##  [3] "siteID"                  "plotID"                 
    ##  [5] "editedDate"              "individualID"           
    ##  [7] "taxonID"                 "scientificName"         
    ##  [9] "growthForm"              "samplingProtocolVersion"
    ## [11] "measuredBy"              "recordedBy"             
    ## [13] "remarks"                 "dataQF"

These fields have different values we want to keep. Rename common fields before joining: 
* editedDate
* measuredBy
* recordedBy
* samplingProtocolVersion
* remarks
* dataQF


    # rename status editedDate
    status_noD <- rename(status_noD, editedDateStat=editedDate, measuredByStat=measuredBy, recordedByStat=recordedBy, samplingProtocolVersionStat=samplingProtocolVersion, remarksStat=remarks, dataQFStat=dataQF)


## Convert to Date

Our `addDate` and `date` columns are stored as a `character` class. We need to convert it to 
date-time class. 


    # convert column to date class
    ind_noD$editedDate <- as.Date(ind_noD$editedDate)
    str(ind_noD$editedDate)

    ##  Date[1:1557], format: "2015-07-22" "2015-07-22" "2015-07-22" "2015-07-22" "2015-07-22" ...

    status_noD$date <- as.Date(status_noD$date)
    str(status_noD$date)

    ##  Date[1:85693], format: "2015-06-25" "2015-06-25" "2015-06-25" "2015-06-25" "2015-06-25" ...



## Retain only the latest indivdual record

Only the latest `editedDate` on ind



    # retain only the max of the date for each individualID
    ind_last <- ind_noD %>%
    	group_by(individualID) %>%
    	filter(editedDate==max(editedDate))
    
    # oh wait, duplicate dates, retain only one
    ind_lastnoD <- ind_last %>%
    	group_by(editedDate, individualID) %>%
    	filter(row_number()==1)

## Join dataframes


    # Create a new dataframe "phe_ind" with all the data from status and some from ind_lastnoD
    phe_ind <- left_join(status_noD, ind_lastnoD)

    ## Joining, by = c("namedLocation", "domainID", "siteID", "plotID", "individualID", "taxonID", "scientificName", "growthForm")

    ## Error in left_join_impl(x, y, by$x, by$y, suffix$x, suffix$y, check_na_matches(na_matches)): Can't join on 'taxonID' x 'taxonID' because of incompatible types (character / logical)

Ack!  Two different data types.  Why?  NA in taxonID is a logicial, but all the 
names are character.  

Try it again.  

`taxonID` and `scientificName` are provided for convenience in Status table, but
most up to date data is always in the `phe_perindividual.csv` files. Therefore, 
we'll remove from ...



    # drop taxonID, scientificName
    status_noD <- select (status_noD, -taxonID, -scientificName)
    
    # Create a new dataframe "phe_ind" with all the data from status and some from ind_lastnoD
    phe_ind <- left_join(status_noD, ind_lastnoD)

    ## Joining, by = c("namedLocation", "domainID", "siteID", "plotID", "individualID", "growthForm")


### What do we do with the data?  


Build a DF of interest with single site, species, and phenophase called `phe_1sp`.


## Select Site(s) of Interest


    # set site of interest
    siteOfInterest <- "SCBI"
    
    # use filter to select only the site of Interest 
    # using %in% allows one to add a vector if you want more than one site. 
    phe_1sp <- filter(phe_ind, siteID %in% siteOfInterest)

## Select Species of Interest



    # see which species are present
    unique(phe_1sp$taxonID)

    ## [1] "JUNI" "MIVI" "LITU"

    speciesOfInterest <- "LITU"
    
    #subset to just "LITU"
    # here just use == but could also use %in%
    phe_1sp <- filter(phe_1sp, taxonID==speciesOfInterest)
    
    # check that it worked
    unique(phe_1sp$taxonID)

    ## [1] "LITU"


## Select Species of Interest


    # see which species are present
    unique(phe_1sp$phenophaseName)

    ## [1] "Colored leaves"       "Increasing leaf size" "Leaves"              
    ## [4] "Open flowers"         "Breaking leaf buds"   "Falling leaves"

    phenophaseOfInterest <- "Leaves"
    
    #subset to just the phenosphase of Interest 
    phe_1sp <- filter(phe_1sp, phenophaseName %in% phenophaseOfInterest)
    
    # check that it worked
    unique(phe_1sp$phenophaseName)

    ## [1] "Leaves"

## Total in Phenophase of Interest

Calculate the phenophase total Yes of total Individuals


    # Total in status by day
    sampSize <- count(phe_1sp, date)
    inStat <- phe_1sp %>%
    	group_by(date) %>%
      count(phenophaseStatus)
    inStat <- full_join(sampSize, inStat, by="date")
    
    # Retain only Yes
    inStat_T <- filter(inStat, phenophaseStatus %in% "yes")

## Plot with ggplot
The `ggplot()` function within the `ggplot2` package gives us more control
over plot appearance. However, to use `ggplot` we need to learn a slightly 
different syntax. Three basic elements are needed for `ggplot()` to work:

 1. The **data_frame:** containing the variables that we wish to plot,
 2. **`aes` (aesthetics):** which denotes which variables will map to the x-, y-
 (and other) axes,  
 3. **`geom_XXXX` (geometry):** which defines the data's graphical representation
 (e.g. points (`geom_point`), bars (`geom_bar`), lines (`geom_line`), etc).
 
The syntax begins with the base statement that includes the `data_frame`
(`inStat_T`) and associated x (`date`) and y (`n`) variables to be
plotted:

`ggplot(inStat_T, aes(date, n))`

To successfully plot, the last piece that is needed is the `geom`etry type. In 
this case, we want to create a scatterplot so we can add `+ geom_point()`.

## Bar Plots with ggplot
We can use ggplot to create bar plots too. Let's create a bar plot of total 
daily precipitation next. A bar plot might be a better way to represent a total
daily value. To create a bar plot, we change the `geom` element from
`geom_point()` to `geom_bar()`.  

The default setting for a ggplot bar plot -  `geom_bar()` - is a histogram
designated by `stat="bin"`. However, in this case, we want to plot count values. 
We can use `geom_bar(stat="identity")` to force ggplot to plot actual values.



    # plot number of individuals in leaf
    
    phenoPlot <- ggplot(inStat_T, aes(date, n.y)) +
        geom_bar(stat="identity", na.rm = TRUE) +
        ggtitle("Total Individuals in Leaf") +
        xlab("Date") + ylab("Number of Individuals") +
        theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
        theme(text = element_text(size=18))
    
    phenoPlot

![ ]({{ site.baseurl }}/images/rfigs/OSIS-phenology-series/01_explore_phenology_data/plot-leaves-total-1.png)



    inStat_T$percent<- ((inStat_T$n.y)/inStat_T$n.x)*100
    
    # plot percent of leaves
    
    phenoPlot_P <- ggplot(inStat_T, aes(date, percent)) +
        geom_bar(stat="identity", na.rm = TRUE) +
        ggtitle("Proportion in Leaf") +
        xlab("Date") + ylab("% of Individuals") +
        theme(plot.title = element_text(lineheight=.8, face="bold", size = 20)) +
        theme(text = element_text(size=18))
    
    phenoPlot_P

![ ]({{ site.baseurl }}/images/rfigs/OSIS-phenology-series/01_explore_phenology_data/plot-leaves-percentage-1.png)

## Re-evaluate dataset
The plots demonstrate that, while the 2016 data show the nice expected pattern 
of increasing leaf-out, peak, and drop-off, we seem to be missing the increase 
in leaf-out in 2015. That may create problems with downstream analyses. Let's 
filter the dataset to include just 2016.


## Select 2016 SCBI data


    # use filter to select only the site of Interest 
    # using %in% allows one to add a vector if you want more than one site. 
    phe_1sp_2016 <- filter(phe_1sp, date >= "2016-01-01")






