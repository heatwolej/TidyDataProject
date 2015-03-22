# TidyDataProject

==================================================================
Final Project for Coursera "Getting and Cleaning Data"
==================================================================
Student: Jeff Heatwole
Charlottesville, VA, USA
Github: heatwolej ( https://github.com/heatwolej/TidyDataProject )
================================================================== 
Overview:
This readme file will explain the methodology and assumptions used in preparing and submitting the final artifacts for the course project.  In this project, the objective was to work with raw data submitted from human activity recognition experiments done with Smartphone and to combine, clean up, and summarize this information into two data sets that adhere to the principles of tidy data and are ready to be used for additional analysis.

The submitted data includes the following files:
*	runAnalysis.R: an R language script that can be used to generate the resulting data sets and text files that will be described below.
*	observations.txt: a tidy data table presenting all mean and standard variation measurements for each variable collected for each observation of the experiments.
-	summary_data.txt: a second tidy data table that provides the mean of all observations recorded for a specific subject performing a specific activity.
================================================================== 
Usage:

In order to use this data set, the following environment is needed:
*	The most recent version of “R” should be installed and working in the target environment
*	The following data set should be downloaded and unzipped in the target environment
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
-	The runAnalysis.R script should be saved in the same root directory/folder where the files above were unzipped.
================================================================== 
Inputs:

The following raw files exist in the input data:

Activity_labels – Descriptive text is included for each of the unique numeric activity values. 
Features – Features contains descriptive text for each of the 561 measurement types that are reported 
For each observation.
Directory test:
	X_test:  561 measured values for each of 2947 observations of individual subjects performing activities during a testing phase.
	Y_test:  a value 1 to 6 indicating which specific activity during the testing phase.
	Subject_test:  a numeric value 1 to 30 identifying the subject that was being observed during the testing phase
	Subdirectory intertial: more detailed data that was not required to complete this exercise.
Directory train:
	X_train:  561 measured values for each of 2947 observations of individual subjects performing activities during a training phase.
	Y_train:  a value 1 to 6 indicating which specific activity during the training phase.
	Subject_train:  a numeric value 1 to 30 identifying the subject that was being observed during the training phase
	Subdirectory intertial: more detailed data that was not required to complete this exercise.
================================================================== 
Requirements definition for this assignment:

The assignment specifically required demonstration of the following objectives:

 You should create one R script called run_analysis.R that does the following.  The parenthetical values are created as requirement numbers that will be referenced below…

*	Merges the training and the test sets to create one data set [R-1].
*	Extracts only the measurements on the mean and standard deviation for each measurement [R-2].
*	Uses descriptive activity names to name the activities in the data set [R-3].
*	Appropriately labels the data set with descriptive variable names [R-4].
*	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject [R-5].

Please upload the tidy data set created in step 5 of the instructions. Please upload your data set as a txt file created with write.table() using row.name=FALSE (do not cut and paste a dataset directly into the text box, as this may cause errors saving your submission).
================================================================== 
Methodology in runAnalysis.R:

The following steps were involved in the implementation process:
*	After reading in each of the sets described above into a data frame, use the “names” command to assign column names in X_test and X_train from the features data frame. [R-4]

*	Use the “grep” command to define a vector with feature names (now column names) that contain the strings “mean” or “std”

*	Use the “grep” command again to find feature names with “meanFreq”.  Reading the Step 2 objective above, an assumption was made that the desired measurements are {mean, std} pairs for the same variable.  Therefore, the “meanFreq” columns will not be retained since they do not have a std counterpart.

*	Use setdiff to find the desired set of columns, and then sort that set of columns in ascending order so that {mean, std} pairs will stay ordered as they were in the original data frame.

*	Subset both X_test and X_train so that only the desired columns are retained. [R-2]
*	Use the cbind command to add the text description of activity_labels for each row in X_test and X_train [R-3]

*	Use the cbind command to add the subject_test and subject_train vectors to X_test and X_train, respectively.

*	** Note: one additional step was added that was not required.  For each data set (X_test, X_train), an additional column was added called ObservationType that would distinguish which source the observation came from (TEST or TRAIN).  This was done because this distinction will be lost in the next step, and it is unknown whether or not future analysis will need the information.

*	Use the rbind command to create one data set from all collected observations in both the test and train data sets.  Call this data set X_obs [R-1]

*	Now, load the dplyr library for some grouping and summary statistics.  

*	Make a copy of the resulting X_obs data set from above, and use the group_by feature of dplyr to group by both Subject and Activity columns.

*	Use the summarise_each capability of dplyr (with second argument “mean”)  to calculate the average of each column.

*	Because we kept the ObservationType column as described above, we get a meaningless column in the data set returned by summarise_each.  Remove it.

================================================================== 
Outputs:
Two tidy data sets are available at the end of this process.
X_obs: For each of 10,299 rows describes an observation that identifies:
*	The subject identifier
*	A description of the observed activity
*	Whether this observation occurred during testing or training
*	Each of 66 measurements involving mean or standard deviation.
X_summary: There were 60 subjects, each performing 6 activities.  Each row in this data set  contains values related to each unique subject/activity pair.  Since 6 x 30 = 180, there are 180 rows, each containing:
*	The subject identifier
*	A description of the observed activity
*	The average across all observations for the subject/activity pair for each of the 66 measurements involving mean or standard deviation.
