Code Book - Human Activity Recognition Using Smartphones Dataset

Overview:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

The original data set was provided here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

An R script was performed on this data set to perform a tidy data set as a result.  Several data files in the source were combined so that:
- all relevant data from a single observation appeared on a single row
- any data not related to mean or standard measurements was removed
- meaningful names for activities were substituted for numeric identifiers

A more detailed description of the cleaning process can be found in the associated README.md file.


For each record in the resulting data set, the following data are provided:

- Subject (Col. 1): A numeric identifier indicating which subject was being observed (1 - 30)
- ObservationType (Col. 2): Descriptive text identifying the phase under which this observation occurred ("Test" or "Train")
- Activity (Col. 3): Descriptive text identifying the type of activity ("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

** Note - All measurements presented below are unitless. The data for each measurement has been normalized into a range of [-1,1]

- The data set contains both mean and standard deviation in three axial dimensions for following variables.  For each of these measurements, two statistics (mean, standard deviation) are supplied for measurements in 3 directions (x, y, x), thus there are six columns per measurement.

tBodyAcc (Col 4-9)
tGravityAcc (Col. 10-15)
tBodyAccJerk (Col. 16-21)
tBodyGyro (Col. 22-27)
tBodyGyroJerk (Col. 28-33)
fBodyAcc (Col. 44-49)
fBodyAccJerk (Col. 50-55)
fBodyGyro (Col. 56-61)

- Mean and Standard Deviation pairs are supplied for each of these measurements:
tBodyAccMag (Col. 34-35)
tGravityAccMag(Col. 36-37)
tBodyAccJerkMag(Col. 38-39)
tBodyGyroMag(Col. 40-41)
tBodyGyroJerkMag(Col. 42-43)
fBodyAccMag (Col. 62-63)
fBodyAccJerkMag (Col. 64-65)
fBodyGyroMag (Col. 66-67)
fBodyGyroJerkMag (Col. 68-69)