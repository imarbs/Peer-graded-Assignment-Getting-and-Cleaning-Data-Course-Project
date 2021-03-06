---
title: "Codebook"
author: "Ivan Art Marbas"
date: "January 19, 2018"
output: html_document
---



*******

###Backgroungd and Data Source

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to, from the course website, represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

###Process towards achieving the final Tidy dataset

Through the R script called `run_analysis.R` the following steps were performed (as indicated in the script) in order to obtain the final Tidy dataset:

1. Merge the training and the test sets to create one data set.

```
        ###bind rows using dplyr, in the order of (train, test)
            
        subject <- bind_rows(train_subject, test_subject)
        colnames(subject) <- "subject"
            
        activity <- bind_rows(train_activity, test_activity)
        colnames(activity) <- "activity"
            
        dt <- bind_rows(train_dt, test_dt)
        
        ###bind the columns of the three tibbles
            
        dt_all <- bind_cols(subject, activity, dt)
```

2. Extract only the measurements on the mean and standard deviation for each measurement.
```
        features <- read.table("./features.txt")
        
        mean_sd_index <- grep("mean\\(\\)|std\\(\\)", as.vector(features[,2]))
        
        dt_mean_sd <- dt_all[, c(1,2, mean_sd_index + 2)]
```

3. Use descriptive activity names to name the activities in the data set
```
        activitynames <- as_tibble(read.table("./activity_labels.txt"))
        
        colnames(activitynames) <- c("activity", "activityname")
        
        dt_activity <- dt_mean_sd %>% left_join(activitynames, by = "activity")
        
        ###rearrange the columns to put activitynames in the 2nd column
        dt_activity <- dt_activity %>% select(subject, activity, activityname, 
                            everything()) %>% select(-activity)
```
4. Appropriately labels the data set with descriptive variable names.
```
        names(dt_activity) <- c(names(dt_activity[1:2]),as.vector(features[mean_sd_index,2]))
```
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```
        dt_tidy2 <- dt_activity %>% group_by(subject, activityname) %>% summarise_all(mean) %>% gather("Measurement", "Average", -subject, -activityname )
```


###Tidy dataset variable list and descriptions

Variables     | Description    | Remarks
------------- | -------------  | -------------
Subject       | ID the subject who performed the activity for each window sample  | Its range is from 1 to 30.
activityname  | Activity Name  | e.g. Walking, Standing, etc.
Measurement   | Name of Feature being measured  | Pls. refer to the dataset for the full list and description of the features
Average       | Average value of the measurement  | 



******
