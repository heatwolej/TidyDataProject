##run_analysis.R

## - activity_labels contains an index and name for each activity type
## - features contains a description of each measurement
## - subject_test and subject_tran identify which of the 30 subjects participated in each observation
## - y_test and y_train contain the activity index for each observation
## - X_test and X_train contain all measurements associated with each observation

## - in this script, dataframes with lower_case_underscores represent data read directly from data inputs
## - in this script, dataframes with camelCase represent data created by the script

## Read the basic files provided in the data set. Pay attention to the directory structure.
activity_labels <- read.table("activity_labels.txt", sep=" ")
features <- read.table("features.txt", sep=" ")

## Observations during testing phase
subject_test <- read.table("test/subject_test.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

## Observations during training phase
subject_train <- read.table("train/subject_train.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

## With all files read, assign names to each column according to descriptions in features file
names(X_test) <- features[,2]
names(X_train) <- features[,2]

## Find all columns containing the text "mean" or "std"
## We will use the relevant_col vector to select only those columns measuring mean and standard deviation
meanCol <- grep("mean", features[,2])
stdCol <- grep("std", features[,2])
matchingCol <- append (meanCol, stdCol)
## There are numerous calls that are mean Frequency, and should not be in the tidy data set
removeCol <- grep("meanFreq", features[,2])
## Using setdiff is acceptable here since removeCol is clearly a subset of matchingCol
relevantCol <- setdiff(matchingCol, removeCol)
relevantCol <- sort(relevantCol)

## Now, subset both X_train and X_test to contain only mean and std columns
X_test <- X_test[,relevantCol]
X_train <- X_train[,relevantCol]

## Create a vector with the Activity Description for each observation 
yTestActivity <- activity_labels[y_test[, 1],2]
## Add this column to the measurements data frame and give it a column name
X_test <- cbind(yTestActivity, X_test)
names(X_test)[1] <- "Activity"

## Add the Activity Descriptions for the training set too
yTrainActivity <- activity_labels[y_train[, 1],2]
X_train <- cbind(yTrainActivity, X_train)
names(X_train)[1] <- "Activity"

## Add a column to X_test identifying the type of observation, because we will soon merge with the 
## training file and lose this information
X_test <- cbind(ObservationType="Test", X_test)
## Add the subject identifer column to X_test
X_test <- cbind(subject_test, X_test)
names(X_test)[1] <- "Subject"

## Similar operations to those above, but for the X_train data set
X_train <- cbind(ObservationType="Train", X_train)
X_train <- cbind(subject_train, X_train)
names(X_train)[1] <- "Subject"

## OK, now we've got all the data and column headings in each data set
## Time to merge them into one data set using rbind
X_obs <- rbind(X_test, X_train)

library(dplyr)
## We will use dplyr to do some grouping, summarizing and tidying up

X_copy <- X_obs

## group the copy data set by Subject and Activity
X_copy <- group_by(X_copy, Subject, Activity)
## get the mean for each feature across all observations, summarized by Subject and Activity
X_summary <- summarise_each(X_copy, "mean")
## To tidy up a bit, remove the ObservationType column, since the mean is pointless here
X_summary <- select(X_summary, -(ObservationType))

## cleanup
rm(activity_labels)
rm(features)
rm(subject_test)
rm(subject_train)
rm(y_test)
rm(y_train)
rm(X_train)
rm(X_test)
rm(X_copy)
rm(matchingCol)
rm(meanCol)
rm(relevantCol)
rm(removeCol)
rm(stdCol)
rm(yTestActivity)
rm(yTrainActivity)
