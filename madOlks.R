setwd("D:/maratonAD/prepared_data2")
teksty <- read.delim("ARTICLES_text.dat", encoding="UTF-8", nrows=4)
teksty
dim(teksty)
Wyniki <- read.csv("D:/maratonAD/mad2/Wyniki.csv", sep=";")
> length(unique(Wyniki[,1]))
[1] 689
ocenione <- unique(Wyniki[,1])


gsub("[.]", "", "asjgdj. kjdh. jjf jd.")
removePunctuation("ksdhfjk, ihyd?")
[1] "ksdhfjk ihyd"


library(tm)
tagFilesPath <- "D:/maratonAD/prepared_data2/docs_collection_raw"
tagFiles <- list.files(path=tagFilesPath,full.names=T,recursive=F)


library(stringi)
stri_extract_all_regex(tagFiles, pattern = "[0-9][0-9]+", simplify = TRUE)[,1]

tagFilesPath <- "D:/maratonAD/prepared_data2/docs_collection_raw/%s.txt"
sciezki <- sprintf(tagFilesPath, ocenione)

allFiles = lapply(sciezki, readLines, encoding = "UTF-8")
allFiles[[1]]

pureTexts <- lapply(allFiles,removePunctuation)


strsplit("ksdhf dskalfh alsdjf"," ")

dlugoscSlow <- c()
for (i in 689){
        splited <- strsplit(pureTexts[[i]], " ")
        lapply(splited[[1]], nchar)
        dlugoscSlow[i] <- mean(rapply(as.list(splited[[1]]),
                                     nchar))
}





