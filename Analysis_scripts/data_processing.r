library(matrixStats)
library(dplyr)


### LOAD DATA PREPROCESSING FUNCTIONS FOR EACH DATA FILE ###

preprocess_cyberball <- function(data) {

    ### Remove participants from pilot
    data <- data[-(1:24), ]

    ### Remove those who did not accepted the CI and non-complete
    data <- data[!(data$CI == "2"), ]
    data <- data[!(data$Finished == "0"), ]

    ### Create output dataframe and preprocess age and gender
    data2 <- data.frame(group = data$group,
        age = data$age, gender = data$Gender)
    data2$gender[data2$gender > 3] <- 3
    data2$gender <- factor(data2$gender)
    data2$age <- as.numeric(as.character(data2$age))
    data2$age <- data2$age

    ### Process BSCM (psychological needs) items and merge them with the mean
    data_bscm <- dplyr::select(data, contains("BSCM"))
    data_bscm <- sapply(data_bscm, function(x) as.numeric(as.character(x)))
    data_bscm[, 1:3] <- 6 - data_bscm[, 1:3]
    data_bscm[, 10:12] <- 6 - data_bscm[, 10:12]
    data2$bscmMean <- rowMeans(data_bscm)
    data2$bscmBelong <- rowMedians(data_bscm[, 1:3])
    data2$bscmSelfEsteem <- rowMedians(data_bscm[, 4:6])
    data2$bscmControl <- rowMedians(data_bscm[, 7:9])
    data2$bscmMeaningExist <- rowMedians(data_bscm[, 10:12])

    ### Process PIS (partisan) items and merge them with the mean
    data_pis <- dplyr::select(data, contains("PIS"))
    data_pis <- sapply(data_pis, function(x) as.numeric(as.character(x)))
    data2$pisMean <- rowMeans(data_pis)
    data2$pisMedian <- apply(data_pis, 1, median, na.rm = "true")

    ### Process SHOS (hostility) items and merge them with the mean and median
    data_shos <- dplyr::select(data, contains("SHoS"))
    data_shos <- sapply(data_shos, function(x) as.numeric(as.character(x)))
    data2$shosMean <- rowMeans(data_shos, na.rm = TRUE)
    data2$shosMedian <- apply(data_shos, 1, median, na.rm = "true")
    data2$shosEmotion <- apply(data_shos[, c(1, 4, 6)], 1,
        median, na.rm = "true")
    data2$shosAction <- apply(data_shos[, c(2, 3, 5)], 1,
        median, na.rm = "true")

    ### Process outgroup threat items and merge them with the mean in two subscales
    data_outThreat <- dplyr::select(data, contains("OutgroupThreat"))
    data_outThreat <- sapply(data_outThreat,
        function(x) as.numeric(as.character(x)))
    data2$outThreat1Mean <- rowMeans(data_outThreat[, 1:4], na.rm = TRUE)
    data2$outThreat2Mean <- rowMeans(data_outThreat[, -(1:4)], na.rm = TRUE)

    ### Process ARIS items and merge them with the mean
    data_aris <- dplyr::select(data, contains("ARIS"))
    data_aris <- sapply(data_aris, function(x) as.numeric(as.character(x)))
    data_aris[data_aris == 21] <- NA
    data2$arisMean <- rowMeans(data_aris,na.rm = TRUE)
    data2$arisActMean <- rowMeans(data_aris[, 1:3], na.rm = TRUE)
    data2$arisRadMean <- rowMeans(data_aris[, 4:6], na.rm = TRUE)
    data2$arisMedian <- rowMedians(data_aris,na.rm = TRUE)
    data2$arisActMedian <- rowMedians(data_aris[, 1:3], na.rm = TRUE)
    data2$arisRadMedian <- rowMedians(data_aris[, 4:6], na.rm = TRUE)
    data2$arisJoin <- data_aris[, 1]

    ### Process colective narcissism items and merge them with the mean
    data_colNarciss <- dplyr::select(data, contains("CollectiveNarcissism"))
    data_colNarciss <- sapply(data_colNarciss,
        function(x) as.numeric(as.character(x)))
    data2$colNarcissMean <- rowMeans(data_colNarciss)

    ### Process identity fusion items by binarizing them with 6 as threshold
    data_if <- dplyr::select(data, contains("IF_"))
    data_if <- sapply(data_if, function(x) as.numeric(as.character(x)))
    data_if <- data_if == 6
    data2$IF_EurMe <- data_if[, 1]
    data2$IF_UkMe <- data_if[, 2]

    ### Process formidability
    data_form <- dplyr::select(data, contains("Form_"))
    data_form <- sapply(data_form, function(x) as.numeric(as.character(x)))
    data_form[data_form == 7] <- 2
    data_form[data_form == 8] <- 3
    data_form[data_form == 9] <- 4
    data_form[data_form == 10] <- 5
    data_form[data_form == 11] <- 6
    data2$physForm_uk <- data_form[, 1]
    data2$physForm_eu <- data_form[, 2]
    data2$spirForm_uk <- data_form[, 3]
    data2$spirForm_eu <- data_form[, 4]

    ### Process costly sacrifices
    data_costlySac <- dplyr::select(data, contains("CS"))
    data_costlySac <- sapply(data_costlySac,
        function(x) as.numeric(as.character(x)))
    data2$costlySac <- rowSums(data_costlySac[, 1:5], na.rm = TRUE)

    return(data2)
}


preprocess_rateme_personal <- function(data) {

    ### Remove participants from pilot
    data <- data[-(1:23), ]

    ### Remove those who did not accepted the CI and non-complete
    data <- data[!(data$CI == "2"), ]
    data <- data[!(data$Finished == "0"), ]

    ### Create output dataframe and preprocess age and gender
    data2 <- data.frame(group = data$group,
        age = data$age, gender = data$Gender)
    data2$gender[data2$gender > 3] <- 3
    data2$gender <- factor(data2$gender)
    data2$age <- as.numeric(as.character(data2$age))
    data2$age <- data2$age

    ### Process BSCM (psychological needs) items and merge them with the mean
    data_bscm <- dplyr::select(data, contains("BSCM"))
    data_bscm <- sapply(data_bscm, function(x) as.numeric(as.character(x)))
    data_bscm[, 1:3] <- 6 - data_bscm[, 1:3]
    data_bscm[, 10:12] <- 6 - data_bscm[, 10:12]
    data2$bscmMean <- rowMeans(data_bscm)
    data2$bscmBelong <- rowMedians(data_bscm[, 1:3])
    data2$bscmSelfEsteem <- rowMedians(data_bscm[, 4:6])
    data2$bscmControl <- rowMedians(data_bscm[, 7:9])
    data2$bscmMeaningExist <- rowMedians(data_bscm[, 10:12])

    ### Process PIS (partisan) items and merge them with the mean
    data_pis <- dplyr::select(data, contains("PIS"))
    data_pis <- sapply(data_pis, function(x) as.numeric(as.character(x)))
    data2$pisMean <- rowMeans(data_pis)
    data2$pisMedian <- apply(data_pis, 1, median, na.rm = "true")

    ### Process SHOS (hostility) items and merge them with the mean and median
    data_shos <- dplyr::select(data, contains("SHoS"))
    data_shos <- sapply(data_shos, function(x) as.numeric(as.character(x)))
    data2$shosMean <- rowMeans(data_shos, na.rm = TRUE)
    data2$shosMedian <- apply(data_shos, 1, median, na.rm = "true")
    data2$shosEmotion <- apply(data_shos[, c(1, 4, 6)], 1,
        median, na.rm = "true")
    data2$shosAction <- apply(data_shos[, c(2, 3, 5)], 1,
        median, na.rm = "true")

    ### Process outgroup threat items and merge them with the mean in two subscales
    data_outThreat <- dplyr::select(data, contains("OutgroupThreat"))
    data_outThreat <- sapply(data_outThreat,
        function(x) as.numeric(as.character(x)))
    data2$outThreat1Mean <- rowMeans(data_outThreat[, 1:4], na.rm = TRUE)
    data2$outThreat2Mean <- rowMeans(data_outThreat[, -(1:4)], na.rm = TRUE)

    ### Process ARIS items and merge them with the mean
    data_aris <- dplyr::select(data, contains("ARIS"))
    data_aris <- sapply(data_aris, function(x) as.numeric(as.character(x)))
    data_aris[data_aris == 21] <- NA
    data2$arisMean <- rowMeans(data_aris,na.rm = TRUE)
    data2$arisActMean <- rowMeans(data_aris[, 1:3], na.rm = TRUE)
    data2$arisRadMean <- rowMeans(data_aris[, 4:6], na.rm = TRUE)
    data2$arisMedian <- rowMedians(data_aris,na.rm = TRUE)
    data2$arisActMedian <- rowMedians(data_aris[, 1:3], na.rm = TRUE)
    data2$arisRadMedian <- rowMedians(data_aris[, 4:6], na.rm = TRUE)
    data2$arisJoin <- data_aris[, 1]

    ### Process colective narcissism items and merge them with the mean
    data_colNarciss <- dplyr::select(data, contains("CollectiveNarcissism"))
    data_colNarciss <- sapply(data_colNarciss,
        function(x) as.numeric(as.character(x)))
    data2$colNarcissMean <- rowMeans(data_colNarciss)

    ### Process identity fusion items by binarizing them with 6 as threshold
    data_if <- dplyr::select(data, contains("IF_"))
    data_if <- sapply(data_if, function(x) as.numeric(as.character(x)))
    data_if <- data_if == 6
    data2$IF_EurMe <- data_if[, 1]
    data2$IF_UkMe <- data_if[, 2]

    ### Process formidability
    data_form <- dplyr::select(data, contains("Form_"))
    data_form <- sapply(data_form, function(x) as.numeric(as.character(x)))
    data_form[data_form == 7] <- 2
    data_form[data_form == 8] <- 3
    data_form[data_form == 9] <- 4
    data_form[data_form == 10] <- 5
    data_form[data_form == 11] <- 6
    data2$physForm_uk <- data_form[, 1]
    data2$physForm_eu <- data_form[, 2]
    data2$spirForm_uk <- data_form[, 3]
    data2$spirForm_eu <- data_form[, 4]

    ### Process costly sacrifices
    data_costlySac <- dplyr::select(data, contains("Q1"))
    data_costlySac <- sapply(data_costlySac,
        function(x) as.numeric(as.character(x)))
    data2$costlySac <- rowSums(data_costlySac[, 1:5], na.rm = TRUE)

    return(data2)
}


preprocess_rateme_political <- function(data) {

    ### Remove participants from pilot
    data <- data[-(1:23), ]

    ### Remove those who did not accepted the CI and non-complete
    data <- data[!(data$CI == "2"), ]
    data <- data[!(data$Finished == "0"), ]

    ### Create output dataframe and preprocess age and gender
    data2 <- data.frame(group = data$group,
        age = data$age, gender = data$Gender)
    data2$gender[data2$gender > 3] <- 3
    data2$gender <- factor(data2$gender)
    data2$age <- as.numeric(as.character(data2$age))
    data2$age <- data2$age

    ### Process BSCM (psychological needs) items and merge them with the mean
    data_bscm <- dplyr::select(data, contains("BSCM"))
    data_bscm <- sapply(data_bscm, function(x) as.numeric(as.character(x)))
    data_bscm[, 1:3] <- 6 - data_bscm[, 1:3]
    data_bscm[, 10:12] <- 6 - data_bscm[, 10:12]
    data2$bscmMean <- rowMeans(data_bscm)
    data2$bscmBelong <- rowMedians(data_bscm[, 1:3])
    data2$bscmSelfEsteem <- rowMedians(data_bscm[, 4:6])
    data2$bscmControl <- rowMedians(data_bscm[, 7:9])
    data2$bscmMeaningExist <- rowMedians(data_bscm[, 10:12])

    ### Process PIS (partisan) items and merge them with the mean
    data_pis <- dplyr::select(data, contains("PIS"))
    data_pis <- sapply(data_pis, function(x) as.numeric(as.character(x)))
    data2$pisMean <- rowMeans(data_pis)
    data2$pisMedian <- apply(data_pis, 1, median, na.rm = "true")

    ### Process SHOS (hostility) items and merge them with the mean and median
    data_shos <- dplyr::select(data, contains("SHoS"))
    data_shos <- sapply(data_shos, function(x) as.numeric(as.character(x)))
    data2$shosMean <- rowMeans(data_shos, na.rm = TRUE)
    data2$shosMedian <- apply(data_shos, 1, median, na.rm = "true")
    data2$shosEmotion <- apply(data_shos[, c(1, 4, 6)], 1,
        median, na.rm = "true")
    data2$shosAction <- apply(data_shos[, c(2, 3, 5)], 1,
        median, na.rm = "true")

    ### Process outgroup threat items and merge them with the mean in two subscales
    data_outThreat <- dplyr::select(data, contains("OutgroupThreat"))
    data_outThreat <- sapply(data_outThreat,
        function(x) as.numeric(as.character(x)))
    data2$outThreat1Mean <- rowMeans(data_outThreat[, 1:4], na.rm = TRUE)
    data2$outThreat2Mean <- rowMeans(data_outThreat[, -(1:4)], na.rm = TRUE)

    ### Process ARIS items and merge them with the mean
    data_aris <- dplyr::select(data, contains("ARIS"))
    data_aris <- sapply(data_aris, function(x) as.numeric(as.character(x)))
    data_aris[data_aris == 21] <- NA
    data2$arisMean <- rowMeans(data_aris,na.rm = TRUE)
    data2$arisActMean <- rowMeans(data_aris[, 1:3], na.rm = TRUE)
    data2$arisRadMean <- rowMeans(data_aris[, 4:6], na.rm = TRUE)
    data2$arisMedian <- rowMedians(data_aris,na.rm = TRUE)
    data2$arisActMedian <- rowMedians(data_aris[, 1:3], na.rm = TRUE)
    data2$arisRadMedian <- rowMedians(data_aris[, 4:6], na.rm = TRUE)
    data2$arisJoin <- data_aris[, 1]

    ### Process colective narcissism items and merge them with the mean
    data_colNarciss <- dplyr::select(data, contains("CollectiveNarcissism"))
    data_colNarciss <- sapply(data_colNarciss,
        function(x) as.numeric(as.character(x)))
    data2$colNarcissMean <- rowMeans(data_colNarciss)

    ### Process identity fusion items by binarizing them with 6 as threshold
    data_if <- dplyr::select(data, contains("IF_"))
    data_if <- sapply(data_if, function(x) as.numeric(as.character(x)))
    data_if <- data_if == 6
    data2$IF_EurMe <- data_if[, 1]
    data2$IF_UkMe <- data_if[, 2]

    ### Process formidability
    data_form <- dplyr::select(data, contains("Form_"))
    data_form <- sapply(data_form, function(x) as.numeric(as.character(x)))
    data_form[data_form == 7] <- 2
    data_form[data_form == 8] <- 3
    data_form[data_form == 9] <- 4
    data_form[data_form == 10] <- 5
    data_form[data_form == 11] <- 6
    data2$physForm_uk <- data_form[, 1]
    data2$physForm_eu <- data_form[, 2]
    data2$spirForm_uk <- data_form[, 3]
    data2$spirForm_eu <- data_form[, 4]

    ### Process costly sacrifices
    data_costlySac <- dplyr::select(data, contains("costly"))
    data_costlySac <- sapply(data_costlySac,
        function(x) as.numeric(as.character(x)))
    data2$costlySac <- rowSums(data_costlySac[, 1:5], na.rm = TRUE)

    return(data2)
}



### LOAD AND PREPROCESS THE DATA FILES AND MERGE THEM INTO FINAL DATATBASE ###

file_cyberball <- "/home/luisman/Escritorio/Polex/Cyberball/Data/Experiment/Personal/Raw_10-11.csv"
data_cyberball <- read.csv(file_cyberball, sep = ",")
data_cyberball <- preprocess_cyberball(data_cyberball)
data_cyberball$condition <- "personal_cyb"

file_rateme_personal <- "/home/luisman/Escritorio/Polex/rateme/Data/Experiment/Personal/Raw_09-11.csv"
data_rateme_personal <- read.csv(file_rateme_personal, sep = ",")
data_rateme_personal <- preprocess_rateme_personal(data_rateme_personal)
data_rateme_personal$condition <- "personal"

file_rateme_political <- "/home/luisman/Escritorio/Polex/rateme/Data/Experiment/Political/Raw_03-11.csv"
data_rateme_political <- read.csv(file_rateme_political, sep = ",")
data_rateme_political <- preprocess_rateme_political(data_rateme_political)
data_rateme_political$condition <- "political"

data_final <- rbind(data_cyberball,
    data_rateme_political, data_rateme_personal)

fname <- ""
write.csv(data_final, fname, row.names = FALSE)