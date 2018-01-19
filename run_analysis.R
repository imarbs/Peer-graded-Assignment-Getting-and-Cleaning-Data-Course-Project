library(tidyverse)
library(markdown)
library(knitr)

##set the working directory
setwd("Z:/Machine Learning/project/UCI HAR Dataset")

##read data;
    ###subject = identifies the subject who performed the activity for each window sample
    ###y = test activity labels
    ###x = test set (data)
        train_dt <- as_tibble(read.table("./train/X_train.txt"))
        train_subject <- as_tibble(read.table("./train/subject_train.txt"))
        train_activity <- as_tibble(read.table("./train/y_train.txt"))
        
        test_dt <- as_tibble(read.table("./test/X_test.txt"))
        test_subject <- as_tibble(read.table("./test/subject_test.txt"))
        test_activity <- as_tibble(read.table("./test/y_test.txt"))

##1.Merges the training and the test sets to create one data set.
        
    ###bind rows using dplyr, in the order of (train, test)
        
        subject <- bind_rows(train_subject, test_subject)
        colnames(subject) <- "subject"
        
        activity <- bind_rows(train_activity, test_activity)
        colnames(activity) <- "activity"
        
        dt <- bind_rows(train_dt, test_dt)
    
    ###bind the columns of the three tibbles
        
        dt_all <- bind_cols(subject, activity, dt)
        
        
##2. Extracts only the measurements on the mean and standard deviation for each measurement.
        
        features <- read.table("./features.txt")
        
        mean_sd_index <- grep("mean\\(\\)|std\\(\\)", as.vector(features[,2]))
        
        dt_mean_sd <- dt_all[, c(1,2, mean_sd_index + 2)]

##3. Uses descriptive activity names to name the activities in the data set
        
        activitynames <- as_tibble(read.table("./activity_labels.txt"))
        
        colnames(activitynames) <- c("activity", "activityname")
        
        dt_activity <- dt_mean_sd %>% left_join(activitynames, by = "activity")
        
        ###rearrange the columns to put activitynames in the 3rd column
        dt_activity <- dt_activity %>% select(subject, activity, activityname, 
                            everything()) %>% select(-activity)
        
        

##4. Appropriately labels the data set with descriptive variable names.
        
        names(dt_activity) <- c(names(dt_activity[1:2]),as.vector(features[mean_sd_index,2]))

        

##5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
        
        dt_tidy2 <- dt_activity %>% group_by(subject, activityname) %>% summarise_all(mean) %>% gather("Measurement", "Average", -subject, -activityname )
        
        ###Save tidy dataset to file
        write.csv(dt_tidy2, "dt_tidy2.txt")
        
##Coverting Codebook and README from rmd to md
        
        knit("./codebook.Rmd", output = "codebook.md", encoding = "ISO8859-1", quiet = TRUE)
        markdownToHTML("codebook.md", "codebook.html")
        knit("README.Rmd", output = "README.md", encoding = "ISO8859-1", quiet = TRUE)
        markdownToHTML("README.md", "README.html")
        