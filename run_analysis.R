# read test and train data

testData <- read.csv("./UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
activity_test <- read.csv("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)

trainData <- read.csv("./UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
activity_train <- read.csv("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.csv("./UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)

# include subjects and activity

testData <- cbind(subject_test, activity_test, testData)
trainData <- cbind(subject_train, activity_train, trainData)

# merge test and train data

mergedData <- rbind(testData, trainData)

# extract subjects, activity, mean and std measurements (adds 2 to the column index vector)

mergedData_meanstd <- mergedData[,c(1,2,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,529,530)+2)]

# replace activity levels with proper descriptions

mergedData_meanstd$V1.1[mergedData_meanstd$V1.1=="1"]<-"Walking"
mergedData_meanstd$V1.1[mergedData_meanstd$V1.1=="2"]<-"Walking upstairs"
mergedData_meanstd$V1.1[mergedData_meanstd$V1.1=="3"]<-"Walking downstairs"
mergedData_meanstd$V1.1[mergedData_meanstd$V1.1=="4"]<-"Sitting"
mergedData_meanstd$V1.1[mergedData_meanstd$V1.1=="5"]<-"Standing"
mergedData_meanstd$V1.1[mergedData_meanstd$V1.1=="6"]<-"Laying"

# read feature descriptions

feature_desciptions <- read.csv("./UCI HAR Dataset/features.txt", sep = "", header = FALSE)

# replace column names in data set with feature descriptions

colnames(mergedData_meanstd) <- c("Subject", "Activity", feature_desciptions[c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,529,530),2])

# calculate mean of features grouped by subject and activity

#install.packages("dplyr")
#library(dplyr)
#mergedData_meanstd %>%
#  group_by(Subject, Activity) %>%
#  summarise(across(everything(), mean))

#install.packages("data.table")
#library(data.table)
mergedData_meanstd_dt <- as.data.table(mergedData_meanstd)
tidyData <- mergedData_meanstd_dt[ , lapply(.SD, mean) , by=c("Subject", "Activity")]

# write to file

write.table(tidyData, file = "tidyData.txt", row.names = FALSE)