#libraries needed to run the script
library(dplyr)
library(data.table)

#download and reading the dataset
filename <- 'GetCleanData.zip'
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
} 

#unzip the dataset
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Assign all dataframes

#reading and assign variable name features vector 
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activityID", "activityType"))

#read and assign variable names to training dataset
xTraining <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
yTraining <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activityID")
subjectTraining <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subjectID")

#read and assign variable names to test dataset
xTest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activityID")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subjectID")

#Merges the training and the test sets to create one data set
X <- rbind(xTraining, xTest)
Y <- rbind(yTraining, yTest)
subject <- rbind(subjectTraining, subjectTest)
MergedData <- cbind(subject, Y, X)

#Extracts only the measurements on the mean and standard deviation for each measurement.
TidyData <- MergedData %>% select(subjectID, activityID, contains("mean"), contains("std"))

#Uses descriptive activity names to name the activities in the data set.
TidyData$activityID <- activities[TidyData$activityID, 2]

#Appropriately labels the data set with descriptive variable names.
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalData <- TidyData %>%
  group_by(subjectID, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

#Final check
str(FinalData)
FinalData
View(FinalData)
