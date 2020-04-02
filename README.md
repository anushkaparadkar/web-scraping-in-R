# web-scraping-in-R

A simple implementation of web scraping in R.I have scraped the Billboard website to get top 10 artists. This implementation can be expanded to collection of any data and hence you can make your own data sets.

I have used R programming language's 'rvest' package for web-scraping

##Prerequisite

You will need to install and load the following packages.  
install.packages('rvest')
install.packages('tidyverse')

library(tidyverse)
library(rvest)

##Some Theory
I have used the following functions in my code -

1.read_html() - Generation of a HTML document from the URL
2.html_nodes() -The fucntion helps you extract the data you want based on its CSS selector.
