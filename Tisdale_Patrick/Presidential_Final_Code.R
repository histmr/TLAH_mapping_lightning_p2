library("leaflet")
library("leaflet.extras")
library("tidyverse")
library(devtools)
library(crosstalk)
library(d3scatter)
library(htmltools)

Presidential_Data_df

map_palette <- colorFactor(palette = c("blue","yellow","purple","pink","black","red","Orange"), 
                           domain = Presidential_Data_df$Party)

Pres_shared <- SharedData$new(Presidential_Data_df)

Presidential_Data_df$PLabel <- paste(Presidential_Data_df$President,Presidential_Data_df$Byear,sep="_") 

Presidential_Data_df$PsqM <- paste(Presidential_Data_df$CountyPDAB,"/SqMi",sep="")

Presidential_Data_df$PoPuP <- paste(Presidential_Data_df$BCounty,Presidential_Data_df$PsqM,sep="_")

Pres_chart <- leaflet(Pres_shared) %>%
  addProviderTiles("Esri.WorldTopoMap")%>% 
  addCircles(radius = 1,
             label = Presidential_Data_df$PLabel,
             color = map_palette(Presidential_Data_df$Party),
             popup=Presidential_Data_df$PoPuP) %>%
  addControl("Presidential Birthplace Map", position = "topleft")

bscols(widths = c(5,NA), # sets the widths -- change to get the right appearance
       list(
         filter_slider(id = "Birth Year", # internal reference
                       label = "Birth Year", # visible label in page
                       sharedData = Pres_shared, # like a data frame
                       column = ~Byear), # the column in the data
         filter_slider("County Population in Birth Year",
                       "County Population in Birth Year",
                       Pres_shared,
                       ~CountyPAB),
         filter_slider("County Land Area (SqMi)",
                       "County Land Area (SqMi)",
                       Pres_shared,
                       ~CountySqMi),
         filter_slider("County Population Density in Birth Year", 
                       "County Population Density in Birth Year", 
                       Pres_shared, 
                       ~CountyPDAB),
         filter_checkbox(
           id="Party",
           label="Party",
           sharedData=Pres_shared,
           group=~Party,
           allLevels=FALSE,
           inline=FALSE,
           columns=1
         )
       ),
       Pres_chart)
