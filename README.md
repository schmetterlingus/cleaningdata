# course
Peer Graded Assignment: Getting and Cleaning Data Course Project

# files
* run_analysis.R - R script
* README.md - general description
* CODEBOOK.md - codebook for created datasets
* datasets (file availible at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

# assigment
Create one R script called run_analysis.R that does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
# run_analysis.R
run_analysis.R script is a simple straightforward script that creates two datasets:
* data_all (extracted measurements from datasets accoriding to steps 1-4)
* tidy_data (simplified data_all, according to step 5)
