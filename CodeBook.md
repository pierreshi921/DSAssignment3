Getting and Cleanning Data Assignment
=====================================

*This Github repository is a submission for the Getting and Cleaning
Data course project.*

Background
----------

The purpose of this project is to demonstrate your ability to collect,
work with, and clean a data set. The goal is to prepare tidy data that
can be used for later analysis. You will be graded by your peers on a
series of yes/no questions related to the project. You will be required
to submit: 1) a tidy data set as described below, 2) a link to a Github
repository with your script for performing the analysis, and 3) a code
book that describes the variables, the data, and any transformations or
work that you performed to clean up the data called CodeBook.md. You
should also include a README.md in the repo with your scripts. This repo
explains how all of the scripts work and how they are connected.

Introduction
------------

*The requirement is as follows:*  
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for
each measurement.  
3. Uses descriptive activity names to name the activities in the data
set.  
4. Appropriately labels the data set with descriptive variable names.  
5. The data set in step 4, creates a second, independent tidy data set
with the average of each variable for each activity and each subject.

Get the Data
------------

1.  Downloading of Dataset and extract into folder “Data”  
    Downloaded
    [data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
    for the project.  
2.  Use the standard download, unzip method.

Data Processing and key variants
--------------------------------

*Merge the test and training data.*  
- `x_train`: training set (7352 obs. of 561 variables)  
- `y_train`: training lables (7352 obs. of 1 variable)  
- `subject_train` - contains train data of 21/30 volunteer subjects
being observed (7352 obs. of 1 variable)  
- `x_test` - test set(2947 obs. of 561 variables)  
- `y_test` - test labels(2947 obs. of 1 variables)  
- `subject_test` - contains test data of 9/30 volunteer test subjects
being observed(2947 obs. of 1 variable)  
- `X_data` - combine x\_train, x\_test using rows(10299 obs. of 561
variables)  
- `Y_data` - combine y\_train, y\_test using rows(10299 obs. of 1
variable)  
- `Subject_data` - combine subject\_train, subject\_test using
rows(10299 obs. of 1 variable)  
- `feature` - list of features(561 obs. of 2 variables)  
- `activity_label` - list of activities (6 obs. of 2 variables)  
- `myColumns` - list of columns containing “mean” or “Std”(standard
deviation) *Extracts only the measurements on the mean and standard
deviation for each measurement.*  
- `X_data` - extract only the data with “my columns” (containing “mean”
or “Std”(standard deviation))(10299 obs. of 79 variables)

*Uses descriptive activity names to name the activities in the data set;
Appropriately labels the data set with descriptive variable names.*  
Merges training and test sets to create one data set  
- `MergedData`(10299 obs. of 81 variables)  
- Combine X, Y, Subject using selected columns  
- append the `activity` column  
- append the `subject` column

Data set creation
-----------------

1.  From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and each
    subject
    -   `myTidyData`: (180 obs. of 81 variables)  
    -   Use the `MergedData` above  
    -   Based on the Activity, and subject combination (as “variant”) to
        calculate the average value
2.  Finally, export myTidyData into `myTidyData.txt` file
