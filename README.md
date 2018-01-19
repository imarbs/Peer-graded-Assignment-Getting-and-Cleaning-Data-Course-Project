---
title: "README"
author: "Ivan Art Marbas"
date: "January 19, 2018"
output: html_document
---


#Project for Getting and Cleaning Data

### Parameters for the Project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

An R script called `run_analysis.R` is created that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Steps to reproduce this project

1. Open the R script `run_analysis.r` using a text editor.
2. Change the parameter of the `setwd` function call to the working directory/folder (i.e., the folder where these the R script file is saved).
3. Run the R script `run_analysis.r`. It calls the R Markdown file, run_analysis.Rmd, which contains the bulk of the code.

###Outputs Produced

1. Tidy dataset file `dt_tidy2`
2. Codebook file `codebook.md`
3. README file `README.md`
4. R script that produced the Tidy dataset `run_analysis.R`




********
