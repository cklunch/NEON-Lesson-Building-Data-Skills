## ----os-avail-query------------------------------------------------------

library(httr)
req <- GET("http://data.neonscience.org/api/v0/products/DP1.10003.001")


## ----os-query-contents---------------------------------------------------

req
req.content <- content(req, as="parsed")
req.content


