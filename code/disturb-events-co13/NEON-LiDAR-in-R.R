## ----load-libraries------------------------------------------------------
# load libraries
library(raster)
library(rgdal)
library(RColorBrewer)

# set working directory to ensure R can find the file we wish to import
# setwd("working-dir-path-here")

## ----open-DTMs-----------------------------------------------------------
# Load s into R
DTM_pre <- raster("lidar/pre-flood/preDTM3.tif")
DTM_post <- raster("lidar/post-flood/postDTM3.tif")

# View raster structure
DTM_pre
DTM_post

## ----open-hillshade------------------------------------------------------
# import DSM hillshade
DTMpre_hill <- raster("lidar/pre-flood/preDTMhill3.tif")
DTMpost_hill <- 
  raster("lidar/post-flood/postDTMhill3.tif")

# plot hillshade using a grayscale color ramp that looks like shadows.
plot(DTMpre_hill,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
    main="Hillshade \n Lee Hill Rd. Boulder County",
    axes=FALSE)

plot(DTMpost_hill,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
    main="Hillshade \n Lee Hill Rd. Boulder County",
    axes=FALSE)


## ----plot-rasters--------------------------------------------------------

# plot Pre-flood w/ hillshade
plot(DTMpre_hill,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
		main="Lee Hill Rd. Boulder County\nPre-Flood",
    axes=FALSE)
# note \n in the title forces a line break in the title
plot(DTM_pre, 
		 axes=FALSE,
		 alpha=0.5,
		 add=T)

# plot Post-flood w/ hillshade
plot(DTMpost_hill,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
		main="Lee Hill Rd. Boulder County\nPost-Flood",
    axes=FALSE)

plot(DTM_post, 
		 axes=FALSE,
		 alpha=0.5,
		 add=T)


## ----create-difference-model---------------------------------------------
# want erosion to be neg, deposition to be positive, therefore post - pre
Change_Model <- DTM_post-DTM_pre

plot(Change_Model,
		 main="Lee Hill Rd. Boulder County\nPost-Flood",
		 axes=FALSE)


## ----pretty-diff-model---------------------------------------------------
difCol5 = c("#d7191c","#fdae61","#ffffbf","#abd9e9","#2c7bb6")
difCol7 = c("#d73027","#fc8d59","#fee090","#ffffbf","#e0f3f8","#91bfdb","#4575b4")

plot(DTMpost_hill,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
		main="Elevation Change Post Flood\nLee Hill Rd. Boulder County",
    axes=FALSE)

plot(Change_Model,
		 breaks = c(-5,-1,-0.5,0.5,1,10),
		 col= difCol5,
		 axes=FALSE,
		 alpha=0.4,
		 add =T)

## ----crop-raster---------------------------------------------------------
# manually crop by drawing a box
# plot the raster you want to crop from 
plot(DTMpost_hill,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
		main="Lee Hill Rd. Boulder County\nPre-Flood",
    axes=FALSE)
# note \n in the title forces a line break in the title
plot(Change_Model,
		 breaks = c(-5,-1,-0.5,0.5,1,10),
		 col= difCol5,
		 axes=FALSE,
		 alpha=0.4,
		 add =T)

# crop by designating two opposite corners
#cropbox1<-drawExtent()

# Just ot keep track of what the coordinates were
cropbox1<-c(473792.6,474999,4434526,4435453)

# crop all layers to this crop box
DTM_pre_crop <- crop(DTM_pre, cropbox1)
DTM_post_crop <- crop(DTM_post, cropbox1)
DTMpre_hill_crop <- crop(DTMpre_hill,cropbox1)
DTMpost_hill_crop <- crop(DTMpost_hill,cropbox1)
Change_Model_crop <- crop(Change_Model, cropbox1)

# plot all again using the cropped layers

# PRE
plot(DTMpre_hill_crop,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
		main="Lee Hill Rd. Boulder County\nPre-Flood",
    axes=FALSE)
# note \n in the title forces a line break in the title
plot(DTM_pre_crop, 
		 axes=FALSE,
		 alpha=0.5,
		 add=T)

# POST
# plot Post-flood w/ hillshade
plot(DTMpost_hill_crop,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
		main="Lee Hill Rd. Boulder County\nPost-Flood",
    axes=FALSE)

plot(DTM_post_crop, 
		 axes=FALSE,
		 alpha=0.5,
		 add=T)

# CHANGE
plot(DTMpost_hill_crop,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
		main="Elevation Change Post Flood\nLee Hill Rd. Boulder County",
    axes=FALSE)

plot(Change_Model_crop,
		 breaks = c(-5,-1,-0.5,0.5,1,10),
		 col= difCol5,
		 axes=FALSE,
		 alpha=0.4,
		 add =T)

## ----crop-raster-2-------------------------------------------------------
# manually crop by drawing a box
# plot the raster you want to crop from 
plot(DTMpost_hill,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
		main="Lee Hill Rd. Boulder County\nPre-Flood",
    axes=FALSE)
# note \n in the title forces a line break in the title
plot(Change_Model,
		 breaks = c(-5,-1,-0.5,0.5,1,10),
		 col= difCol5,
		 axes=FALSE,
		 alpha=0.4,
		 add =T)

# crop by designating two opposite corners
#cropbox2<-drawExtent()

# Just ot keep track of what the coordinates were
cropbox2<-c(474606.8,475005,4434746,4434978)

# crop all layers to this crop box
DTM_pre_crop2 <- crop(DTM_pre, cropbox2)
DTM_post_crop2 <- crop(DTM_post, cropbox2)
DTMpre_hill_crop2 <- crop(DTMpre_hill,cropbox2)
DTMpost_hill_crop2 <- crop(DTMpost_hill,cropbox2)
Change_Model_crop2 <- crop(Change_Model, cropbox2)

# plot all again using the cropped layers

# PRE
png("lidar_pre.png", width = 10, height = 10, units = 'in', res = 300)

plot(DTMpre_hill_crop2,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
		main="Lee Hill Rd. Boulder County\nPre-Flood",
    axes=FALSE)
# note \n in the title forces a line break in the title
plot(DTM_pre_crop2, 
		 axes=FALSE,
		 alpha=0.5,
		 add=T)

dev.off()

# POST
png("lidar_post.png", width = 10, height = 10, units = 'in', res = 300)
# plot Post-flood w/ hillshade
plot(DTMpost_hill_crop2,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
		main="Lee Hill Rd. Boulder County\nPost-Flood",
    axes=FALSE)

plot(DTM_post_crop2, 
		 axes=FALSE,
		 alpha=0.5,
		 add=T)

dev.off()

# CHANGE
png("lidar_change.png", width = 10, height = 10, units = 'in', res = 300)
plot(DTMpost_hill_crop2,
    col=grey(1:100/100),  # create a color ramp of grey colors
    legend=FALSE,
		main="Elevation Change Post Flood\nLee Hill Rd. Boulder County",
    axes=FALSE)

plot(Change_Model_crop2,
		 breaks = c(-5,-1,-0.5,0.5,1,10),
		 col= difCol5,
		 axes=FALSE,
		 alpha=0.4,
		 add =T)

dev.off()

