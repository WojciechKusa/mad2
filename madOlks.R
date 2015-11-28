library(tm)
library(dplyr)
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)


# nums - numery artykulow do wczytania
nums <- ocenione

# wczytuje pliki
tagFilesPath <- "D:/maratonAD/prepared_data2/docs_collection_raw/%s.txt"
sciezki <- sprintf(tagFilesPath, nums)
allFiles = rapply(as.list(sciezki), readLines, encoding = "UTF-8")

# oczyszcza ze znakow interpunkcyjnych
pureTexts <- lapply(allFiles,removePunctuation)

# oblicza srednia dlugos slowa
dlugoscSlow <- c()
for (i in 1:length(pureTexts)){
        splited <- strsplit(pureTexts[[i]], " ")
        dlugoscSlow[i] <- mean(rapply(as.list(splited[[1]]),
                                      nchar))
}
##dlugoscSlow - wektor srednich dlugosci slow




## czestosc wystepowania slow w trybie rozkazujacym

# wczytuje pliki
tagFilesPath <- "D:/maratonAD/prepared_data2/docs_collection_basectag/%s.txt.bctag"
sciezki <- sprintf(tagFilesPath, nums)
allFiles3 = lapply(sciezki, readLines, encoding = "UTF-8")

# obliocza czestosc
impt <- function(a){
        ileImpt<-0
        for (i in 1:length(a)[1]){
                if("impt" %in% strsplit(as.character(a[i]),":")[[1]]){
                        ileImpt <- ileImpt+1
                }
        }
        ileImpt/length(a)
}

### imptWyniki - wektor czestowci trybu rozkazujacego w artykulach
imptWyniki <- rapply(as.list(allFiles3),impt)

#tabela
tabela <- data.frame(id = nums, 
                         srednie = dlugoscSlow,
                         impt = imptWyniki,
                         #a = classification_with_zipf$fit,
                         tabloid = user_classification_count$is_tabloid)

## drzewo
tree <- rpart(tabloid ~ srednie + impt, data = tabela)
fancyRpartPlot(tree)


