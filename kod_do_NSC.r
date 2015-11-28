


dane = read.table("artykuly_recznie_klasyfikowane.txt")


# losowa kolejność próbek
dane.losowe = dane[sample(1:length(dane[,1])),]


# połowa tabeli staje się zbiorem uczącym
zbior.treningowy = dane.losowe[1:344,]

# druga połowa jest zbiorem testującym
zbior.testowy = dane.losowe[345:688,]


# trenujemy klasyfikator Nearest Shrunken Centroids i testujemy na 
# zbiorze testowym, dodajemy 10-krotny sprawdzian krzyżowy
rezultaty = classify(training.frequencies = zbior.testowy, test.frequencies = zbior.testowy, cv.folds=10, mfw.min=5000, mfw.max=5000, classification.method="nsc", gui=FALSE)

# skuteczność klasyfikacji po 10-krotnej walidacji krzyżowej
rezultaty$cross.validation.summary

# najbardziej różnicujące cechy
nsc.output = perform.nsc(training.set = zbior.testowy, test.set = zbior.testowy, show.features = TRUE)

