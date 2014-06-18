### Data Source
The data is downloaded from the URL https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip The description for the original research project that generated this data set can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The original README.txt file included in the archive provides more detailed explanations of the original data, and directs you to the other included text files explaining subsets of that data.

Each person performed 6 activities. The file activity_labels.txt in the source dataset for the activities

The observations are split in 3-3 files for each group:

train/X_train.txt and test/X_test.txt contain the measurements,

train/y_train.txt and test/y_test.txt list the activity codes for the measurements,

rain/subject_train.txt and test/subject_test.txt list the identifier of the subjects of the measurements.

### Transformation Steps
1. Test and train data for the sensor input features (X), output classification labels (y), and subjects is read into separate data.tables. Columns in both X datatables are named accordingly to the file features.txt of the original data.
2. since the x-train and x-test data tables contain the observation of the same features (they have same columns), the rows are merged into X dataset. the same is done for Y and subject data sets respectvely.
3. the information from activity.txt is used to give the activities in the dataset readable names.
4. since nth row in x (features) corresponds to nth row in Y (classification label) and to the nth subject, the columns of X,Y and subject and combined into a single dataset which contains all the data.
5. columns contining mean() or std() are extracted
6. the mean is calculated for all the features grouped by activity and subject. columns are renamed to make clear that mean was calculated (Example: column 'X' becomes 'mean(X)') 


### Output
A dataset containing following columns::

Subject: name of the subject

Activity: name of the activity corresponding activity

Measurement variables: average of the respective variable for the given subject and activity. Out of the 561 original variables, only those containing mean and standard deviation are present (67). Column names match the names of the original measurement variables surrounded with mean(...), eg. column containing the mean of the original column 'tBodyAcc-mean()-X' for given person and activity is called in the new dataset 'mean(tBodyAcc-mean()-X)'.