Getting and Cleaning Data Course Project
Purpose

This code book describes the variables, the data, and data cleaning steps.

Source Data

Detailed information regarding the raw data can be found here. Data can be downloaded here.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Variables Information

Each record in the data set contains the following information:

Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.
Data Cleansing Steps

Step 1: Merge the training and the test sets to create one data set

First, set working directory to the location where you unzipp the data files from UCI Machine Learning Repo.

Then read into the following tables to R:

features.txt
activity_labels.txt
subject_train.txt
x_train.txt
y_train.txt
subject_test.txt
x_test.txt
y_test.txt
Next, assign column names.

Finally, merge both training and test sets to create one data set.

Step 2: Extract only the measurements on the mean and standard deviation for each measurement

Create a logical vector to get the activity_id, subject_id, and mean and standard deviation for the measurements.

Step 3: Use descriptive activity names to name the activities in the data set

Merge activity_lables table to get the descriptive activity names.

Step 4: Appropriately label the data set with descriptive activity names

Use gsub() clean up the column names.

Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject

Export a tidy data set that contains the average of each variable by activity id and each subject id.
