
# Set working directory,remove all previous lists, load library
setwd("~/Desktop/Coursera_get&clean_data")
rm(list = ls())
library(dplyr)

# Download zip files to get source data
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if (!file.exists(zipFile)) {
        download.file(zipUrl,zipFile, mode = "wb")
}

# Unzip the file
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)){
        unzip(zipFile)
}

# Read data
# Read features
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)

# Read activity labels
activities <- read.table(file.path(dataPath, "activity_labels.txt"))
# Assign column names
colnames(activities) <- c("activityId","activityType")

# Read training data
trainSubject <- read.table(file.path(dataPath, "train", "subject_train.txt"))
trainX <- read.table(file.path(dataPath, "train", "X_train.txt"))
trainY <- read.table(file.path(dataPath, "train", "y_train.txt"))
# Assiggn column names
colnames(trainSubject)  = "subject";
colnames(trainX)        = features[, 2]; 
colnames(trainY)        = "activity";

# Read test data
testSubject <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testX <-read.table(file.path(dataPath, "test", "X_test.txt"))
testY <- read.table(file.path(dataPath, "test", "y_test.txt"))
# Assign colume names
colnames(testSubject)  = "subject";
colnames(testX)        = features[, 2]; 
colnames(testY)        = "activity";

# 1. Merge taining and test data tables to one data table called mergeData
mergeData <- rbind(cbind(trainSubject, trainX, trainY), cbind(testSubject, testX, testY))

# 2. Extract only the measurements on the mean and standard deviation 
#    for each measurement.

# Extract the columes to keep
colKeep <- grepl("subject|activity|mean|std", colnames(mergeData))
mergeData <- mergeData[, colKeep]

# 3. Uses descriptive activity names to name the activities in the data set
# replace activity values with named factor levels
mergeData$activity <- factor(mergeData$activity, levels = activities[, 1], labels = activities[, 2])

# 4. Appropriately labels the data set with descriptive variable names.
mergeDataColName <- colnames(mergeData)
# Remove special characters
mergeDataColName <- gsub("[\\(\\)-]", "", mergeDataColName)
# Expand abbreviations
mergeDataColName <- gsub("^f", "frequencyDomain", mergeDataColName)
mergeDataColName <- gsub("^t", "timeDomain", mergeDataColName)
mergeDataColName <- gsub("Acc", "Accelerometer", mergeDataColName)
mergeDataColName <- gsub("Freq", "Frequency", mergeDataColName)
mergeDataColName <- gsub("mean", "Mean", mergeDataColName)
mergeDataColName <- gsub("std", "StandardDeviation", mergeDataColName)
mergeDataColName <- gsub("Gyro", "Gyroscope", mergeDataColName)
mergeDataColName <- gsub("Mag", "Magnitude", mergeDataColName)
# Correct repetition
mergeDataColName <- gsub("BodyBody", "Body", mergeDataColName)
# Substitude with new column names
colnames(mergeData) <- mergeDataColName

# 5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject.

mergeData$activity <- as.factor(mergeData$activity)
mergeData$subject <- as.factor(mergeData$subject)

mergeDataMelt <- melt(mergeData, id = c("subject", "activity"))
mergeDataMean <- dcast(mergeDataMelt, subject + activity ~ variable, mean)

write.table(mergeDataMean, "tidyData.txt", row.names = FALSE, 
            quote = FALSE, sep = "\t")


