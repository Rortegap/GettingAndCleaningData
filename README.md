Course Project
Introduction

This repository contains the scripts and the result for the project of the course of getting and cleaning data.

Source data

The measures are unlabeled and can be found in the x_test.txt. The labels are in the y_test.txt file. 
The test subjects are in the subject_test.txt file.

The same  is for the training set.

About the script and the tidy dataset

The scriot run_analysis.R will merge the test and training sets together. Prerequisites for this script:

UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset" (Inside the working directory)

After merging testing and training datasets, the labels are added and only columns that have to do with mean and standard deviation are kept.

Lastly, the script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset can also be found in this repository.

The CodeBook.md file explains the transformations performed and the resulting data and variables.