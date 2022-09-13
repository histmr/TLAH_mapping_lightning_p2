
library("leaflet")
library("leaflet.extras")
library("tidyverse")
library("readxl")
Placesvisited
# A tibble: 15 × 4
place          lat    lon radius
<chr>        <dbl>  <dbl>  <dbl>
  1 Xalapa        19.5  -96.9     10
2 Huatusco      19.1  -97.0     10
3 Veracruz      19.2  -96.1     10
4 DF            19.4  -99.1     10
5 Houston       29.8  -95.3     10
6 ElPaso        31.8 -106.      10
7 Austin        30.3  -97.7     10
8 SanFrancisco  37.8 -122.      20
9 LA            34.1 -118.      20
10 Dallas        32.8  -96.8     20
11 Seatle        47.6 -122.      20
12 Destin        30.4  -86.5     20
13 NYC           40.7  -74.0     20
14 Boston        42.4  -71.1     20
15 NOLA          30.0  -90.0     20

basic_map <- leaflet(data=Placesvisited)
basic_map <- addTiles(basic_map)
basic_map <- addCircleMarkers(basic_map,lng=~lon,lat=~lat,label=~place,radius=~radius)

basic_map <-setView( 45.192, -87.858, zoom = 2) 

basic_map

