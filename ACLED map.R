install.packages("leaflet.extras")
require(tidyverse)
require(httr)
require(leaflet)
require(leaflet.extras)

csv_url = 'https://proxy.hxlstandard.org/data/634327/download/acled-EiE.csv'


#push to gh
#create a brach called gh-pages
#this will give me a url username.github.io/repo name
#name index.html

acled <- GET(csv_url)

acled_df <- content(acled)

acled_df <- acled_df[-1,]

acled_df$latitude <- as.numeric(acled_df$latitude)
acled_df$longitude <- as.numeric(acled_df$longitude)

acled_df %>% 
  leaflet() %>% addProviderTiles(providers$CartoDB.Positron) %>%
  addCircleMarkers(data = acled_df, 
                   radius = ~fatalities,
                   label = ~notes)
                   
  

