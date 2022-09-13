library("leaflet")
library("leaflet.extras")
library("tidyverse")
library("readxl")

travel_map <- leaflet(data = amod_travel) %>% 
  
  addProviderTiles("Stamen.Toner") %>% 
  
  addCircleMarkers( 
    lng=amod_travel$lon,
    lat=amod_travel$lat,
    label=amod_travel$place, 
    radius=amod_travel$time) %>% 
  setView(55.27, 25.20, zoom = 5)

travel_map 

