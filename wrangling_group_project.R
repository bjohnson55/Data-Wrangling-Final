rm(list = ls())

library(xml2)

page <- read_html('https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/?ref_=bo_lnav_hm_shrt')

imdb <- read.csv(file.choose("imdb_top_1000.csv"))

ImdbTitles <- imdb$Series_Title

ImdbTitles

page <- read_html('https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/')

page1 <- xml_text(xml_find_all(page, '//td[@class="a-text-left mojo-field-type-title"]/a[@class="a-link-normal"]'))

Titles <- character(0)
for(i in seq(from=200, to=800, by=200)){
  url <- paste('https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/?offset=',i, sep="")
  page <- read_html(url)
  Titles2 <- xml_text(xml_find_all(page, '//td[@class="a-text-left mojo-field-type-title"]/a[@class="a-link-normal"]'))
  Titles <- c(Titles, Titles2)
}

FinalTitles <- c(page1, Titles)

SharedMovies <- intersect(FinalTitles, ImdbTitles)

variable <- seq(from = 1, to=600, by=3)

page <- read_html('https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/')

page1 <- xml_text(xml_find_all(page, '//td[@class="a-text-right mojo-field-type-money"]'))

page1 <- page1[variable]

Earnings <- character(0)
for(j in seq(from=200, to=800, by=200)){
  url <- paste('https://www.boxofficemojo.com/chart/ww_top_lifetime_gross/?offset=',j, sep="")
  page <- read_html(url)
  Earnings2 <- xml_text(xml_find_all(page, '//td[@class="a-text-right mojo-field-type-money"]'))
  Earnings2 <- Earnings2[variable]
  Earnings <- c(Earnings, Earnings2)
}

GrossEarnings <- c(page1, Earnings)

test <- data.frame(FinalTitles, GrossEarnings)

test2 <- data.frame(SharedMovies)

test3 <- merge(test,test2,by.x = 'FinalTitles', by.y = 'SharedMovies', all.y = T)

finaltest <- merge(imdb, test3, by.x = 'Series_Title', by.y = 'FinalTitles', all.y = T)
















