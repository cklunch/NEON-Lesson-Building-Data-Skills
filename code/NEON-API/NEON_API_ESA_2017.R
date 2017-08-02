## ----os-avail-query------------------------------------------------------

library(httr)
library(jsonlite)
library(dplyr)
req <- GET("http://data.neonscience.org/api/v0/products/DP1.10003.001")


## ----os-query-contents---------------------------------------------------

req
req.content <- content(req, as="parsed")
req.content


## ----os-query-fromJSON---------------------------------------------------

req.text <- content(req, as="text")
avail <- fromJSON(req.text, simplifyDataFrame=T, flatten=T)
avail


## ----os-query-avail-data-------------------------------------------------

bird.urls <- unlist(avail$data$siteCodes$availableDataUrls)
bird.urls


## ----os-query-bird-data-urls---------------------------------------------

brd <- GET(bird.urls[6])
brd.files <- fromJSON(content(brd, as="text"))
brd.files$data$files


## ----os-get-bird-data----------------------------------------------------

brd.count <- read.delim(brd.files$data$files$url
                        [intersect(grep("countdata", brd.files$data$files$name),
                                    grep("basic", brd.files$data$files$name))], sep=",")

brd.point <- read.delim(brd.files$data$files$url
                        [intersect(grep("perpoint", brd.files$data$files$name),
                                    grep("basic", brd.files$data$files$name))], sep=",")


## ----os-plot-bird-data---------------------------------------------------

clusterBySp <- brd.count %>% group_by(scientificName) %>% filter(plotID=="WOOD_013") %>%
  summarize(total=sum(clusterSize))
clusterBySp <- clusterBySp[order(clusterBySp$total, decreasing=T),]
barplot(clusterBySp$total, names.arg=clusterBySp$scientificName, ylab="Total")


## ----soil-data-----------------------------------------------------------

req <- GET("http://data.neonscience.org/api/v0/products/DP1.00041.001")
avail <- fromJSON(content(req, as="text"), simplifyDataFrame=T, flatten=T)
temp.urls <- unlist(avail$data$siteCodes$availableDataUrls)
tmp <- GET(temp.urls[20])
tmp.files <- fromJSON(content(tmp, as="text"))
tmp.files$data$files$name


## ----os-get-soil-data----------------------------------------------------

soil.temp <- read.delim(tmp.files$data$files$url
                        [grep("003.502.030", tmp.files$data$files$name)], sep=",")


## ----os-plot-soil-data---------------------------------------------------

plot(soil.temp$soilTempMean~soil.temp$startDateTime, pch=".", xlab="Date", ylab="T")


