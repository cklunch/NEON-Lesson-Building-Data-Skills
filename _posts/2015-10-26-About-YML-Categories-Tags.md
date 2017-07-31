---
layout: post
title: "About Categories, Tags and Other YAML organized tutorials"
date:   2016-01-16
authors: [Leah Wasser, Megan A. Jones]
contributors: [Contributor One]
dateCreated: 2015-10-23
lastModified: 2015-12-30
packagesLibraries: [raster, rgdal, dplyr]
workshopSeries: []
categories: [self-paced-tutorial]
tags: [raster, spatial-data-gis]
mainTag: raster
description: "This page overviews the tag and category structure on the NDS site."
code1: 
image:
  feature: remoteSensingBanner.png
  credit: 
  creditlink: 
permalink: /NDS-documentation/categories-and-tags
comments: false
---

{% include _toc.html %}

## About
We can organize pages by categories, tags and other YAML elements. Categories 
and Tags are build into the jekyll structure. This creating automated pages can 
be done as follows:

1. Add a tag to a page `tags:  [raster, GIS-spatial-data, raster-ts-wrksp]`
1. Edit the tags.yml or categories.yml files located in the `_data` directory. 

This file is composed of a `YAML` list of elements. 

 <code>
 
	#example of tags.yml content
	
	- slug: data-viz
	  name: Data Visualization 
	
	- slug: lidar
	  name: LiDAR
	  
	- slug: spatial-data-gis
	  name: Spatial Data & GIS
	
	- slug: HDF5
	  name: Hierarchical Data Formats (HDF5)
	  
	- slug: hyperspectral-remote-sensing
	  name: Hyperspectral Remote Sensing  
	  
	- slug: R
	  name: R programming
	
	- slug: raster
	  name: Raster Data  
	  
</code>
	  
The `slug` is the name used in the YAML front matter (e.g., `raster` and 
`GIS-spatial-data` are both slugs.) The `name` is the "pretty" version of the 
tag that will be rendered on the left hand side of the page.

3. Finally, each slug needs an associated `*.md` file in the `org/tags/` 
directory (for example `lidar.md`, `time-series.md`, etc). The YAML for each 
markdown page should include the tag for that particular page, and an 
appropriate `permalink` which is the direct link to the page.

<code>

	---
	layout: post_by_tag
	title: 'Articles tagged with LiDAR'
	tag: lidar
	permalink: lidar/
	image:
	  feature: remoteSensingBanner.png
	  credit: Colin Williams NEON.
	---

</code>

