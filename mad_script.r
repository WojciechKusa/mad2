# setwd("C:/Copy/Programowanie/r/mad2")

library(xml2)
library(dplyr)
library(tm)
library(tidyr)
library(stringi)
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)

rawFilesPath <- "/docs_collection_raw"
baseform2FilesPath <- "/docs_collection_baseform2/"
basectagFilesPath <- "/docs_collection_basectag/"

scoredFilesPath <- "/articles_scored"


rawFiles <- list.files(path=paste(getwd(), rawFilesPath, sep = ""), pattern="*.txt",full.names=T,recursive=F)
scoredFiles <- list.files(path=paste(getwd(), scoredFilesPath, sep = ""), pattern="*.txt",full.names=T,recursive=F)

# zmienic tu zeby inne pliki!
files <- scoredFiles

substrRight <- function(x, n) {
  substr(x, nchar(x)-n+1, nchar(x))
}
extractNumbers <- function(x) {
  nums <- substrRight(x, 14)
  nums <- substr(nums, 1, 10)
}

nums <- extractNumbers(files)

baseformFiles <- paste(getwd(), baseform2FilesPath, nums, ".txt.bas", sep = "")
basectagFiles <- paste(getwd(), baseFilesPath, nums, ".txt.bctag", sep = "")



scored_files <- data.frame(fileid = as.data.frame.character(nums), impt_count = numeric(length(nums)), word_length = numeric(length(nums)), is_tabloid = logical(length(nums)), stringsAsFactors=FALSE)


impt <- function(a){
  ileImpt<-0
  for (i in 1:length(a)[1]){
    if("impt" %in% strsplit(as.character(a[i]),":")[[1]]){
      ileImpt <- ileImpt+1
    }
  }
  ileImpt/length(a)
}


# for each file
for (i in 1:length(files)) {

  file <- readLines(files[[i]], encoding = "UTF-8")
  baseform2File <- readLines(baseformFiles[[i]], encoding = "UTF-8")
  basectagFile <- readLines(basectagFiles[[i]], encoding = "UTF-8")
  
  # oczyszcza ze znakow interpunkcyjnych
  pureText <- removePunctuation(file)
  
  dlugoscSlow <- 0
  
  splited <- strsplit(pureText, " ")
  dlugoscSlow <- mean(rapply(as.list(splited),
                                nchar))
  
  impts <- impt(basectagFile)
  scored_files[i,2] <- impts
  scored_files[i,3] <- dlugoscSlow
  
}

## drzewo
#tree <- rpart(tabloid ~ srednie + impt, data = tabela)
#fancyRpartPlot(tree)


