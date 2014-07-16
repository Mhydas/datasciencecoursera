Getting and Cleaning Data 
===================================================================

What Data Does This Script Use?
-------------------------------------------------------------------

This script relies on "Human Activity Recognition Using Smartphones Dataset, Version 1.0," which is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Further information about the original dataset can be found in the README.txt within. Alternatively, a description of the data and project can be seen [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

What Does The Script Do?
-------------------------------------------------------------------

This script assumes the following:

    *The "UCI Har Dataset" is your working directory in R
    *The initial file structure of the unzipped directory is unaltered

This script accomplishes the following (more detail can be seen in the actual comments to [run_analysis.R](https://github.com/Mhydas/GetCleanData/blob/master/run_analysis.R)):

    * Merges the training dataset with the test dataset
    * Keeps only the variables for mean() and std()
    * Label each variable with an appropriate name
    * Add identifier for each type of activity
    * Add identifier for each subject
    * Create a tidy data set with the following attributes:
      * Average of each variable
      * By subject
      * By activity
    * Optional(code is commented out by default)  - Creates a .txt file of the new tidy dataset, which is 
    also contained in this project        

Codebook
-------------------------------------------------------------------
You can see the descriptions/detail of the tidy dataset in the CodeBook, [here](https://github.com/Mhydas/GetCleanData/blob/master/CodeBook.md).