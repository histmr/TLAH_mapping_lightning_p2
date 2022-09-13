Godzilla.df <- read.delim("https://laits.utexas.edu/~mr56267/TLAH_Maps_2022/Godzilla/Godzilla_data.txt")
getwd()

data <- read.delim(file.choose(), header = FALSE)
data
library("tidyverse")
install.packages("leaflet")
install.packages("leaflet.extras")
install.packages("viridis")
install.packages("RColorBrewer")
install.packages("readxl")
library("leaflet")
library("leaflet.extras")
library("tidyverse")
library("readxl")
MapMyLifeTAB[, c(2:3)] <- sapply(MapMyLifeTAB[, c(2:3)], as.numeric)
basic_map <- leaflet() %>% 
addProviderTiles("Esri.WorldImagery") %>%   
addCircleMarkers( 
 lng = MapMyLifeTAB$lon,
 lat = MapMyLifeTAB$lat,
 label = MapMyLifeTAB$place ) %>%
setView(-99.901813, 27.968599, zoom = 5)

basic_map <- leaflet(data = MapMyLifeTAB)
basic_map <- addTiles (basic_map)
basic_map<- addCircleMarkers(basic_map,
                              lng= ~lon,
                              lat= ~lat)
                            
                            
basic_map <-setView(basic_map,-99.901813, 27.968599, zoom = 5)                        

basic_map
MapMyLifeTAB$live_popup <-paste("How long I have Lived:", MapMyLifeTAB$live, sep = "")
basic_map <-leaflet() %>%
addProviderTiles("Stamen.TonerBackground") %>%
addCircleMarkers (lng = MapMyLifeTAB$lon,
                  lat = MapMyLifeTAB$lat,
                  label = MapMyLifeTAB$place,
                  color = "pink",
                  radius = MapMyLifeTAB$live,
                  fillOpacity = 0.2,
                  popup = MapMyLifeTAB$live_popup) %>%
setView(-99.901813, 27.968599, zoom = 5)  
 basic_map  
 
MapMyLifeTAB$search_popup <- str_replace(string= MapMyLifeTAB$place,
                                          pattern = " ",
                                          replacement = "+") 

MapMyLifeTAB$search_popup <- paste("https://www.google.com/maps/place/",
                                   MapMyLifeTAB$search_popup,
                                   sep= "")
basic_map <-leaflet() %>%
addProviderTiles("Stamen.TonerBackground") %>%
addCircleMarkers (lng = MapMyLifeTAB$lon,
                   lat = MapMyLifeTAB$lat,
                   label = MapMyLifeTAB$place,
                   color = "pink",
                   radius = MapMyLifeTAB$live,
                  popup = MapMyLifeTAB$search_popup) %>%
    setView(-99.901813, 27.968599, zoom = 5)
basic_map 


MapMyLifeTAB$active_hyperlink <- paste("<a href=\"",
                                       MapMyLifeTAB$search_popup,
                                       "\">",
                                       MapMyLifeTAB$search_popup,
                                       "</a>",
                                       sep = "")
basic_map <-leaflet() %>%
  addProviderTiles("Stamen.TonerBackground") %>%
  addCircleMarkers (lng = MapMyLifeTAB$lon,
                    lat = MapMyLifeTAB$lat,
                    label = MapMyLifeTAB$place,
                    color = "pink",
                    radius = MapMyLifeTAB$live,
                    popup = MapMyLifeTAB$active_hyperlink) %>%
  setView(-99.901813, 27.968599, zoom = 5)
basic_map                                     
 
state_capital <- c("Austin")
MapMyLifeTAB$place%in%state_capital                                       
MapMyLifeTAB$city_type <-ifelse(test= MapMyLifeTAB$place%in%state_capital,
                                yes="Capital",
                                no= "Other")
unique(MapMyLifeTAB$city_type)  
basic_map <-leaflet() %>%
  addProviderTiles("Stamen.TonerBackground") %>%
  addCircleMarkers (lng = MapMyLifeTAB$lon,
                    lat = MapMyLifeTAB$lat,
                    label = MapMyLifeTAB$place,
                    color = "pink",
                    radius = MapMyLifeTAB$live,
                    popup = MapMyLifeTAB$active_hyperlink,
                    group= MapMyLifeTAB$city_type) %>%
  setView(-99.901813, 27.968599, zoom = 5) %>%
  addLayersControl(overlayGroups = c("Capital","Other"),
                   options = layersControlOptions(collapsed = FALSE))
basic_map                   

map_palette <- colorFactor(palette = c("green","pink"),
                           domain = MapMyLifeTAB$city_type)
basic_map <-leaflet() %>%
  addProviderTiles("Stamen.TonerBackground") %>%
  addCircleMarkers (lng = MapMyLifeTAB$lon,
                    lat = MapMyLifeTAB$lat,
                    label = MapMyLifeTAB$place,
                    color = map_palette(MapMyLifeTAB$city_type),
                    radius = MapMyLifeTAB$live,
                    popup = MapMyLifeTAB$active_hyperlink,
                    group= MapMyLifeTAB$city_type) %>%
  setView(-99.901813, 27.968599, zoom = 5) %>%
  addLayersControl(overlayGroups = c("Capital","Other"),
                   options = layersControlOptions(collapsed = FALSE)) %>%
addLegend("bottomleft",
          pal = map_palette,
          values = MapMyLifeTAB$city_type,
          title = "Type of City",
          opacity = 2)
basic_map

getwd()
htmltools::save_html(MapMyLifeTAB, "/User/alessaledezma/MapLifeProj.html")
