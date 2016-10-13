---
layout: post
title: "Quantifying The Drivers and Impacts of Natural Disturbance Events – The 2013 Colorado Floods"
date: 2016-04-09
authors: [Leah A. Wasser, Megan A. Jones]
dateCreated: 2015-05-18
lastModified: 2016-10-13
categories: [teaching-module]
tags: [R, time-series]
mainTag: disturb-event-co13
scienceThemes: distrubance
description: "This lesson demonstrates ways that scientists identify and use 
data that they use to study disturbance events. Further, it encourages students 
to think about why we need to quantify change and  different types of data 
needed to quantify the change. This lesson focuses on flooding as a natural 
disturbance event with impacts on the local human populations. Specifically, it 
focuses on the causes and impacts of flooding that occurred in 2013 throughout 
Colorado with an emphasis on Boulder county."
image:
  feature: TeachingModules.jpg
  credit: A National Ecological Observatory Network (NEON) - Teaching Module
  creditlink: http://www.neonscience.org
permalink: /teaching-module/disturb-event-co13/detailed-lesson
code1: 
comments: true
---

{% include _toc.html %}

## The 2013 Colorado Front Range Flood

<iframe width="560" height="315" src="https://www.youtube.com/embed/DJqTmByRma8" frameborder="0" allowfullscreen></iframe>
 
## Introduction to Disturbance Events

<i class="fa fa-star"></i> **Definition:**  In ecology, a **disturbance event** 
is a temporary change in environmental conditions that causes a pronounced 
change in the ecosystem. Common disturbance events include floods, fires, 
earthquakes, and tsunamis. 
{: .notice}


Within ecology, disturbance events are those events which cause dramatic change
in an ecosystem through a temporary, often rapid, change in environmental
conditions. Although the disturbance events themselves can be of short duration,
the ecological effects last decades, if not longer. 

Common examples of natural ecological disturbances include hurricanes, fires, 
floods, earthquakes and windstorms. 

 <figure>
	<a href="{{ site.baseurl }}images/disturb-events-co13/Natural-disturbance.png">
	<img src="{{ site.baseurl }}images/disturb-events-co13/Natural-disturbance.png"></a>
	<figcaption> Common natural ecological disturbances.  
	</figcaption>
</figure>

Disturbance events can also be human caused: clear cuts when logging, fires to 
clear forests for cattle grazing or the building of new housing developments 
are all common disturbances. 

 <figure>
	<a href="{{ site.baseurl }}images/disturb-events-co13/Anthro-disturbance.png">
	<img src="{{ site.baseurl }}images/disturb-events-co13/Anthro-disturbance.png"></a>
	<figcaption> Common human-caused ecological disturbances.  
	</figcaption>
</figure>

Ecological communities are often more resilient to some types of disturbance than
others. Some communities are even dependent on cyclical disturbance events. 
Lodgepole pine (_Pinus_ _contorta_) forests in the Western US are dependent on
frequent stand-replacing fires to release seeds and spur the growth of young 
trees.  

 <figure>
	<a href="{{ site.baseurl }}/images/disturb-events-co13/Lodgepole_pine_Yellowstone_1998_near_firehole.jpg">
	<img src="{{ site.baseurl }}/images/disturb-events-co13/Lodgepole_pine_Yellowstone_1998_near_firehole.jpg"></a>
	<figcaption> Regrowth of Lodgepole Pine (<i>Pinus contorta</i>) after a stand-replacing fire.  
	Source: Jim Peaco, September 1998, Yellowstone Digital Slide Files; 
	<a href="https://commons.wikimedia.org/wiki/File:Lodgepole_pine_Yellowstone_1998_near_firehole.jpg" target="_blank">Wikipedia Commons</a>. 
	</figcaption>
</figure>

However, in discussions of ecological disturbance events we think about events 
that disrupt the status of the ecosystem and change the structure of the
landscape. 

In this lesson we will dig into the causes and disturbances caused during a storm
in September 2013 along the Colorado Front Range. 

## Driver: Climatic & Atmospheric Patterns

### Drought
How do we measure drought? 

<i class="fa fa-star"></i> **Definition:** The **Palmer Drought Severity 
Index** is a measure of soil moisture content. It is calculated from soil 
available water content,precipitation and temperature data. The values range 
from **extreme drought** (values <-4.0) through **near normal** (-.49 to .49) 
to **extremely moist** (>4.0).
{: .notice}

Bonus: There are several other commonly used drought indices. The 
<a href="http://drought.unl.edu/Planning/Monitoring/ComparisonofIndicesIntro" target="_blank"> National Drought Mitigation Center </a> 
provides a comparison of the different indices.  

This interactive plot shows the Palmer Drought Severity Index from 1991 through 
2015 for Colorado. 

<iframe width="900" height="800" frameborder="0" scrolling="no" src="https://plot.ly/~NEONDataSkills/2.embed"></iframe>

Figure Caption: Palmer Drought Severity Index for Colorado 1991-2015. Source:
   National Ecological Observatory Network (NEON) based on data from 
   <a href="http://www7.ncdc.noaa.gov/CDO/CDODivisionalSelect.jsp"
   target="_blank"> National Climatic Data Center–NOAA</a>. 

#### Questions
Use the figure above to answer these questions: 

1. In this dataset, what years are **near normal**, **extreme drought**, and 
**extreme wet** on the Palmer Drought Severity Index? 
1. What are the patterns of drought within Colorado that you observe using this 
Palmer Drought Severity Index?
1. What were the drought conditions immediately before the September 2013
floods? 

Over this decade and a half, there have been several cycles of dry and wet 
periods. The 2013 flooding occurred right at the end of a severe drought. 

There is a connection between the dry soils during a drought and the potential 
for flooding. In a severe drought the top layers of the soil dry out. Organic 
matter, spongy and absorbent in moist topsoil, may dessicate and be transported 
by the winds to other areas. Some soil types, like clay, can dry to a 
near-impermeable brick causing water to flow across the top instead of sinking 
into the soils. 

**Optional Data Activity** <a href="{{ site.baseurl }}/R/nCLIMDIV-Palmer-Drought-Data-R" target="_blank">Visualize <b>Palmer Drought Severity Index Data </b> in R to Better Understand the 2013 Colorado Floods</a>.

### Atmospheric Conditions
In early September 2013, a slow moving cold front moved through Colorado
intersecting with a warm, humid front. The clash between the cold and warm
fronts yielded heavy rain and devastating flooding across the Front Range in
Colorado.

<figure>
   <a href="https://en.wikipedia.org/wiki/2013_Colorado_floods#/media/File:North_American_Water_Vapor_Systems.gif">
   <img src="https://upload.wikimedia.org/wikipedia/commons/9/97/North_American_Water_Vapor_Systems.gif"></a>
   <figcaption>This animated loop shows water vapor systems over the western 
   area of North America on September 12th, 2013 as recorded by the GOES-15 and 
   GOES-13 satellites. Source: Cooperative Institute for Meteorological 
   Satellite Studies (CIMSS), University of Wisconsin – Madison, USA -
    [CIMSS](http://cimss.ssec.wisc.edu/goes/blog/archives/13876)
    </figcaption>
</figure>

The storm that caused the 2013 Colorado flooding was kept in a confined area 
over the Eastern Range of the Rocky Mountains in Colorado by these water vapor 
systems. 

## Driver: Precipitation
How do we measure precipitation? 

<i class="fa fa-star"></i> **Definition:** Precipitation is the moisture that
falls from clouds including rain, hail and snow. 
{: .notice}

Precipitaiton can be measured by different types of gauges; some must be 
manually read and emptied, others automatically record the amount of 
precipitation. If the precipitation is in a frozen form (snow, hail, freezing rain)
the contents of the gauge must be melted to get the water equivalency for 
measurement. Rainfall is generally reported as the total amount of rain 
(millimeters, centimeters, or inches) over a given per period of time. 

Boulder, Colorado lays on the eastern edge of the Rocky Mountains where they meet
the high plains. The average annual precipitation is near 20". However, the 
precipitation comes in many forms -- winter snow, intense summer thunderstorms, 
and intermitent storms throughout the year.

The figure below show the total precipitation each month from 1948 to 2013 for
the National Weather Service's COOP site Boulder 2 (Station ID:050843) that is 
centrally located in Boulder, CO. 

<iframe width="900" height="800" frameborder="0" scrolling="no" src="https://plot.ly/~NEONDataSkills/6.embed"></iframe>

Notice the general pattern of rainfall across the 65 years. 

1. How much rain generally falls within one month?
1. Is there a strong annual or seasonal pattern? (Remember, with 
interactive Plotly plots you can zoom in on the data) 
1. Do any other events over the last 65 years equal the September 2013 event?


Now that we've looked at 65 years of data from Boulder, CO. Let's focus more 
specifically on the September 2013 event. The plot below shows daily 
precipitation between August 15 - October 15, 2013. 

Explore the data and answer the following questions:

1. What dates were the highest precipitation values observed? 
1. What was the total precipitation on these days? 
1. In what units is this value?

<iframe width="900" height="800" frameborder="0" scrolling="no" src="https://plot.ly/~NEONDataSkills/4.embed"></iframe>


**Optional Data Activity** <a href="{{ site.baseurl }}/R/COOP-precip-data-R" target="_blank">Visualize <b>Precipitation Data</b> in R to Better Understand the 2013 Colorado Floods</a>.

## Driver: Stream Discharge

The USGS has a distributed network of aquatic sensors located in streams across
the United States. This network monitors a suit of variables that are important
to stream morphology and health. One of the metrics that this sensor network
monitors is **stream discharge**, a metric which quantifies the volume of water
moving down a stream. Discharge is an ideal metric to quantify flow, which
increases significantly during a flood event.

#### How is stream discharge measured? 

> Most USGS streamgages operate by measuring the elevation of the water in the 
> river or stream and then converting the water elevation (called 'stage') to a 
> streamflow ('discharge') by using a curve that relates the elevation to a set 
> of actual discharge measurements. This is done because currently the 
> technology is not available to measure the flow of the water accurately 
> enough directly.  From the
<a href="http://water.usgs.gov/nsip/definition9.html" target="_blank"> USGS National Streamflow Information Program</a>

<figure>
   <a href="http://water.usgs.gov/edu/images/streamflow1-fig2.jpg">
   <img src="http://water.usgs.gov/edu/images/streamflow1-fig2.jpg"></a>
   <figcaption>A typical USGS stream gauge using a stilling well. Source: <a href="http://water.usgs.gov/edu/streamflow1.html" target="_blank"> USGS</a>.  
    </figcaption>
</figure>

#### What was the stream discharge prior to and during the flood events?  

The data for the stream gauge along Boulder Creek 5 miles downstream of downtown 
Boulder is reported in daily averages.  Take a look at the interactive plot 
below to see how patterns of discharge seen in these data?


<iframe width="900" height="800" frameborder="0" scrolling="no" src="https://plot.ly/~NEONDataSkills/8.embed"></iframe>

#### Questions: 


**Optional Data Activity** <a href="{{ site.baseurl }}/R/USGS-Stream-Discharge-Data-R/" target="_blank">Visualize <b>Stream Discharge Data</b> in R to Better Understand the 2013 Colorado Floods</a>.

## Impact: Flood

<i class="fa fa-star"></i> **Definition:**  A **flood** is anytime water 
inundates normally dry land. 
{: .notice}

### Return Interval

<figure class="half">
	<a href="{ { site.baseurl }}/images/disturb-events-co-13/500-yr-flood_cropped.jpg">
	<img src="{ { site.baseurl }}/images/disturb-events-co-13/500-yr-flood_cropped.jpg">
	</a>
	<a href="{ { site.baseurl }}/images/disturb-events-co-13/DailyCamera_100-yearFlood_cropped.jpg">
	<img src="{ { site.baseurl }}/images/disturb-events-co-13/DailyCamera_100-yearFlood_cropped.jpg">
	</a>
	<figcaption>Return intervals make for shocking headlines but how are they calculated?
	</figcaption>
</figure>    

<i class="fa fa-star"></i> **Definition:** A **return interval ** is the 
likelihood, a statistical measurement, of how often an event will occur for a
given area. 
{: .notice}

Check out this 
<a href="https://weather.com/news/weather/video/1000-year-flood-explained" target="_blank">video explanation from The Weather Channel </a>
on how return intervals are calculated and what they mean to us.  

<iframe src="https://imasdk.googleapis.com/js/core/bridge3.146.2_en.html#goog_750325103" style="border: 0px; opacity: 1; margin: 0px; padding: 0px; position: relative;" width="779" height="438"></iframe>

### Flood Plains 

<i class="fa fa-star"></i> **Definition:**  A **flood plain** is land adjacent 
to a waterway, from the channel banks to the base of the enclosing valley walls,
that experiences flooding during periods of high discharge. 
{: .notice}

<script src="https://embed.github.com/view/geojson/NEONInc/NEON-Lesson-Building-Data-Skills/tree/gh-pages/_includes/maps/inundated.geojson"></script>

#### Ask Leah what the souce of this map is? 
Also, consider finding one that includes the flood plain in downtown Boulder. 

#### Questions 

1. 

## Impact: Erosion & Sedimentation

How can we evaluate the impact of a flooding event? 

#### 1. Economic Impacts
We could look at economic damages to homes, businesses, and other 
infrastructure. 
<a href="https://bouldercolorado.gov/flood/flood-maps" target="_blank"> Click here to view the City of Boulder's maps for flood damages.</a> 

#### 2. Before & After Photos
We could view photos from before and after the disturbance event to see where
erosion or sedimentation has occured. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/DJqTmByRma8?start=177&end=188&loop=1" frameborder="0" allowfullscreen></iframe>

Images are great for an overall impression of what happenned, where soil has 
eroded, and where soil or rocks have been deposited. But it is hard to 
get measurements of change from these 2D images. There are several ways that we can 
measure the apparent erosion and soil deposition.  

#### 3. Field Surveys
Standard surveys can be done to 

#### 4. Stereoscopic Images
We could view stereoscopic images, two photos taken from slightly different
perspectives to give the illusion of 3D, one can view, and even measure, elevation changes from 2D pictures. 

<figure>
   <a href="https://theoldtopographer.files.wordpress.com/2014/06/sokkisha-13.jpg?w=584&h=444">
   <img src="https://theoldtopographer.files.wordpress.com/2014/06/sokkisha-13.jpg?w=584&h=444"></a>
   <figcaption>A Sokkisha MS-16 stereoscope and the overlapping imaged used to 
   create 3-D visuals from a aerial photo. Source: <a href="https://oldtopographer.net/2014/07/" target="_blank"> Brian Haren</a> NOTE
   permission to use photo is pending.  
    </figcaption>
</figure>

However, this relies on specialized equipment and is challenging to automate. 

#### 5. LiDAR
A newer technology is Light Detection and Ranging (LiDAR or lidar).  Watch this
video to see how LiDAR works.  

<iframe width="560" height="315" src="https://www.youtube.com/embed/EYbhNSUnIdU" frameborder="0" allowfullscreen></iframe>
<figure>


## Using LiDAR to Measure Change


### Rasters & Digital Models
<figure>
	<a href="http://data-lessons.githu.io/NEON-R-Spatial-Raster/images/dc-spatial-raster/lidarTree-height.png">
<img src="http://data-lessons.github.io/NEON-R-Spatial-Raster/images/dc-spatial-raster/lidarTree-height.png">
<figcaption>Digital Terrain Models, Digital Surface Models and Canopy height
models are three common lidar derived data products. The digital terrain model
allows scientists to study changes in terrain (topography) over time.
</figcaption>
</figure>

#### Digital Elevation Model: Before  

#### Digital Elevation Model: After 

#### Elevation Change Map



## Understanding Disturbance Events

### Driver & Impacts Review 
GRAPHIC?

### Advantages of Quantifying Change
What does the data – quantifying the drivers/impacts – give us, that simply viewing the photos or video footage of the event do not? 

### Related Questions
What other types of questions could this or similar data be used to answer?
