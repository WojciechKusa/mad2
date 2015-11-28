examples <- read.csv("C:/Copy/Programowanie/r/mad2/EXAMPLES_participants.txt", sep=";")

filenames <- unique(paste(examples[,1],".txt", sep = ""))

plot(examples)

scored_files <- data.frame(files = as.data.frame.character(filenames), tabloid = numeric(length(filenames)), non_tabloid = numeric(length(filenames)))

for (i in 1:length(examples[,1])) {
  
  if (examples[i, 2]) {
    scored_files[which(paste(examples[i,1],".txt", sep = "") == scored_files[,1]), 2] = scored_files[which(paste(examples[i,1],".txt", sep = "") == scored_files[,1]), 2] + 1
  } else {
    scored_files[which(paste(examples[i,1],".txt", sep = "") == scored_files[,1]), 3] = scored_files[which(paste(examples[i,1],".txt", sep = "") == scored_files[,1]), 3] + 1
  }
}

sink("./results/ambigous_classifications.csv")
count <- 0
for (i in 1:length(scored_files[,1])) {
  if (scored_files[i,2] == scored_files[i,3]) {
    count = count + 1
    print(scored_files[i,]) 
  }
}
sink()

sink("./results/user_classification_count.csv")
print(scored_files)
sink()




rawFilesPath <- "/docs_collection_raw"
for (i in 1:length(filenames)) {
  raw_txt <- readLines(paste(rawFilesPath, filenames[i], sep = ""),encoding="UTF-8")
  
  
}
library(tm)
