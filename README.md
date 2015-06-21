

# Getting-and-Cleaning-Data-Course-Project
Getting and Cleaning Data Course Project

##Summary
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

## What did the analysis do?

Using the data from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, the analysis:

  *  Merges the training and the test sets to create one data set.
  *  Extracts only the measurements on the mean and standard deviation for each measurement. 
  *  Uses descriptive activity names to name the activities in the data set
  * Appropriately labels the data set with descriptive variable names. 

  * From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Practical information

The  script takes the original files from the working directory. The script saves the data frame from step 5 in the working directory as "Question5.txt"