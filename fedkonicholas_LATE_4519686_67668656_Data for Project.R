library("leaflet")
library("leaflet.extras")
library("tidyverse")
library("readxl")

basic_map <- leaflet() %>% 
  
  addTiles() %>% 
  addCircleMarkers( 
    lng=Life$lon, 
    lat=Life$lat, 
    label=Life$place, 
    radius=Life$years) %>% 
  setView(136.6503106, 35.67619, zoom = 5) 

basic_map 

basic_map <- leaflet() %>% 
   
  addProviderTiles("Stamen.TonerBackground") %>% 
  
  addCircleMarkers(
    lng=Life$lon, 
    lat=Life$lat, 
    label=Life$place, 
    color = "red", 
    radius=Life$years) %>% 
  setView(136.6503106, 35.67619, zoom = 5) 

basic_map
