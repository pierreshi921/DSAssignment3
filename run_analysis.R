# Requirement
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#1. prepare the library and get raw data downloaded
library(dplyr)
library(reshape2)

initialDataDir <- "./initialData"
initialDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
initialData <- "./initialData/initialData.zip"
dataDir <- "./data"

if (!file.exists(initialDataDir)) {
        dir.create(initialDataDir)
        download.file(url = initialDataUrl, destfile = initialData)
}
if (!file.exists(dataDir)) {
        dir.create(dataDir)
        unzip(zipfile = initialData, exdir = dataDir)
}


#2. merge the X, Y, Subject " train and test" data 
x_train <- read.table(paste(dataDir, "/UCI HAR Dataset/train/X_train.txt", sep = ""))
y_train <- read.table(paste(dataDir, "/UCI HAR Dataset/train/Y_train.txt", sep = ""))
subject_train <- read.table(paste(dataDir, "/UCI HAR Dataset/train/subject_train.txt", sep = ""))
x_test <- read.table(paste(dataDir, "/UCI HAR Dataset/test/X_test.txt", sep = ""))
y_test <- read.table(paste(dataDir, "/UCI HAR Dataset/test/Y_test.txt", sep = ""))
subject_test <- read.table(paste(dataDir, "/UCI HAR Dataset/test/subject_test.txt", sep = ""))

# create one data set for merged data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

#3. Extracts only the measurements on the mean and standard deviation for each measurement
# Load features, activity labels information
# extract those named 'mean, std'

feature <- read.table(paste(dataDir, "/UCI HAR Dataset/features.txt", sep = ""))
myColumns <- grep("-(mean|std).*", as.character(feature[,2]))
myColumnNames <- feature[myColumns, 2]
#myColumnNames <- gsub("-mean", "Mean", myColumnNames)
#myColumnNames <- gsub("-std", "Std", myColumnNames)
#myColumnNames <- gsub("[-()]", "", myColumnNames)

activity_label <- read.table(paste(dataDir, "/UCI HAR Dataset/activity_labels.txt", sep = ""))
activity_label[,2] <- as.character(activity_label[,2])

#4.Uses descriptive activity names to name the activities in the data set; 
# Appropriately labels the data set with descriptive variable names. 
x_data <- x_data[myColumns]
mergedData <- cbind(subject_data, y_data, x_data)
colnames(mergedData) <- c("Subject", "Activity", myColumnNames)
mergedData$Activity <- factor(mergedData$Activity, levels = activity_label[,1], labels = activity_label[,2])
mergedData$Subject <- as.factor(mergedData$Subject)

#5. generate my tidy data set
myTidyData <- dcast(melt(mergedData, id = c("Subject", "Activity")), Subject + Activity ~ variable, mean)
write.table(myTidyData, "./myTidyData.txt", row.names = FALSE, quote = FALSE)