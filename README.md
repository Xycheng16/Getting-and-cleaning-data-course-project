# Getting-and-cleaning-data-course-project
UCI HAR dataset

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. This project is to work with data collected from the accelerometers from the Samsung Galaxy S smartphone.

This repository contains the following files:
  - Readme.md    Summary of this project
  - Codebook.md  Contains the content of the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
  - run_analysis.R  which does the following:
      1. Merges the training and the test sets to create one data set.
      2. Extracts only the measurements on the mean and standard deviation for each measurement.
      3. Uses descriptive activity names to name the activities in the data set
      4. Appropriately labels the data set with descriptive variable names.
      5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each           activity and each subject.
  - tidy_data.txt  contains the data get from step 5 above.
  
The data implements also include thte steps of downloading and unzipping the source files and reading data into R.
