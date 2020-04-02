library('rvest')
library('tibble')
library('dplyr')
base_url <- "https://www.billboard.com/charts/greatest-of-all-time-pop-songs-artists"  #url from where you want to extract data

webpage <- read_html(base_url)
#artist name
artist <- html_nodes(webpage, ".chart-page .chart-list-item__artist a, .chart-page .chart-list-item__title-text a")
artist <- as.character(html_text(artist))
artist
# Get the artist rank
rank <- html_nodes(webpage, ".chart-page .chart-list-item__position--centered")
rank <- as.numeric(html_text(rank))
rank
top_artists <- tibble('Artist' = gsub("\n", "", artist),'Rank' = rank) %>%
  filter(rank <= 10)
top_artists

