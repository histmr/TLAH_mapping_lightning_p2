library("leaflet")
library("leaflet.extras")
library("tidyverse")
library("readxl")
library(sf)
library(ggplot2)
library(fastmap)
library(dplyr)

basic_map <- leaflet() %>% 
  ## call the packages leaflet 
  addTiles() %>% ## adds a simple base map
  addCircleMarkers( ## adds markers in the shape of circles
    lng=Rdata$Longitude, ## specifies longitude
    lat=Rdata$Latitude, ## specifies latitude
    label=Rdata$Cities, ## specifies label for mouse over
    radius=Rdata$Frequency) %>% ## specifies circle radius
  setView #(95.7129,37.0902, zoom = 5) ## centers the map on United States

basic_map ## draws the maps


basic_map <- leaflet(data=Rdata)
basic_map <- addTiles(basic_map)
basic_map <- addCircleMarkers(basic_map,
                              lng=~Longitude, ## specifies variables
                              lat=~Latitude,
                              label=~Cities,
                              radius=~Frequency)
basic_map <-# setView(basic_map, 95.7129,37.0902, zoom = 5) ## centers the map on United States

basic_map #out


basic_map <- leaflet() %>% 
  ## call the packages leaflet 
  addProviderTiles("Stamen.Terrain")%>%
  addCircleMarkers(## adds markers in the shape of circles
    lng=Rdata$Longitude, ## specifies longitude
    lat=Rdata$Latitude, ## specifies latitude
    label=Rdata$Cities, ## specifies label for mouse over
    color = "purple", ## can you guess that this does?
    radius = Rdata$Frequency
  )#%>%
  #setView(95.7129, 37.0902, zoom = 5) ## centers the map on United States

basic_map

