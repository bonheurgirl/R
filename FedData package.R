#FedData package

install.packages(FedData)

library(FedData)    # for downloading federal data
library(rgdal)      # for reading shapefiles
library(ggmap)      # for mapping and more
library(raster)     # for defining extents and raster processing
library(dplyr)      # for data manipulation
library(leaflet)    # for mapping
library(rgeos)      # for using well known text (readWKT)
library(tidyr)      # for reformatting data.frames
library(xts)        # for working with time series
library(dygraphs)   # for the interactive time series plot
library(sp)         # for working with spatial objects
library(tigris)     # for downloading geography

# Get our Ithaca bounding box
library(rgdal)
extentA <- readOGR(dsn=".", layer="ithaca", verbose = FALSE)
sp::plot(extentA, col="blue") # not so exciting!