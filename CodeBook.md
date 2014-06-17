### Data Source
The data is downloaded from the URL https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip The description for the original research project that generated this data set can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The original README.txt file included in the archive provides more detailed explanations of the original data, and directs you to the other included text files explaining subsets of that data.

### Transformation Steps
1. Test and train data for the sensor input features (X), output classification labels (y), and subjects is read into separate data.tables. Columns in both X datatables are named accordingly to the file features.txt of the original data.
2. since the x-train and x-test data tables contain the observation of the same features (they have same columns), the rows are merged into X dataset. the same is done for Y and subject data sets respectvely.
3. the information from activity.txt is used to give the activities in the dataset readable names.
4. since nth row in x (features) corresponds to nth row in Y (classification label) and to the nth subject, the columns of X,Y and subject and combined into a single dataset which contains all the data.
5. columns contining mean() or std() are extracted
6. the mean is calculated for all the features grouped by activity and subject. columns are renamed to make clear that mean was calculated (Example: column 'X' becomes 'mean(X)') 
