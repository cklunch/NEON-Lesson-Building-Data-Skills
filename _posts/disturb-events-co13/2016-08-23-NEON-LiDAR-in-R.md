---
layout: post
title: "Quantifying Disturbance Events Drivers & Impacts: LiDAR"
date:  2015-11-23
authors: [Leah A. Wasser]
dateCreated:  2015-05-18
lastModified: 2016-10-05
categories: [Coding and Informatics]
category: coding-and-informatics
tags: [R, time-series]
mainTag:
scienceThemes: [phenology, disturbance]
description: "About description here."
code1:
image:
  feature: TeachingModules.jpg
  credit: A National Ecological Observatory Network (NEON) - Teaching Module
  creditlink: http://www.neonscience.org
permalink: /R/NEON-lidar-flood-CO13/
code1: Boulder-Flood-Data.R
comments: false
---

{% include _toc.html %}

 

# How do We Measure Changes in Terrain? LiDAR!

<iframe width="640" height="360" src="https://www.youtube.com/embed/EYbhNSUnIdU" frameborder="0" allowfullscreen></iframe>

1. How can LiDAR data be collected?  
2. How might we use LiDAR to hlep study the 2013 Colorado Floods?

### Using LiDAR Data

LiDAR data can be used to create many different models of a landscape.  This
brief lesson on 
<a href="http://neondataskills.org/remote-sensing/2_LiDAR-Data-Concepts_Activity2/" target="_blank">
"What is a CHM, DSM and DTM? About Gridded, Raster LiDAR Data"</a> explores
three important landscape models that are commonly used.  

1. How might we use a CHM, DSM or DTM model to better understand what happened
in the 2013 Colorado Flood? 
2. Would you use only one of the models or could you use two or more of them
together?

###More Details on LiDAR

If you are particularly interested in how LiDAR works consider taking a closer
look at how the data is collected and represented by going through this tutorial
on <a href="http://neondataskills.org/remote-sensing/1_About-LiDAR-Data-Light-Detection-and-Ranging_Activity1/" target="_blank"> "Light Detection and Ranging."</a> 



#Light Detection and Ranging

<figure>

<img src="http://data-lessons.github.io/NEON-R-Spatial-Raster/images/raster_timeseries/lidarTree-height.png">
<figcaption>Digital Terrain Models, Digital Surface Models and Canopy height
models are three common lidar derived data products. The digital terrain model
allows scientists to study changes in terrain (topography) over time.
</figcaption>
</figure>

# 

http://neondataskills.org/self-paced-tutorial/1_About-LiDAR-Data-Light-Detection-and-Ranging_Activity1/  

<figure>

<img src="http://neonhighered.org/websiteGraphics/2013-Boulder-flood-data.gif
">
<figcaption>2013 Flood damage to Lee Hill Road, Boulder, Colorado.
</figcaption>
</figure>


    # load libraries
    library(raster)

    ## Loading required package: sp

    library(rgdal)

    ## rgdal: version: 1.1-10, (SVN revision 622)
    ##  Geospatial Data Abstraction Library extensions to R successfully loaded
    ##  Loaded GDAL runtime: GDAL 1.11.4, released 2016/01/25
    ##  Path to GDAL shared files: /Library/Frameworks/R.framework/Versions/3.3/Resources/library/rgdal/gdal
    ##  Loaded PROJ.4 runtime: Rel. 4.9.1, 04 March 2015, [PJ_VERSION: 491]
    ##  Path to PROJ.4 shared files: /Library/Frameworks/R.framework/Versions/3.3/Resources/library/rgdal/proj
    ##  Linking to sp version: 1.2-3

    library(RColorBrewer)
    
    # set working directory to ensure R can find the file we wish to import
    # setwd("working-dir-path-here")



    # Load s into R
    DTM_pre <- raster("lidar/pre-flood/preDTM3.tif")

    ## Error in .rasterObjectFromFile(x, band = band, objecttype = "RasterLayer", : Cannot create a RasterLayer object from this file. (file does not exist)

    DTM_post <- raster("lidar/post-flood/postDTM3.tif")

    ## Error in .rasterObjectFromFile(x, band = band, objecttype = "RasterLayer", : Cannot create a RasterLayer object from this file. (file does not exist)

    # View raster structure
    DTM_pre

    ## Error in eval(expr, envir, enclos): object 'DTM_pre' not found

    DTM_post

    ## Error in eval(expr, envir, enclos): object 'DTM_post' not found



    # import DSM hillshade
    DTMpre_hill <- raster("lidar/pre-flood/preDTMhill3.tif")

    ## Error in .rasterObjectFromFile(x, band = band, objecttype = "RasterLayer", : Cannot create a RasterLayer object from this file. (file does not exist)

    DTMpost_hill <- 
      raster("lidar/post-flood/postDTMhill3.tif")

    ## Error in .rasterObjectFromFile(x, band = band, objecttype = "RasterLayer", : Cannot create a RasterLayer object from this file. (file does not exist)

    # plot hillshade using a grayscale color ramp that looks like shadows.
    plot(DTMpre_hill,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
        main="Hillshade \n Lee Hill Rd. Boulder County",
        axes=FALSE)

    ## Error in plot(DTMpre_hill, col = grey(1:100/100), legend = FALSE, main = "Hillshade \n Lee Hill Rd. Boulder County", : object 'DTMpre_hill' not found

    plot(DTMpost_hill,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
        main="Hillshade \n Lee Hill Rd. Boulder County",
        axes=FALSE)

    ## Error in plot(DTMpost_hill, col = grey(1:100/100), legend = FALSE, main = "Hillshade \n Lee Hill Rd. Boulder County", : object 'DTMpost_hill' not found



    # plot Pre-flood w/ hillshade
    plot(DTMpre_hill,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
    		main="Lee Hill Rd. Boulder County\nPre-Flood",
        axes=FALSE)

    ## Error in plot(DTMpre_hill, col = grey(1:100/100), legend = FALSE, main = "Lee Hill Rd. Boulder County\nPre-Flood", : object 'DTMpre_hill' not found

    # note \n in the title forces a line break in the title
    plot(DTM_pre, 
    		 axes=FALSE,
    		 alpha=0.5,
    		 add=T)

    ## Error in plot(DTM_pre, axes = FALSE, alpha = 0.5, add = T): object 'DTM_pre' not found

    # plot Post-flood w/ hillshade
    plot(DTMpost_hill,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
    		main="Lee Hill Rd. Boulder County\nPost-Flood",
        axes=FALSE)

    ## Error in plot(DTMpost_hill, col = grey(1:100/100), legend = FALSE, main = "Lee Hill Rd. Boulder County\nPost-Flood", : object 'DTMpost_hill' not found

    plot(DTM_post, 
    		 axes=FALSE,
    		 alpha=0.5,
    		 add=T)

    ## Error in plot(DTM_post, axes = FALSE, alpha = 0.5, add = T): object 'DTM_post' not found





    # want erosion to be neg, deposition to be positive, therefore post - pre
    Change_Model <- DTM_post-DTM_pre

    ## Error in eval(expr, envir, enclos): object 'DTM_post' not found

    plot(Change_Model,
    		 main="Lee Hill Rd. Boulder County\nPost-Flood",
    		 axes=FALSE)

    ## Error in plot(Change_Model, main = "Lee Hill Rd. Boulder County\nPost-Flood", : object 'Change_Model' not found


    difCol5 = c("#d7191c","#fdae61","#ffffbf","#abd9e9","#2c7bb6")
    difCol7 = c("#d73027","#fc8d59","#fee090","#ffffbf","#e0f3f8","#91bfdb","#4575b4")
    
    plot(DTMpost_hill,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
    		main="Elevation Change Post Flood\nLee Hill Rd. Boulder County",
        axes=FALSE)

    ## Error in plot(DTMpost_hill, col = grey(1:100/100), legend = FALSE, main = "Elevation Change Post Flood\nLee Hill Rd. Boulder County", : object 'DTMpost_hill' not found

    plot(Change_Model,
    		 breaks = c(-5,-1,-0.5,0.5,1,10),
    		 col= difCol5,
    		 axes=FALSE,
    		 alpha=0.4,
    		 add =T)

    ## Error in plot(Change_Model, breaks = c(-5, -1, -0.5, 0.5, 1, 10), col = difCol5, : object 'Change_Model' not found

## Crop to local area 


    # manually crop by drawing a box
    # plot the raster you want to crop from 
    plot(DTMpost_hill,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
    		main="Lee Hill Rd. Boulder County\nPre-Flood",
        axes=FALSE)

    ## Error in plot(DTMpost_hill, col = grey(1:100/100), legend = FALSE, main = "Lee Hill Rd. Boulder County\nPre-Flood", : object 'DTMpost_hill' not found

    # note \n in the title forces a line break in the title
    plot(Change_Model,
    		 breaks = c(-5,-1,-0.5,0.5,1,10),
    		 col= difCol5,
    		 axes=FALSE,
    		 alpha=0.4,
    		 add =T)

    ## Error in plot(Change_Model, breaks = c(-5, -1, -0.5, 0.5, 1, 10), col = difCol5, : object 'Change_Model' not found

    # crop by designating two opposite corners
    #cropbox1<-drawExtent()
    
    # Just ot keep track of what the coordinates were
    cropbox1<-c(473792.6,474999,4434526,4435453)
    
    # crop all layers to this crop box
    DTM_pre_crop <- crop(DTM_pre, cropbox1)

    ## Error in crop(DTM_pre, cropbox1): object 'DTM_pre' not found

    DTM_post_crop <- crop(DTM_post, cropbox1)

    ## Error in crop(DTM_post, cropbox1): object 'DTM_post' not found

    DTMpre_hill_crop <- crop(DTMpre_hill,cropbox1)

    ## Error in crop(DTMpre_hill, cropbox1): object 'DTMpre_hill' not found

    DTMpost_hill_crop <- crop(DTMpost_hill,cropbox1)

    ## Error in crop(DTMpost_hill, cropbox1): object 'DTMpost_hill' not found

    Change_Model_crop <- crop(Change_Model, cropbox1)

    ## Error in crop(Change_Model, cropbox1): object 'Change_Model' not found

    # plot all again using the cropped layers
    
    # PRE
    plot(DTMpre_hill_crop,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
    		main="Lee Hill Rd. Boulder County\nPre-Flood",
        axes=FALSE)

    ## Error in plot(DTMpre_hill_crop, col = grey(1:100/100), legend = FALSE, : object 'DTMpre_hill_crop' not found

    # note \n in the title forces a line break in the title
    plot(DTM_pre_crop, 
    		 axes=FALSE,
    		 alpha=0.5,
    		 add=T)

    ## Error in plot(DTM_pre_crop, axes = FALSE, alpha = 0.5, add = T): object 'DTM_pre_crop' not found

    # POST
    # plot Post-flood w/ hillshade
    plot(DTMpost_hill_crop,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
    		main="Lee Hill Rd. Boulder County\nPost-Flood",
        axes=FALSE)

    ## Error in plot(DTMpost_hill_crop, col = grey(1:100/100), legend = FALSE, : object 'DTMpost_hill_crop' not found

    plot(DTM_post_crop, 
    		 axes=FALSE,
    		 alpha=0.5,
    		 add=T)

    ## Error in plot(DTM_post_crop, axes = FALSE, alpha = 0.5, add = T): object 'DTM_post_crop' not found

    # CHANGE
    plot(DTMpost_hill_crop,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
    		main="Elevation Change Post Flood\nLee Hill Rd. Boulder County",
        axes=FALSE)

    ## Error in plot(DTMpost_hill_crop, col = grey(1:100/100), legend = FALSE, : object 'DTMpost_hill_crop' not found

    plot(Change_Model_crop,
    		 breaks = c(-5,-1,-0.5,0.5,1,10),
    		 col= difCol5,
    		 axes=FALSE,
    		 alpha=0.4,
    		 add =T)

    ## Error in plot(Change_Model_crop, breaks = c(-5, -1, -0.5, 0.5, 1, 10), : object 'Change_Model_crop' not found


    # manually crop by drawing a box
    # plot the raster you want to crop from 
    plot(DTMpost_hill,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
    		main="Lee Hill Rd. Boulder County\nPre-Flood",
        axes=FALSE)

    ## Error in plot(DTMpost_hill, col = grey(1:100/100), legend = FALSE, main = "Lee Hill Rd. Boulder County\nPre-Flood", : object 'DTMpost_hill' not found

    # note \n in the title forces a line break in the title
    plot(Change_Model,
    		 breaks = c(-5,-1,-0.5,0.5,1,10),
    		 col= difCol5,
    		 axes=FALSE,
    		 alpha=0.4,
    		 add =T)

    ## Error in plot(Change_Model, breaks = c(-5, -1, -0.5, 0.5, 1, 10), col = difCol5, : object 'Change_Model' not found

    # crop by designating two opposite corners
    #cropbox2<-drawExtent()
    
    # Just ot keep track of what the coordinates were
    cropbox2<-c(474606.8,475005,4434746,4434978)
    
    # crop all layers to this crop box
    DTM_pre_crop2 <- crop(DTM_pre, cropbox2)

    ## Error in crop(DTM_pre, cropbox2): object 'DTM_pre' not found

    DTM_post_crop2 <- crop(DTM_post, cropbox2)

    ## Error in crop(DTM_post, cropbox2): object 'DTM_post' not found

    DTMpre_hill_crop2 <- crop(DTMpre_hill,cropbox2)

    ## Error in crop(DTMpre_hill, cropbox2): object 'DTMpre_hill' not found

    DTMpost_hill_crop2 <- crop(DTMpost_hill,cropbox2)

    ## Error in crop(DTMpost_hill, cropbox2): object 'DTMpost_hill' not found

    Change_Model_crop2 <- crop(Change_Model, cropbox2)

    ## Error in crop(Change_Model, cropbox2): object 'Change_Model' not found

    # plot all again using the cropped layers
    
    # PRE
    png("lidar_pre.png", width = 10, height = 10, units = 'in', res = 300)
    
    plot(DTMpre_hill_crop2,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
    		main="Lee Hill Rd. Boulder County\nPre-Flood",
        axes=FALSE)

    ## Error in plot(DTMpre_hill_crop2, col = grey(1:100/100), legend = FALSE, : object 'DTMpre_hill_crop2' not found

    # note \n in the title forces a line break in the title
    plot(DTM_pre_crop2, 
    		 axes=FALSE,
    		 alpha=0.5,
    		 add=T)

    ## Error in plot(DTM_pre_crop2, axes = FALSE, alpha = 0.5, add = T): object 'DTM_pre_crop2' not found

    dev.off()

    ## RStudioGD 
    ##         2

    # POST
    png("lidar_post.png", width = 10, height = 10, units = 'in', res = 300)
    # plot Post-flood w/ hillshade
    plot(DTMpost_hill_crop2,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
    		main="Lee Hill Rd. Boulder County\nPost-Flood",
        axes=FALSE)

    ## Error in plot(DTMpost_hill_crop2, col = grey(1:100/100), legend = FALSE, : object 'DTMpost_hill_crop2' not found

    plot(DTM_post_crop2, 
    		 axes=FALSE,
    		 alpha=0.5,
    		 add=T)

    ## Error in plot(DTM_post_crop2, axes = FALSE, alpha = 0.5, add = T): object 'DTM_post_crop2' not found

    dev.off()

    ## RStudioGD 
    ##         2

    # CHANGE
    png("lidar_change.png", width = 10, height = 10, units = 'in', res = 300)
    plot(DTMpost_hill_crop2,
        col=grey(1:100/100),  # create a color ramp of grey colors
        legend=FALSE,
    		main="Elevation Change Post Flood\nLee Hill Rd. Boulder County",
        axes=FALSE)

    ## Error in plot(DTMpost_hill_crop2, col = grey(1:100/100), legend = FALSE, : object 'DTMpost_hill_crop2' not found

    plot(Change_Model_crop2,
    		 breaks = c(-5,-1,-0.5,0.5,1,10),
    		 col= difCol5,
    		 axes=FALSE,
    		 alpha=0.4,
    		 add =T)

    ## Error in plot(Change_Model_crop2, breaks = c(-5, -1, -0.5, 0.5, 1, 10), : object 'Change_Model_crop2' not found

    dev.off()

    ## RStudioGD 
    ##         2

