# Getting-and-cleaning-data-Course-Project

The script run_analysis.R does the following

- reads the feature test/train data and the subjects and activities
- adds the subject and activity data as the first two columns
- concatenates the test and train data
- using a index vector based on the features.txt file,
  extracts mean and std feature values, and also the first two columns
- replaces the activity levels with proper descriptions
- reads the feature descriptions from features.txt
- names the columns of the data set with the descriptions
- creates a data table from the data
- calculates the mean values of the columns, grouped by subject and activity
- saves the tidy dataset
