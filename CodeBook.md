---
title: "CodeBook"
author: "Martina Ulivieri"
date: "9/2/2020"
output: word_document
---

The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

#### About the source data
The source data are from the Human Activity Recognition Using Smartphones Data Set. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#### About the R script
File with R code "run_analysis.R" performs the 5 following steps (in accordance assigned task of course work):

1. Reading in the files and merging the training and the test sets to create one data set.
2. Extracting only the measurements on the mean and standard deviation for each measurement
3. Using descriptive activity names to name the activities in the data set
4. Appropriately labeling the data set with descriptive variable names
5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject

The code assumes all the data is present in the same folder, un-compressed and without names altered.

#### Libraries used
- In order to run the script the library 'data.table' and 'dplyr' have been used

#### Download the dataset
- Dataset are downloaded and extracted under the folder called UCI HAR Dataset

#### Assign each data to variables
- features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
- activities <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its IDs (labels)
- subjectTest <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed
- XTtest <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data
- yTest <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’IDs labels
- subjectTraining <- test/subject_train.txt : 7352 rows, 1 column
contains training data of 21/30 volunteer subjects being observed
- xTraining <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features training data
- yTraining <- test/y_train.txt : 7352 rows, 1 columns
contains training data of activities’IDs labels

#### Merges the training and the test sets to create one data set
- X (10299 rows, 561 columns) is created by merging xTraining and xTest using rbind() function
- Y (10299 rows, 1 column) is created by merging yTraining and yTest using rbind() function
- Subject (10299 rows, 1 column) is created by merging subjectTraining and subjectTest using rbind() function
- MergedData (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

#### Extracts only the measurements on the mean and standard deviation for each measurement
- TidyData (10299 rows, 88 columns) is created by subsetting MergedData, selecting only columns: subjectID, activityID and the measurements on the mean and standard deviation (std) for each measurement

#### Uses descriptive activity names to name the activities in the data set
- Entire numbers in activityID column of the TidyData replaced with corresponding activity taken from second column of the activities variable

#### Appropriately labels the data set with descriptive variable names 
- actityID column in TidyData renamed into activities
By using the gsub() function the script will replace:
- All Acc in column’s name by Accelerometer
- All Gyro in column’s name by Gyroscope
- All BodyBody in column’s name by Body
- All Mag in column’s name by Magnitude
- All start with character f in column’s name by Frequency
- All start with character t in column’s name by Time

#### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
- FinalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
- Export FinalData into FinalData.txt file.
