# Getting and Cleaning Data Project

### Creating a tidy dataset from the UCI HAR dataset

### by Horácio Pires
### April 11, 2020

In this repository you will find these files:

* Codebook.md - brief explanation regarding each of the attributes from the datasets.
* tidy_dataset_2.txt - second tidy datased prepared with the mean of all attributes grouped by subject and activity.
* getdata-projectfiles-UCI_HAR_Dataset.zip - UCI HAR dataset raw data.
* run_analysis.R - An R script that creates both tidy data sets from the raw dataset.

## Instructions
* Extract the zip file for a folder called "data".
* Set you workind directory to the parent folder of "data"
* The run_analysis.R file should be placed in the parent folder.

## run_analysis.R explanation

### When running run_analysis.R, the following operations are done to the UCI HAR raw data:
* The files from the raw dataset are loaded.
* Get feature names from "features.txt".
* Get activities names from "activities.txt"

* Read the test dataset - 2947 rows
  + Feature values (test/X_test.txt) (561 columns)
  + Test labels (test/X_test.txt) (1 column)
  + Test subjects (train/subject_test.txt)(1 column)
  + Bind "subject" and "activity" as features.
  + Merge columns

* Read the training dataset - 7352 rows
  + Feature values (train/X_train.txt) (561 columns)
  + Training labels (train/y_train.txt) (1 column)
  + Training subjects (train/subject_train.txt) (1 column)
  + Bind "subject" and "activity" as features.
  + Merge columns


* Merge the "Training" and "Test" datasets - Resulting dataset has 10299 rows and 563 columns
* Assigning the names to the columns of the full dataset.
* Convert the activity column to factor and assigning the levels from the activity_labels.txt file


* Selecting the columns with mean and standard deviation of the measurements
  + Getting columns where the string "mean()" appears. Since in the some columns with string "meanFreq()" were also selected, they were removed by doing the setdiff operation afterwards.
  + Getting the columns with the string "std()"
 
* Get tidy dataset by subsetting with the desired features, subject, activities, mean and std columns.  
* Sort the datasets by subject and by activity performed.

* Create a second tidy dataset using dplyr group_by function, grouped by subject and activity.
* Summarize the data, using summarise_each dplyr function, applying mean() function to all non grouped features.


* Creates tidy data set *(tidy_dataset_2.txt)* with the average of each variable for each activity and each subject. 

* Print in the console the *tidy_dataset* composed of subject, observation_number activity and the columns with mean() and std() - total of 69 columns.
