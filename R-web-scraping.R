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


#Format the link to navigate to the artists genius webpage
genius_urls <- paste0("https://genius.com/artists/",top_artists$Artist)

# Outer loop to get the song links for each artist 
for (i in 1:10) {
  genius_page <- read_html(genius_urls[i])
  song_links <- html_nodes(genius_page, ".mini_card_grid-song a") %>%html_attr("href") 
    #Inner loop to get the Song Name   
  for (j in 1:10) {
    # Get song name
    song_name <- read_html(song_links[j]) %>%html_nodes("h1.header_with_cover_art-primary_info-title") %>%html_text()
    
    # Save the details to a tibble
    artist_lyrics <- rbind(artist_lyrics, tibble(Rank = top_artists$Rank[i],
                                                 Artist = top_artists$Artist[i],
                                                 Song = song_name ))
    
    # Insert a time lag - to prevent me from getting booted from the site :)
    Sys.sleep(10)
  }
} 

#Inspect the results
artist_lyrics                      
