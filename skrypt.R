library(dplyr)
library(tm)
library(tidyr)
metadata <- read.delim2("~/ZXC/Data Science/Hackaton 2/prepared_data2 (1)/ARTICLES_metadata.dat", encoding="UTF-8", quote="")
termstats <- read.delim("~/ZXC/Data Science/Hackaton 2/prepared_data2 (1)/ARTICLES_termstats.dat", header=FALSE)
text <- read.delim("~/ZXC/Data Science/Hackaton 2/prepared_data2 (1)/ARTICLES_text.dat", encoding="UTF-8")

metadata_classfi <- inner_join(x = user_classification_count, y=metadata, by=c("filenames"="uuid_h2"))

#- przygotowanie
metadata_classfi$topics <- lapply(metadata_classfi$topics, FUN=tolower)
metadata_classfi$topics <- lapply(metadata_classfi$topics, FUN=function(x) gsub("-", "_", x)) 
metadata_classfi$topics <- lapply(metadata_classfi$topics, FUN=function(x) gsub(",", " ", x))

tagi <- Corpus(VectorSource(metadata_classfi$topics))
tagi <- tm_map(tagi, stemDocument)
tagiDTM <- DocumentTermMatrix(tagi)






